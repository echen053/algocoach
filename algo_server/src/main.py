from typing import Dict

from fastapi import FastAPI, HTTPException
from starlette.middleware.cors import CORSMiddleware

app = FastAPI()

# WARNING: This is for local debug only
# Allow all origins during development (replace "*" with the actual origin of your Flutter app)
# origins = ["http://localhost:8000", "http://127.0.0.1:8000"]
origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

ALL_TOPICS = [
    {
        "name": "BFS",
        "concept": {
            "name": "BFS Concept",
            "description": "BFS is like flood fill.",
        },
        "problems": [
            {
                "name": "P1.1",
                "url": "http:p1.1",
            },
            {
                "name": "P1.2",
                "url": "http:p1.2",
            },
        ],
    },
    {
        "name": "DFS",
        "concept": {
            "name": "DFS Concept",
            "description": "DFS is popular.",
        },
        "problems": [
            {
                "name": "P2.1",
                "url": "http:p2.1",
            },
            {
                "name": "P2.2",
                "url": "http:p2.2",
            },
        ],
    },
    {
        "name": "Topological Sorting",
        "concept": {
            "name": "Topological Sorting Concept",
        },
        "problems": [
            {
                "name": "P3.1",
                "url": "http:p3.1",
            },
            {
                "name": "P3.2",
                "url": "http:p3.2",
            },
        ],
    },
]


@app.get("/topics/all")
async def get_all_topics():
    """Get all available topic names"""
    return [t["name"] for t in ALL_TOPICS]


@app.get("/topics")
async def get_topic_by_name(name: str) -> Dict:
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
