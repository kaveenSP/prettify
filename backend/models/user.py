from app import db
from cryptography.fernet import Fernet


class User(db.Document):
    name = db.StringField(required=True, max_length=100)
    email = db.EmailField(required=True, unique=True)
    password = db.StringField(required=True, min_length=6)

    def set_password(self, password):
        """
        Encrypts and sets the user's password
        """
        key = Fernet.generate_key()
        cipher_suite = Fernet(key)
        encrypted_password = cipher_suite.encrypt(password.encode())
        self.password = encrypted_password.decode()

    def check_password(self, password):
        """
        Checks if the provided password matches the user's encrypted password
        """
        key = Fernet.generate_key()
        cipher_suite = Fernet(key)
        decrypted_password = cipher_suite.decrypt(self.password.encode())
        return decrypted_password.decode() == password
