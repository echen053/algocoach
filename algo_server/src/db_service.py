import sqlite3


class DBService:
    def __init__(self, db_name: str = 'db/coach.db'):
        self.conn = None
        self.db_name = db_name

    def connect(self):
        # Establish a connection to the SQLite database
        self.conn = sqlite3.connect(self.db_name)
        return self.conn

    def disconnect(self):
        # Close the database connection
        if self.conn:
            self.conn.close()

    def get_all_topic_id_names(self) -> list[tuple[int, str]]:
        """Retrieve all db record of (topic_id, topic_name) pair"""
        try:
            # Connect to the database
            self.connect()

            # Create a cursor
            cursor = self.conn.cursor()

            # Execute the SQL query to select all topic names
            cursor.execute('SELECT id, name FROM Topic')

            # Fetch all the rows
            id_names = cursor.fetchall()

            # Close the cursor
            cursor.close()

            return [id_name_pair for id_name_pair in id_names]  # Extract names from the result

        except sqlite3.Error as e:
            print(f"SQLite error: {e}")
            return []

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

    def get_topic_details(self, topic_name: str) -> dict | None:
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

    def upsert_topic(self, topic: dict) -> bool:
        """Upsert (insert if row doesn't exit, update if it does."""
        try:
            self.connect()

            # Create a cursor
            cursor = self.conn.cursor()

            topic_id = topic.get("id")
            is_insert_mode = topic_id is None or topic_id < 0
            # Insert or update data into the Topic table
            if is_insert_mode:
                topic_values = (topic['name'], topic.get('description', ''))
                cursor.execute('INSERT INTO Topic (name, description) VALUES (?, ?)', topic_values)
                topic_id = cursor.lastrowid
            else:
                assert False, "No update support for now!!!"
                topic_values = (topic['name'], topic.get('description', ''), topic['id'])
                cursor.execute('UPDATE Topic SET name=?, description=? WHERE id=?', topic_values)

            # Insert data into the Concept table
            for concept in topic['concepts']:
                concept_values = (concept['description'], topic_id)
                cursor.execute('INSERT INTO Concept (description, topic_id) VALUES (?, ?)', concept_values)

            # Insert data into the Problem table
            for problem in topic['problems']:
                problem_values = (problem['name'], problem['url'], topic_id)
                cursor.execute('INSERT INTO Problem (name, url, topic_id) VALUES (?, ?, ?)', problem_values)

            # Commit changes and close the connection
            self.conn.commit()
            self.conn.close()
            return True
        finally:
            self.disconnect()

        # failed
        return False
