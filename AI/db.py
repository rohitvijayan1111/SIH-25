from flask import Flask
import psycopg2
from psycopg2 import OperationalError
from dotenv import load_dotenv
import os

load_dotenv()

app = Flask(__name__)

# PostgreSQL connection
def get_db_connection():
    try:
        conn = psycopg2.connect(
            host=os.getenv("DB_HOST"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASS"),
            dbname=os.getenv("DB_NAME"),
            port=os.getenv("DB_PORT")  # Default is 5432
        )
        print("✅ PostgreSQL connection successful!")
        return conn
    except OperationalError as e:
        print(f"❌ Error connecting to PostgreSQL: {e}")
        return None


# Test the connection
if __name__ == "__main__":
    conn = get_db_connection()
    if conn:
        conn.close()
        print("🔒 Connection closed.")
