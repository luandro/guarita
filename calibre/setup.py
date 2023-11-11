import sqlite3
from contextlib import closing
import os

# ________________________________________________________________________________
# Global Constants 
# ________________________________________________________________________________
db_path = "/config/app.db"  # Set DB path to /config

# ________________________________________________________________________________
# DB helper functions
# ________________________________________________________________________________
def set_table_values(cursor, table_name, values):
    """
    Set values in the specified table
    """
    for key, value in values.items():
        cursor.execute(f"UPDATE {table_name} SET {key} = ?", (value,))

def show_table_details(cursor):
    """
    Show detailed tables, columns and values for config/app.db
    """
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()
    for table in tables:
        print(f"Table: {table[0]}")
        cursor.execute(f"PRAGMA table_info({table[0]})")
        columns = cursor.fetchall()
        for column in columns:
            print(f"Column: {column[1]}")
        cursor.execute(f"SELECT * FROM {table[0]}")
        rows = cursor.fetchall()
        for row in rows:
            print(f"Values: {row}")

# ________________________________________________________________________________
# Main
# ________________________________________________________________________________
with closing(sqlite3.connect(db_path)) as connection:
    with closing(connection.cursor()) as cursor:
        # Set values in tables
        set_table_values(cursor, 'settings', { 'config_default_language': 'pt', 'config_calibre_dir': '/books', 'config_calibre_web_title': 'Biblioteca' })
        # Show detailed tables, columns and values
        # show_table_details(cursor)
        connection.commit()

