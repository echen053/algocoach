from dotenv import load_dotenv
import os
import pytest

from tool.load_topics import TopicLoader, Topic

import openai

from unittest.mock import patch, Mock


@pytest.fixture
def test_db_file():
    yield '../db/coach.db'


@pytest.fixture
def topic_loader_real(test_db_file):
    yield TopicLoader(test_db_file)  # replace with actual instantiation


@pytest.fixture
def topic_loader_with_mocked_llm(test_db_file):
    with patch('tool.load_topics.ChatOpenAI') as mock_chat_openai:
        # Mock the constructor to return a Mock object
        mock_chat_openai.return_value = Mock()

        # Create an instance of TopicLoader which will use the mocked ChatOpenAI
        yield TopicLoader(test_db_file)


@pytest.fixture
def openai_instance():
    load_dotenv()
    openai.api_key = os.getenv("OPENAI_API_KEY")


@pytest.fixture
def mocked_llm_response():
    faked_llm_data = {
        'concept': 'Depth First Search (DFS) is a graph traversal algorithm that explores as far as possible along each branch before backtracking. It starts at a given node (usually the root) and explores as far as possible along each branch before backtracking.',
        'problems': [{'name': 'Number of Islands', 'url': 'https://leetcode.com/problems/number-of-islands/'},
                     {'name': 'Word Search', 'url': 'https://leetcode.com/problems/word-search/'},
                     {'name': 'Surrounded Regions', 'url': 'https://leetcode.com/problems/surrounded-regions/'},
                     {'name': 'Path Sum', 'url': 'https://leetcode.com/problems/path-sum/'},
                     {'name': 'Binary Tree Paths', 'url': 'https://leetcode.com/problems/binary-tree-paths/'}]}
    yield faked_llm_data


@pytest.fixture
def langchain_chain_invoke(mocked_llm_response):
    with patch("langchain_core.runnables.base.RunnableSequence.invoke") as invoke_func:
        invoke_func.return_value = mocked_llm_response
        yield invoke_func


# @pytest.mark.skip
def test_fetch_topic_from_mocked_llm(mocked_llm_response,
                                     openai_instance,
                                     topic_loader_real,
                                     langchain_chain_invoke):
    # Call the method
    topic_name = "Test Topic"
    result = topic_loader_real._generate_topic_content_from_llm(topic_name)

    # Verify the result
    assert result.name == topic_name
    assert result.concepts[0].description == mocked_llm_response["concept"]
    assert result.problems[0].name == "Number of Islands"
    assert result.problems[1].name == "Word Search"
    assert result.problems[0].url == mocked_llm_response["problems"][0]["url"]

    # Verify that chain.invoke was called with the correct argument
    langchain_chain_invoke.assert_called_once_with({"topic": topic_name})


@pytest.mark.skip(reason="it costs money to run so disable it by default")
def test_fetch_topic_from_real_llm(openai_instance, topic_loader_real):
    topic_name = "Depth First Search"
    topic = topic_loader_real.generate_topic_content_from_llm(topic_name)
    assert topic is not None
    assert topic.name == topic_name
    assert len(topic.concepts) == 1
    assert len(topic.concepts[0].description) > 10
    assert len(topic.problems) > 0


def test_load_topics_from_db(topic_loader_with_mocked_llm):
    all_db_topics = topic_loader_with_mocked_llm.load_topics_from_db()
    assert len(all_db_topics) > 0
    assert isinstance(all_db_topics[0], Topic)


def test_sync_all_topics_dry_run(openai_instance, topic_loader_real, langchain_chain_invoke):
    config_file = "test_topic_data.json"
    topic_loader_real.sync_all_topics(config_file)


def test_sync_all_topics_with_llm(openai_instance, topic_loader_real):
    config_file = "../src/tool/topic_data_all.json"
    topic_loader_real.sync_all_topics(config_file)
