from flask import Flask

app = Flask(__name__)

@app.route('/signup/createNewUser', methods = ['POST'])
def CreateUser():
    return "lol"

@app.route('/signup/findUser', methods = ['POST'])
def FindUser():
    return "lol"

@app.route('/signup/updateUser', methods = ['POST'])
def UpdateUser():
    return "lol"

@app.route('/signup/deleteUser', methods = ['POST'])
def DeleteUser():
    return "lol"