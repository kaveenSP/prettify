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
# from PIL import Image
import json
from bson import json_util

app = Flask(__name__)
mongo = MongoClient("mongodb+srv://kaveenSP:u8KzN4q9MdKJlQe4@prettify-user-managemen.refxv8x.mongodb.net/?retryWrites=true&w=majority")

secret_key = "this is the key."

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


@app.route('/signup', methods=['POST'])
def signup():
    token = request.headers.get('Authorization')
    try:
        payload = jwt.decode(token, secret_key, algorithms=['HS256'])
    except jwt.ExpiredSignatureError:
        return {"message": "Token has expired"}, 401
    except jwt.InvalidTokenError:
        return {"message": "Invalid token"}, 401
    name = payload['name']

    password = payload['password']

    email = request.json.get('email')
    # encrypt password key
    key = Fernet.generate_key()
    # create a Fernet instance using the key
    fernet = Fernet(key)
    # Check if the email already exists
    user = users.find_one({'name': name})
    if user:
        return jsonify({'error': 'Name already exists'}), 400

    # Encrypt the password
    password = fernet.encrypt(password.encode())

    # Insert the user into the database
    users.insert_one({
        'name': name,
        'email': email,
        'password': password
    })

    return jsonify({'message': 'User created successfully'}), 201


@app.route('/signin', methods=['POST'])
def signin():
    token = request.headers.get('Authorization').split(' ')[1]
    payload = jwt.decode(token, "this is the key.", algorithms=['HS256'])
    name = payload['name']
    password = payload['password']
    # encrypt password key
    key = Fernet.generate_key()
    # create a Fernet instance using the key
    fernet = Fernet(key)
    # Check if the name exists in the database
    user = mongo.db.users.find_one({'name': name})
    if not user:
        return jsonify({'error': 'Invalid username or password'}), 401

    # Check if the password is correct
    if not check_password_hash(user['password'], password):
        return jsonify({'error': 'Invalid email or password'}), 401

    # Generate a JWT token
    payload = {
        'name': name,
        'password': password,
        'exp': datetime.utcnow() + timedelta(days=1)
    }
    token = jwt.encode(payload, secret_key, algorithm='HS256')

    return jsonify({'token': token}), 200


@app.route('/users?<name>/<password>', methods=['POST'])
def find_users(name, password):
    # Get the authorization header
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'error': 'Missing token'}), 401

    # Verify the JWT token
    try:
        payload = jwt.decode(token, secret_key, algorithms=['HS256'])
        if payload['name'] != name:
            return jsonify({'error': 'Username or password not matching'}), 401
        elif payload['password'] != password:
            return jsonify({'error': 'Username or password not matching'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'error': 'Invalid token'}), 401

    # Get all the users from the database
    mongo.db.users.find_one({'name': name})
    # Return the user details
    return jsonify({'message': 'Successful'}), 200


@app.route('/users/<email>', methods=['DELETE'])
def delete_user(email):
    # Get the authorization header
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'error': 'Missing token'}), 401

    # Verify the JWT token
    try:
        payload = jwt.decode(token, secret_key, algorithms=['HS256'])
        if payload['email'] != email:
            return jsonify({'error': 'Email not matching'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'error': 'Invalid token'}), 401

    # Delete the user from the database
    mongo.db.users.delete_one({'email': email})

    return jsonify({'message': 'User deleted successfully'}), 200


@app.route('/users/<email>', methods=['PUT'])
def update_user(email):
    # Get the authorization header
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'error': 'Missing token'}), 401

    # Verify the JWT token
    try:
        payload = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        if payload['email'] != email:
            return jsonify({'error': 'Unauthorized'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'error': 'Invalid token'}), 401

    # Get the user from the database
    user = mongo.db.users.find_one({'email': email})
    if not user:
        return jsonify({'error': 'User not found'}), 404

    # Update the user's name if provided
    name = request.json.get('name')
    if name:
        mongo.db.users.update_one({'email': email}, {'$set': {'name': name}})

    # Update the user's password if provided
    password = request.json.get('password')
    if password:
        hashed_password = generate_password_hash(password, method='sha256')
        mongo.db.users.update_one({'email': email}, {'$set': {'password': hashed_password}})

    return jsonify({'message': 'User updated successfully'}), 200


@app.route('/upload_image', methods=['POST'])
def upload_image():
    # get the uploaded file from the request
    img_file = request.files['file']

    # read the contents of the file, encode it with base64, and create a BytesIO object
    img_data = base64.b64encode(img_file.read())
    img_bytes = base64.b64decode(img_data)
    # Creating a new file
    filename = 'new_img.jpg'
    with open(filename, 'wb') as f:
        f.write(img_bytes)

    # process the image with your machine learning model here

    return 'success'


if __name__ == '__main__':
    app.run(debug=True)

