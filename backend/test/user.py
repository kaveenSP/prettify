class User:
    def __init__(self, name, email, username=None, password=None):
        self.name = name
        self.email = email
        self.username = username
        self.password = password

    def __repr__(self):
        return f'<User {self.email}>'

    @classmethod
    def find_by_email(cls, email, users):
        for user in users:
            if user.email == email:
                return user
        return None

    @classmethod
    def find_by_name(cls, name, users):
        for user in users:
            if user.name == name:
                return user
        return None

    # @classmethod
    # def find_by_username(cls, username):
    #     # Code to find a user by username
    #     pass
    @classmethod
    def find_by_username(cls, username):
        return cls.query.filter_by(username=username).first()
