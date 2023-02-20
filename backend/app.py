from flask import Flask
from dotenv import load_dotenv
from controllers.user_controller import user_bp
from models.user import db

# Load environment variables from .env file
load_dotenv()

app = Flask(__name__)

# Set up the database connection
app.config['MONGODB_HOST'] = os.environ.get('MONGODB_URI')
app.config['MONGODB_DB'] = os.environ.get('MONGODB_DB')
db.init_app(app)

# Register blueprints for the user controller
app.register_blueprint(user_bp)

if __name__ == '__main__':
    app.run()
