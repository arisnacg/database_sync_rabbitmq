import flask
from flask import request, jsonify
from database import Database
import env

app = flask.Flask(__name__)
app.config["DEBUG"] = True
db = Database(
    host=env.DATABASE_HOST,
    port=env.DATABASE_PORT,
    user=env.DATABASE_USER,
    password=env.DATABASE_PASSWORD,
    databaseName=env.DATABASE_NAME
)
db.connect()


@app.route('/', methods=['GET'])
def index():
    return "hello world"


@app.route('/registrasi_client', methods=['POST'])
def registrasiClient():
    name = request.form.get('name')
    secretKey = request.form.get('secretKey')
    if(secretKey != env.SECRET_KEY):
        return jsonify(status=False, message="Secret key untuk registrasi salah"), 200
    if(not name):
        return jsonify(status=False, message="Nama client diperlukan"), 200
    res = db.select("SELECT * FROM clients WHERE name='%s'" % name)

    if(len(res) > 0):
        return jsonify(status=False, message="Nama client sudah digunakan. Silahkan coba dengan yang lain"), 200
    lastId = db.insert("INSERT INTO clients(name) VALUES ('%s')" % name)
    topic = "client%d_topic" % lastId
    queue = "client%d_queue" % lastId
    db.update("UPDATE clients SET topic='%s', queue='%s' WHERE id=%d" %
              (topic, queue, lastId))

    return jsonify(status=True, id=lastId, topic=topic, queue=queue, message=("Registrasi client : %s berhasil" % name)), 200


app.run(host='0.0.0.0', port=80)
