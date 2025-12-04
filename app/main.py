from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return {"message": "Welcome to OctaByte AI - ECS Deployment Successful!"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
