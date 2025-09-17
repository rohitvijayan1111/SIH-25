
from flask import Blueprint, request, jsonify
import requests

speech = Blueprint("speech", __name__)

@speech.route('/translate', methods=['POST'])
def translate():
    print("hi")
    data = request.json
    print(data)
    text = data.get('text')
    src_lang = data.get('lang', 'auto')

    try:
        url = "https://api.mymemory.translated.net/get"
        params = {
            "q": text,
            "langpair": f"{src_lang}|en"
        }
        response = requests.get(url, params=params)
        response_data = response.json()
        translated_text = response_data["responseData"]["translatedText"]
        return jsonify({'translatedText': translated_text})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

