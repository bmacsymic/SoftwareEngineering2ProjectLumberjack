from flask import render_template, flash, redirect, session, url_for, request, g, json, jsonify
from lumberjack import app
from lumberjack.models.user_measurement import UserMeasurement
from lumberjack.models.user import User
import json
from datetime import datetime
@app.route("/user/<username>/new_measurement", methods=['POST'])
def new_measurement(username):
    m = json.loads(request.data)
    if g.user.is_authenticated() and g.user.username == username:
        user = User.find_by_username(username)
        dt = datetime.strptime(m['measurement_date'], "%m/%d/%Y %H:%M")
        user_measurement = UserMeasurement(user_id = g.user.id, type =
                m['measurement_type'], value = m['measurement_value'], unit
                = m['measurement_unit'], date = dt)
        UserMeasurement.save_to_db(user_measurement)
        User.add_newsfeed(user, "Has added a new measurement " +
                user_measurement.type + ": " +
                str(user_measurement.value) + " " +
                user_measurement.unit );
        return (user_measurement.to_json())
    else:
        return json.dumps({'error': 'User ' + username + ' is not logged in'})


@app.route("/user/<username>/measurement_summary", methods=['GET'])
def measurement_summary(username):
    user = User.find_by_username(username)
    if user != None:
        measurements = UserMeasurement.latest_measurement_for_each_type_by_user(user.id)
        result = []
        for measurement in measurements:
            result.append(measurement.to_hash())
        
        return (jsonify({"measurements": result}))

@app.route("/user/<username>/measurement/<measurement_type>", methods=['GET'])
def user_measurement(username, measurement_type):
    if request_wants_json():
        user = User.find_by_username(username)
        result = []
        if user != None:
            measurements = UserMeasurement.measurement_history_by_user(user.id, measurement_type)
            for measurement in measurements:
                result.append(measurement.to_hash())
            return (jsonify({"measurements": result}))
    else:
        return render_template('user_measurements/measurement_history.html', 
                target_user=username, target_measurement=measurement_type)

def request_wants_json():
    best = request.accept_mimetypes \
        .best_match(['application/json', 'text/html'])
    return best == 'application/json' and \
        request.accept_mimetypes[best] > \
        request.accept_mimetypes['text/html']
