# Import flask dependencies
from flask import Blueprint, request, render_template, redirect

# Define the blueprint: 'auth', set its url prefix: app.url/auth
example_mod = Blueprint(
    'example_mod',
    __name__,
    template_folder='templates'
)


# Set the route and accepted methods
@example_mod.route('/')
def hello_world():
    return 'Flask Dockerized'
