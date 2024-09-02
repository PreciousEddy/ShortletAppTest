from flask import Flask, jsonify
from datetime import datetime

app = Flask(__name__)

@app.route('/', methods=['GET'])
def get_current_time():
    now = datetime.utcnow()
    formatted_time = now.strftime("%A, %B %d, %Y %I:%M:%S %p")

    return jsonify({

           'current_time': formatted_time
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
