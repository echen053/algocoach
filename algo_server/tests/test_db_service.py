from db_service import DBService

import pytest


@pytest.fixture()
def topic_name_to_test():
    yield "Depth First Search"


@pytest.fixture()
def dbservice():
    dbs = DBService('../db/coach.db')
    yield dbs


def test_get_all_topic_id_names(dbservice: DBService, topic_name_to_test: str):
    """Test retrieving topic id/name from db"""

    id_name_list = dbservice.get_all_topic_id_names()
    assert len(id_name_list) > 0

    # check one topic existence
    assert any(name == topic_name_to_test for _, name in id_name_list)


def test_get_topic_details(dbservice: DBService, topic_name_to_test: str):
    topic_dict = dbservice.get_topic_details(topic_name_to_test)
    assert topic_dict
    concept = topic_dict["concepts"][0]
    assert len(concept["description"]) > 100

    problems = topic_dict["problems"]
    assert len(problems) > 1

    # Verify attributes of problem
    for p in problems:
        assert set(p.keys()) == {"id", "name", "url"}


def test_upsert_topic(dbservice: DBService):
    new_topic = {
        "name": "Topological Sort",
        "description": "Very useful in interview.",
        "concepts": [
            {
             "description": "DFS explores a graph or tree by going as deep as possible down each branch before backtracking..."}
        ],
        "problems": [
            {"name": "94. Binary Tree Inorder Traversal",
             "url": "https://leetcode.com/problems/binary-tree-inorder-traversal"},
            {"name": "98. Validate Binary Search Tree",
             "url": "https://leetcode.com/problems/validate-binary-search-tree"},
            {"name": "112. Path Sum", "url": "https://leetcode.com/problems/path-sum"}
        ]
    }
    dbservice.upsert_topic(new_topic)
