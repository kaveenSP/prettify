import base64
import io
from io import BytesIO

import pymongo
from flask import Flask, request, jsonify, Response, send_file
from flask_pymongo import PyMongo
from pymongo import MongoClient
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime, timedelta
import jwt
from cryptography.fernet import Fernet
from bson.json_util import dumps
import json
from bson import json_util
from detectAcne import detect_remove_acne

app = Flask(__name__)
mongo = MongoClient(
    "mongodb+srv://kaveenSP:u8KzN4q9MdKJlQe4@prettify-user-managemen.refxv8x.mongodb.net/?retryWrites=true&w=majority")

secret_key = "this is the key."
key = bytearray(b'T1TyfXki7C5AFw24EQJZk8PQLhAfhs_eZQC9tUb35-8=')
# create a Fernet instance using the key
fernet = Fernet(key)

if mongo:
    try:
        # ping the server
        mongo.server_info()
        print("Connected successfully!")
    except:
        print("Could not connect to server.")
else:
    print("Could not connect to database.")

# set the database name
db = mongo["prettify"]

# set the collection name
users = db["user"]


@app.route('/user', methods=['POST'])
def create_user():
    name = request.json.get('name')
    password = request.json.get('password')
    email = request.json.get('email')

    # Check if the user already exists
    user = users.find_one({'name': name})
    if user:
        return jsonify({'error': 'Name already exists'}), 400

    password = fernet.encrypt(password.encode())

    # Insert the user into the database
    users.insert_one({
        'name': name,
        'email': email,
        'password': password
    })

    return jsonify({'message': 'User created successfully'}), 201


@app.route('/userLogin', methods=['POST'])
def find_user():
    name = request.json.get('name')
    password = request.json.get('password')

    # Search for the user in the database
    result = users.find_one({'name': name})
    if not result:
        return jsonify({'error': 'Invalid Username'}), 401

    # Check if the password is correct
    decrypted_password = fernet.decrypt(result.get('password')).decode()

    if password != decrypted_password:
        return jsonify({'error': 'Invalid Password'}), 401
    else:
        # Return the user's information
        return dumps(result), 200


@app.route('/user', methods=['DELETE'])
def delete_user():
    email = request.json.get('email')
    print(email)
    # Delete the user from the database
    result = users.delete_one({'email': email})
    if result.deleted_count == 1:
        return jsonify({'message': 'User Deleted Successfully'}), 200
    else:
        return jsonify({'message': 'User Not Found'}), 401


@app.route('/user', methods=['PUT'])
def update_user():
    email = request.json.get('email')
    print(email)

    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'error': 'Missing token'}), 401

    # Verify the JWT token
    try:
        if request.json.get('email') != email:
            return jsonify({'error': 'Unauthorized'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'error': 'Invalid token'}), 401

    # Get the user from the database
    result = users.find_one({'email': email})
    if not result:
        return jsonify({'error': 'User not found'}), 404

    payload = jwt.decode(token, secret_key, algorithms=['HS256'])
    # Update the user's name if provided
    name = payload['name']
    if name:
        users.update_one({'email': email}, {'$set': {'name': name}})

    # Update the user's password if provided
    password = payload['password']
    if password:
        password_fr = fernet.encrypt(password.encode())
        print(fernet.decrypt(password_fr).decode())
        users.update_one({'email': email}, {'$set': {'password': password_fr}})

    email = request.args.get('email')
    if email:
        users.update_one({'name': name}, {'password': password}, {'$set': {'email': email}})


    return jsonify({'message': 'User updated successfully'}), 200


@app.route('/upload_image', methods=['POST'])
def upload_image():
    # get the uploaded file from the request
    img_file = request.files['image']

    # read the contents of the file, encode it with base64, and create a BytesIO object
    img_data = base64.b64encode(img_file.read())
    img_bytes = base64.b64decode(img_data)
    # Creating a new file
    filename = 'localStorage/unprocessedImage.jpg'
    with open(filename, 'wb') as f:
        f.write(img_bytes)

    # process the image with machine learning model here
    processedImage = detect_remove_acne(filename)
    print(processedImage)
    return send_file(processedImage, as_attachment=True)


if __name__ == '__main__':
    app.run(host='localhost', debug=True, port=8000)