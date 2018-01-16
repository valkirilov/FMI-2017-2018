# all the imports
import os
import sqlite3
from flask import Flask, request, session, g, redirect, url_for, abort, \
     render_template, flash, jsonify

from algorithms import knn

app = Flask(__name__) # create the application instance :)
app.config.from_object(__name__) # load config from this file , digitsrcgn.py

# Load default config and override config from an environment variable
app.config.update(dict(
    DATABASE=os.path.join(app.root_path, 'digitsrcgn.db'),
    SECRET_KEY='development key',
    USERNAME='admin',
    PASSWORD='password'
))
app.config.from_envvar('DIGITSRCGN_SETTINGS', silent=True)


@app.route('/')
def show_entries():
    return render_template('show_entries.html')

@app.route('/summary')
def show_summary():
    return render_template('show_summary.html')

@app.route('/editor')
def show_editor():
    return render_template('show_editor.html')

@app.route('/knn', methods=['GET', 'POST'])
def process_knn():
    content = request.get_json(silent=True)

    results = knn.clasiffy(content)
    return jsonify(results)
