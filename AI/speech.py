# from flask import Flask, request, jsonify, render_template
# import requests

# app = Flask(__name__)

# @app.route('/')
# def index():
#     return render_template('index.html')  

# @app.route('/translate', methods=['POST'])
# def translate():
#     data = request.json
#     text = data.get('text')
#     src_lang = data.get('lang', 'auto') 

#     try:
#         url = "https://api.mymemory.translated.net/get"
#         params = {
#             "q": text,
#             "langpair": f"{src_lang}|en"
#         }
#         response = requests.get(url, params=params)
#         response_data = response.json()
#         translated_text = response_data["responseData"]["translatedText"]
#         return jsonify({'translatedText': translated_text})
#     except Exception as e:
#         return jsonify({'error': str(e)}), 500

# if __name__ == '__main__':
#     app.run(debug=True)


from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
import requests

app = Flask(__name__)
CORS(app)  # Allow frontend calls

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/translate', methods=['POST'])
def translate():
    data = request.json
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

if __name__ == '__main__':
    app.run(debug=True)
