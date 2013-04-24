from flask import render_template
from lumberjack import app

@app.route("/qunit/runTests")
def get_test_page():
    return render_template("qunit_run_tests.html")
