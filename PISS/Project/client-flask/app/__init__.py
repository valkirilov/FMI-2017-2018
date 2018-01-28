# Import flask and template operators
from flask import Flask
from flask_script import Manager

# Define the WSGI application object
app = Flask(__name__)

# Configurations
app.config.from_object('config')

manager = Manager(app)

from app.article.views import article_mod as article_mod
app.register_blueprint(article_mod)
# Import a module / component using its blueprint handler variable (mod_auth)
# from app.mod_auth.controllers import mod_auth as auth_module

# Register blueprint(s)
# app.register_blueprint(auth_module)
# app.register_blueprint(xyz_module)
# ..
