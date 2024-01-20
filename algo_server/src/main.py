from fastapi import FastAPI, HTTPException

app = FastAPI()

ALL_TOPICS = [
    {
        "name": "BFS",
        "concept": {
            "name": "BFS Concept",
        },
        "problems": [
            "P1.1",
            "P1.2",
        ],
    },
    {
        "name": "DFS",
        "concept": {
            "name": "DFS Concept",
        },
        "problems": [
            "P2.1",
            "P2.2",
        ],
    },
    {
        "name": "Topological Sorting",
        "concept": {
            "name": "Topological Sorting Concept",
        },
        "problems": [
            "P3.1",
            "P3.2",
        ],
    },
]


@app.get("/topics/all")
async def get_all_topics():
    """Get all available topic names"""
    return [t["name"] for t in ALL_TOPICS]


@app.get("/topics")
async def get_topic_by_name(name: str):
    """Retrieve topic details by its name.
    Args:
        name: name of the topics
    Return:
        Dictionary about the topic, or None if not found.
    """
    result = next((item for item in ALL_TOPICS if item['name'] == name), None)
    if not result:
        raise HTTPException(status_code=404, detail="Topic not found")
    return result
