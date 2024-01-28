"""Tool to load topics data into database.
It will go through each topic defined in `topic_data.json` and call ChatGPT if needed.
"""

import json
from typing import List, Optional

from langchain.prompts import PromptTemplate
from langchain_core.output_parsers import JsonOutputParser
from langchain_core.pydantic_v1 import BaseModel, Field
from langchain_openai import ChatOpenAI

from db_service import DBService


class Concept(BaseModel):
    id: int
    description: str


class Problem(BaseModel):
    id: int
    name: str
    url: str


class Topic(BaseModel):
    id: int
    name: str
    concepts: List[Concept]
    problems: List[Problem]


class LlmTopic(BaseModel):
    concept: str = Field(description="Explanation of the concept for an algorithm")
    problems: list[dict[str, str]] = Field(description="List of leetcode problems")


class TopicLoader:
    def __init__(self):
        # Set up a parser + inject instructions into the prompt template.
        self.llm_model = ChatOpenAI(temperature=0)
        self.llm_parser = JsonOutputParser(pydantic_object=LlmTopic)
        self.llm_prompt = PromptTemplate(
            template="""
        You are a professional instructor for software algorithms. 
        We will give you a topic name for an algorithm. 
        Then you will give me the elaborated concept and a list of up to 5 LeetCode problems with name and URL. 
        \n{format_instructions}\n{topic}\n""",
            input_variables=["topic"],
            partial_variables={"format_instructions": self.llm_parser.get_format_instructions()},
        )

    def load_topics_from_db(self) -> list[Topic]:
        """Query DB to load all topics"""
        dbservice = DBService()
        topic_name_list = dbservice.get_all_topic_id_names()
        assert len(topic_name_list) > 0

        all_topics_loaded = []
        for topic_id, topic_name in topic_name_list:
            # load each topic
            topic_dict = dbservice.get_topic_details(topic_name)
            if topic_dict:
                all_topics_loaded.append(Topic(**topic_dict))
        return all_topics_loaded

    def fetch_topic_content(self, topic_name: str) -> Optional[Topic]:
        """Fetch topic content from cache if available. Generate it using LLM if needed.
        Args:
            topic_name: Name of the topic.
        Returns:
            Detailed topic information.
        """
        # Find from cache first
        matched_topic = next((t for t in self.all_topics if t.name == topic_name), None)
        if not matched_topic:
            return matched_topic

        # No content found. Try LLM.
        return self.generate_topic_content_from_llm(topic_name)

    def generate_topic_content_from_llm(self, topic_name: str) -> Optional[Topic]:
        """Call ChatGPT to load a topic. Avoid this whenever possible due to the cost."""
        # Use langchain
        chain = self.llm_prompt | self.llm_model | self.llm_parser
        res_json = chain.invoke({"topic": topic_name})
        topic = LlmTopic(**res_json)
        return Topic(id=-1,
                     name=topic_name,
                     concepts=[Concept(id=-1, description=topic.concept)],
                     problems=[Problem(**p, id=-1) for p in topic.problems])

    def load_configured_topics(self, config_file: str) -> list[str]:
        """Return a list of topic name from config file"""
        with open(config_file, 'r') as file:
            data = json.load(file)
            topics = [item['topic'] for item in data if 'topic' in item]
        return topics

    def sync_all_topics(self, config_file: str) -> None:
        """Based on the list of topics in config file, load new topics into DB
        Step 1 - Get the list of topic names to be checked.
        Step 2 - Load exiting topics from DB.
        Step 3 - If any topic is missing in result from Step 2, call LLM to generate it.
           Step 3.1 - for newly generated topic, CREATE the entry in DB.
        """
        all_topic_names_needed: list[str] = self.load_configured_topics(config_file)
        all_topics_from_db: list[Topic] = self.load_topics_from_db()
        # Use set for quick search
        all_topic_names_from_db = set(t.name for t in all_topics_from_db)

        dbservice = DBService()
        for topic_name in all_topic_names_needed:
            if topic_name and topic_name in all_topic_names_from_db:
                continue  # in DB already
            # not in DB. Ask LLM for help
            print(f"Calling LLM to load topic - {topic_name}")
            new_topic: Topic = self.generate_topic_content_from_llm(topic_name)
            # TODO: Create in DB
            dbservice.upsert_topic(new_topic)