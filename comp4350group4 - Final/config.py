CSRF_ENABLED = True
SECRET_KEY = 'SecurityByObsurity'
import os
basedir = os.path.abspath(os.path.dirname(__file__))

SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'db/lumberjack.db')
SQLALCHEMY_MIGRATE_REPO = os.path.join(basedir, 'db/db_repository')

POSTS_PER_PAGE = 10
MAX_SEARCH_RESULTS = 10