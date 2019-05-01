#!/bin/sh

export FLASK_APP=/opt/$PROJECTNAME/app/app.py

exec python -m flask run --host=0.0.0.0 --port=8080