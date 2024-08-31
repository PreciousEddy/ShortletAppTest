from datetime import datetime
from flask import Flask, jsonify


app = Flask(__name__)

@app.route('/', methods=['GET'])
def get_current_time():
    now = datetime.now()
    current_time = now.strftime("%Y-%m-%d %H:%M:%S")
    return jsonify({"current_time": current_time})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
