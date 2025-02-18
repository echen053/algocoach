import argparse
import os
from ..db_service import DBService

def update_concept_from_file(dbfile: str, topic_name: str, concept_file: str):
    """Update a concept in the database using a file input"""

    # Check if the file exists
    if not os.path.exists(concept_file):
        print(f"Error: File '{concept_file}' not found.")
        return

    # Read the new concept description from the file
    with open(concept_file, 'r', encoding='utf-8') as file:
        new_description = file.read().strip()

    if not new_description:
        print("Error: Concept file is empty.")
        return

    # Use the DBService to update the concept
    db_service = DBService(dbfile)
    success = db_service.update_concept(topic_name, new_description)

    if success:
        print(f"Concept for '{topic_name}' updated successfully.")
    else:
        print(f"Failed to update concept for '{topic_name}'.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Update a topic's concept description in the database.")
    parser.add_argument("--dbfile", required=True, help="Path to the database file")
    parser.add_argument("--topic", required=True, help="Name of the topic to update")
    parser.add_argument("--file", required=True, help="Path to the text file containing the updated concept")

    args = parser.parse_args()
    update_concept_from_file(args.dbfile, args.topic, args.file)
