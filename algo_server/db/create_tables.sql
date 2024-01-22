-- Create the Topic table:
CREATE TABLE IF NOT EXISTS Topic (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,
    description TEXT
);

-- Create the Concept table:
CREATE TABLE IF NOT EXISTS Concept (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    description TEXT,
    topic_id INTEGER,
    FOREIGN KEY (topic_id) REFERENCES Topic(id)
);

-- Create the Problem table:
CREATE TABLE IF NOT EXISTS Problem (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    url TEXT,
    topic_id INTEGER,
    FOREIGN KEY (topic_id) REFERENCES Topic(id)
);

