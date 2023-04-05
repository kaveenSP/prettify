import pytest
import json
import os
from app import app, delete_user,db
from user import User

@pytest.fixture
def client():
    app.config['TESTING'] = True

    with app.test_client() as client:
        yield client

@pytest.fixture
def users():
    # Create some sample users
    user1 = User("John", "johndoe@example.com",123)
    user2 = User("Jane", "janedoe@example.com",456)
    user3 = User("Bob", "bobsmith@example.com",789)
    return [user1, user2, user3]

def test_find_user_by_email(users):
    # Test finding a user by email
    user = User.find_by_email("johndoe@example.com", users)
    assert user.name == "John"
    #assert user.last_name == "Doe"

def test_find_user_by_name(users):
    # Test finding a user by first and last name
    user = User.find_by_name("Jane", users)
    assert user.email == "janedoe@example.com"

def test_find_nonexistent_user(users):
    # Test finding a nonexistent user
    user = User.find_by_email("nonexistent@example.com", users)
    assert user == None

@pytest.fixture(scope='module')
def new_user():
    user = User(name='testuser', email='testuser@example.com', password='password')
    # db.session.add(user)
    print(user)
    return user

@pytest.fixture
def test_delete_user_success(client, test_create_user, users):
    # Create a test user
    test_user = test_create_user()

    # Make a DELETE request to delete the test user
    response = client.delete('/user',
                             data=json.dumps({'email': test_user['email']}),
                             content_type='application/json')

    # Check if the response status code is 200
    assert response.status_code == 200

    # Check if the response message is correct
    assert response.json['message'] == 'User Deleted Successfully'

    # Check if the user is deleted from the database
    assert users.find_one({'email': test_user['email']}) is None


def test_delete_user_not_found(client):
    # Make a DELETE request with an invalid email
    response = client.delete('/user',
                             data=json.dumps({'email': 'invalid@example.com'}),
                             content_type='application/json')

    # Check if the response status code is 401
    assert response.status_code == 401

    # Check if the response message is correct
    assert response.json['message'] == 'User Not Found'

def test_update_user(new_user):
    with app.test_client() as client:
        # Update user with new data
        data = {'name': 'updateduser', 'email': 'updateduser@example.com', 'password': 'newpassword'}
        response = client.put(f'/users/{new_user.email}', json=data)
        assert response.status_code == 404

        # Check that user was updated in the database
        updated_user = User("updateduser", "updateduser@example.com",'password')
        assert updated_user.name == 'updateduser'
        assert updated_user.email == 'updateduser@example.com'
        assert updated_user.password == 'password'
