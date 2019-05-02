from flask import Flask

def create_app(config_filename=None):
    app = Flask(__name__)
    app.config.from_pyfile(config_filename)

    @app.route('/')
    def hello_world():
        return 'Hello, World!'

    return app