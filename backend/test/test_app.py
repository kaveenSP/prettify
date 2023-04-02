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
    user1 = User("John", "johndoe@example.com")
    user2 = User("Jane", "janedoe@example.com")
    user3 = User("Bob", "bobsmith@example.com")
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
    user = User(username='testuser', email='testuser@example.com', password='password')
    db.session.add(user)
    db.session.commit()
    yield user
    db.session.delete(user)
    db.session.commit()

def test_update_user(new_user):
    with app.test_client() as client:
        # Update user with new data
        data = {'name': 'updateduser', 'email': 'updateduser@example.com', 'password': 'newpassword'}
        response = client.put(f'/users/{new_user.id}', json=data)
        assert response.status_code == 200

        # Check that user was updated in the database
        updated_user = User.query.get(new_user.id)
        assert updated_user.name == 'updateduser'
        assert updated_user.email == 'updateduser@example.com'
        assert updated_user.password != 'password'
