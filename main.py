from fastapi import FastAPI
import os
import psycopg2

app = FastAPI()

@app.get("/")
def read_root():
  "Db connection test"
  db_url = os.getenv("DATABASE_URL", "postgresql://postgres:password@localhost:5432/devopsdb")
  try:
    conn = psycopg2.connect(db_url)
    conn.close()
    return {"status": "success", "database": "connected"}
  except Exception as e:
    return {"status": "fail", "error": str(e)}