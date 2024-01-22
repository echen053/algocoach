import sqlite3
from typing import List, Dict, Optional


class DBService:
    db_name = 'db/coach.db'

    def __init__(self):
        self.conn = None

    def connect(self):
        # Establish a connection to the SQLite database
        self.conn = sqlite3.connect(self.db_name)
        return self.conn

    def disconnect(self):
        # Close the database connection
        if self.conn:
            self.conn.close()

    def get_all_topic_names(self):
        try:
            # Connect to the database
            self.connect()

            # Create a cursor
            cursor = self.conn.cursor()

            # Execute the SQL query to select all topic names
            cursor.execute('SELECT name FROM Topic')

            # Fetch all the rows
            topic_names = cursor.fetchall()

            # Close the cursor
            cursor.close()

            return [name[0] for name in topic_names]  # Extract names from the result

        except sqlite3.Error as e:
            print(f"SQLite error: {e}")
            return None

        finally:
            # Disconnect from the database
            self.disconnect()

    def get_all_concepts_for_topic(self, topic_id: int) -> list[dict]:
        try:
            # Connect to the database
            self.connect()

            # Create a cursor
            cursor = self.conn.cursor()

            # Execute the SQL query to select all concepts for the given topic ID
            cursor.execute('''
                SELECT id, description
                FROM Concept
                WHERE topic_id = ?
            ''', (topic_id,))

            # Fetch all the rows
            concepts = cursor.fetchall()

            # Close the cursor
            cursor.close()

            # Organize the results into a list of dictionaries
            return [{'id': row[0], 'description': row[1]} for row in concepts]

        except sqlite3.Error as e:
            print(f"SQLite error: {e}")
            return []

        finally:
            # Disconnect from the database
            self.disconnect()

    def get_all_problems_for_topic(self, topic_id: int) -> list[dict]:
        try:
            # Connect to the database
            self.connect()

            # Create a cursor
            cursor = self.conn.cursor()

            # Execute the SQL query to select all problems for the given topic ID
            cursor.execute('''
                SELECT id, name, url
                FROM Problem
                WHERE topic_id = ?
            ''', (topic_id,))

            # Fetch all the rows
            problems = cursor.fetchall()

            # Close the cursor
            cursor.close()

            # Organize the results into a list of dictionaries
            return [{'id': row[0], 'name': row[1], 'url': row[2]} for row in problems]

        except sqlite3.Error as e:
            print(f"SQLite error: {e}")
            return []

        finally:
            # Disconnect from the database
            self.disconnect()

    def get_topic_details(self, topic_name: str) -> Optional[dict]:
        try:
            # Connect to the database
            self.connect()

            # Create a cursor
            cursor = self.conn.cursor()

            # Execute the SQL query to select concept and problems for the given topic
            cursor.execute('''
                SELECT id, name, description
                FROM Topic
                WHERE name = ?
            ''', (topic_name,))

            # Fetch all the rows
            rows = cursor.fetchall()

            # Close the cursor
            cursor.close()

            if not rows:
                return None  # Topic not found

            # Organize the results into a dictionary
            topic_id, name, description = rows[0]
            topic_details = {
                'id': topic_id,
                'name': name,
                'description': description,
                'concepts': self.get_all_concepts_for_topic(topic_id),
                'problems': self.get_all_problems_for_topic(topic_id),
            }

            return topic_details

        except sqlite3.Error as e:
            print(f"SQLite error: {e}")
            return None

        finally:
            # Disconnect from the database
            self.disconnect()
