import os
from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy
from flask.ext.login import LoginManager
from config import basedir
import wtforms_json
from momentjs import momentjs

app = Flask(__name__)
app.config.from_object('config')
app.secret_key = app.config['SECRET_KEY']
db = SQLAlchemy(app)
wtforms_json.init()
app.jinja_env.globals['momentjs'] = momentjs

from lumberjack.models import *
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'users/login'

from controllers import *
