CREATE TABLE projects (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name VARCHAR(255) NOT NULL,
    path VARCHAR(255) NOT NULL,
    scripts TEXT,
    node_version VARCHAR(50),
    default_script VARCHAR(255),
    is_app_valid BOOLEAN DEFAULT false NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
)