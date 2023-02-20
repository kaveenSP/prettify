from flask import Blueprint, jsonify
from controllers.user_controller import create_user, get_user, update_user, delete_user

user_bp = Blueprint('user_bp', __name__)

user_bp.route('/users', methods=['POST'])(create_user)
user_bp.route('/users/<id>', methods=['GET'])(get_user)
user_bp.route('/users/<id>', methods=['PUT'])(update_user)
user_bp.route('/users/<id>', methods=['DELETE'])(delete_user)
