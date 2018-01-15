#!/bin/bash
python run.py db upgrade
python run.py runserver --host 0.0.0.0 --port 5000
