from typing import Dict

from fastapi import FastAPI, HTTPException
from starlette.middleware.cors import CORSMiddleware

from db_service import DBService

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


@app.get("/topics/all")
async def get_all_topics():
    """Get all available topic names"""
    db = DBService()
    return db.get_all_topic_names()


@app.get("/topics")
async def get_topic_by_name(name: str) -> Dict:
    """Retrieve topic details by its name.
    Args:
        name: name of the topics
    Return:
        Dictionary about the topic, or None if not found.
    """
    db = DBService()
    return db.get_topic_details(name)
