import flask
from flask import request, jsonify
from database import Database
from datetime import datetime
from dotenv import load_dotenv
from os import getenv

load_dotenv()

IS_SERVER = int(getenv("IS_SERVER", 0))
if not IS_SERVER:
    print("[>] This host is not server")
    print("[>] Exit")
    exit()

app = flask.Flask(__name__)
app.config["DEBUG"] = True
db = Database(
    host=getenv("DATABASE_HOST"),
    port=getenv("DATABASE_PORT"),
    user=getenv("DATABASE_USER"),
    password=getenv("DATABASE_PASSWORD"),
    databaseName=getenv("DATABASE_NAME"),
)
db.connect()


@app.route("/", methods=["GET"])
def index():
    return "hello world"


@app.route("/registrasi_client", methods=["POST"])
def registrasiClient():
    name = request.form.get("name")
    secretKey = request.form.get("secretKey")
    if secretKey != getenv("SECRET_KEY"):
        return jsonify(status=False, message="Secret key untuk registrasi salah"), 200
    if not name:
        return jsonify(status=False, message="Nama client diperlukan"), 200
    res = db.select("SELECT * FROM clients WHERE name='%s'" % name)

    if len(res) > 0:
        return (
            jsonify(
                status=False,
                message="Nama client sudah digunakan. Silahkan coba dengan yang lain",
            ),
            200,
        )
    curTime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    lastId = db.insert(
        "INSERT INTO clients(name, created_at) VALUES ('%s', '%s')" % (name, curTime)
    )
    topic = "client%d_topic" % lastId
    queue = "client%d_queue" % lastId
    curTime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    db.update(
        "UPDATE clients SET topic='%s', queue='%s', updated_at='%s' WHERE client_id=%d"
        % (topic, queue, curTime, lastId)
    )

    return (
        jsonify(
            status=True,
            id=lastId,
            topic=topic,
            queue=queue,
            message=("Registrasi client : %s berhasil" % name),
        ),
        200,
    )


app.run(host="0.0.0.0", port=5000)
