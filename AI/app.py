
from flask import Flask,  jsonify
import os
from dotenv import load_dotenv
from mcp import StdioServerParameters
from descope import DescopeClient
import nest_asyncio

load_dotenv()


nest_asyncio.apply()

app = Flask(__name__)

@app.route("/", methods=["GET"])
def hello():
    return jsonify({"message": "Hello!"})

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=2222, debug=True)

