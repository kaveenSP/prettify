from flask import request, jsonify
from app import app
from models.user import User


@app.route('/users', methods=['POST'])
def create_user():
    data = request.get_json()

    user = User()
    user.name = data['name']
    user.email = data['email']
    user.set_password(data['password'])
    user.save()

    return jsonify({
        'id': str(user.id),
        'name': user.name,
        'email': user.email,
    }), 201

@app.route('/users/<id>', methods=['GET'])
def get_user(id):
    user = User.objects.get_or_404(id=id)

    return jsonify({
        'id': str(user.id),
        'name': user.name,
        'email': user.email,
    })

@app.route('/users/<id>', methods=['PUT'])
def update_user(id):
    data = request.get_json()

    user = User.objects.get_or_404(id=id)
    user.name = data['name']
    user.email = data['email']
    user.set_password(data['password'])
    user.save()

    return jsonify({
        'id': str(user.id),
        'name': user.name,
        'email': user.email,
    })

@app.route('/users/<id>', methods=['DELETE'])
def delete_user(id):
    user = User.objects.get_or_404(id=id)
    user.delete()

    return '', 204
