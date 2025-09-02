from flask import Flask, request, jsonify, send_from_directory
from google import genai


app = Flask(__name__, static_folder='.')


@app.route('/')
def serve_index():
    return send_from_directory(app.static_folder, 'index.html')

@app.route('/script.js')
def serve_js():
    return send_from_directory(app.static_folder, 'script.js')

# @app.route('/generate-bullets', methods=['POST'])
# def generate_bullets():
#     data = request.get_json()
#     text = data.get('text', '')
#     bullets = [f"Bullet {i+1}: {text}" for i in range(min(10, len(text.split())))]
#     return jsonify({'bullets': bullets})


@app.route('/generate-bullets', methods=['POST'])
def generate_bullets():
    user_input = request.json.get('text', '')
    
    if not user_input:
        return jsonify({'error': 'No input text provided'}), 400

    try:
        client = genai.Client(api_key=os.environ.get("GENAI_API_KEY"))

        response = client.models.generate_content(model = "gemini-2.5-flash", contents=f"Generate a list of bullet points based on the following text: {user_input}")

        bullet_points = response.text.strip().split('\n')
        bullet_points = [point for point in bullet_points if point]  # Remove empty lines
        bullet_points = bullet_points[:10]  # Limit to 10 bullets

        return jsonify({'bullets': bullet_points})

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)