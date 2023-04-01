import base64
from flask import Flask, jsonify, request
import jwt
from cryptography.fernet import Fernet
from bson import json_util
from pymongo import MongoClient

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

@app.route('/', methods=['GET'])
def home():
    return "<h1>TEST</h1>"

@app.route('/user', methods=['POST'])
def create_user():
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

    # create a Fernet instance using the key
    # Check if the email already exists
    user = users.find_one({'name': name})
    if user:
        return jsonify({'error': 'Name already exists'}), 400

        # Encrypt the password
    # hashed_password = generate_password_hash(password, method='sha256')
    # password = 'password'
    password = fernet.encrypt(password.encode())

    # Insert the user into the database
    users.insert_one({
        'name': name,
        'email': email,
        'password': password
    })

    return jsonify({'message': 'User created successfully'}), 201


@app.route('/user', methods=['GET'])
def find_user():
    token = request.headers.get('Authorization')
    payload = jwt.decode(token, "this is the key.", algorithms=['HS256'])
    name = payload['name']
    password = payload['password']

    # Check if the name exists in the database
    result = users.find_one({'name': name})
    if not result:
        return jsonify({'error': 'Invalid Username'}), 401

    # Check if the password is correct
    decrypted_password = fernet.decrypt(result.get('password')).decode()

    if password != decrypted_password:
        return jsonify({'error': 'Invalid Password'}), 401
    else:
        return jsonify({'name': result.get('name'), 'email': result.get('email')}), 200


@app.route('/user', methods=['DELETE'])
def delete_user():
    email = request.args.get('email')
    print(email)
    # Delete the user from the database
    result = users.delete_one({'email': email})
    if result.deleted_count == 1:
        return jsonify({'message': 'User Deleted Successfully'}), 200
    else:
        return jsonify({'message': 'User Not Found'}), 401


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
    