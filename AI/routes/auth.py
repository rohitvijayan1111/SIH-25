from flask import Blueprint, request, jsonify
import requests

auth = Blueprint("auth", __name__)

@auth.route("/login", methods=["POST"])
def login_user():
   
    return jsonify({"error": "Not implemented yet"}), 400

    