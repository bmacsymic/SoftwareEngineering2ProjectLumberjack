import os,sys
parentdir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0,parentdir) 
import config
import subprocess

db_file = os.path.join(config.basedir, 'db/lumberjack.db')
print("Deleting lumberjack.db ...")
print(subprocess.check_output(["rm", db_file]))
print("Deleting database repository ...")
print(subprocess.check_output(["rm", "-rf", config.SQLALCHEMY_MIGRATE_REPO]))
print("Creating database ...")
execfile("db/db_create.py")
print("Done!")

