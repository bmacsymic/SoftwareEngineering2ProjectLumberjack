from flask import render_template, flash, redirect, session, url_for, request, g, json, jsonify, Markup
from lumberjack import db, app
from lumberjack.models.exercise_tag import ExerciseTag
from lumberjack.models.exercise import Exercise
from lumberjack.models.workout import Workout
from lumberjack.models.workout_history import WorkoutHistory
from lumberjack.models.user import User
import logging
import HTMLParser

@app.route("/workouts/workout", methods=["GET"])
def get_workout_page():
    givenWorkoutName = request.args.get('name')
    
    workout = Workout.find_single_workout_by_name_(givenWorkoutName)
    if workout != None:
        workoutNameFound = Markup(workout.name)
        return render_template("workouts/workout.html", creatingNewWorkout = False, workoutName = workoutNameFound)
    else:
        return render_template("workouts/workout.html", creatingNewWorkout = True)

@app.route("/workouts/getExerciseTypes")
def get_exercise_types():
    exerciseTags = ExerciseTag.all()
    output = ""
    
    if len(exerciseTags) == 0:
        running = ExerciseTag(name = "Running", unit = "Minutes")
        walking = ExerciseTag(name = "Walking", unit = "Minutes")
        biking = ExerciseTag(name = "Biking", unit = "Minutes")
        bicepCurls = ExerciseTag(name = "Bicep Curls", unit = "Reps")
        
        ExerciseTag.save_to_db(running);
        ExerciseTag.save_to_db(walking);
        ExerciseTag.save_to_db(biking);
        ExerciseTag.save_to_db(bicepCurls);
        
        exerciseTags = ExerciseTag.all()
        
    for exercise_tag in exerciseTags:
        output += exercise_tag.name + ","
    return jsonify(names = output)   

@app.route("/workouts/get_most_recent")
def get_most_recent():
    imgURL = []
    
    imgURL.append(url_for('static', filename='imgs/fall1.jpg'));
    imgURL.append(url_for('static', filename='imgs/boat1.jpg'));
    imgURL.append(url_for('static', filename='imgs/lake1.jpg'));
    imgURL.append(url_for('static', filename='imgs/forrest1.jpg'));
    imgURL.append(url_for('static', filename='imgs/waterfall1.jpg'));
    imgURL.append(url_for('static', filename='imgs/fall2.jpg'));
    imgURL.append(url_for('static', filename='imgs/boat2.jpg'));
    imgURL.append(url_for('static', filename='imgs/lake2.jpg'));
    imgURL.append(url_for('static', filename='imgs/summer1.jpg'));
    imgURL.append(url_for('static', filename='imgs/winter1.jpg'));
    
    list = Workout.getMostRecent(len(imgURL))
    content = []
    for x in range(0, len(list)):
        content.append({'name':list[x].name,'description':list[x].description, "image":imgURL[x],"id":list[x].id})
    r = {"Result":"success", "Content":content}
    return jsonify(r);

@app.route("/workouts/autocompleteWorkouts", methods=["GET"])
def autocomplete_workouts():

    text = request.args.get('name_startsWith')
    maxRows = request.args.get('maxRows')
    workouts = Workout.find_by_starts_with(text)

    result = []
    for workout in workouts:
        result.append(workout.to_hash())
        
    w = {"workouts": result}
    return  jsonify(w)

@app.route("/workouts/getSingleWorkout")
def get_single_workout():
    workoutName = request.args.get('name')
    
    if workoutName is None:
        id = request.args.get('id')
        workout = Workout.find_single_workout_by_id(id)
    else:
        workout = Workout.find_single_workout_by_name_(workoutName)
    if workout != None:
        workoutData = workout.to_hash()
        exercises = Exercise.find_all_by_workOutId(workout.id)
        
        exerciseData = []
        for exercise in exercises:
            exerciseData.append(exercise.to_hash())
        
        returnVal = {"Result": "Success", "workoutData": workoutData,"exerciseData": exerciseData}
        return  jsonify(returnVal)
    else:
        returnVal = {"Result": "Failure"}
        return  jsonify(returnVal)
        
@app.route("/workouts/getWorkouts", methods=["POST"])
def get_workouts():
    """
    {
    "Result":"OK",
    "Records":[
        {"WorkoutId":1,"Name":"Blah"},
        {"WorkoutId":2,"Name":"Lazy bones"},
        ]
    }
    """

    result = []
    workout_ids = []
    workouts = []

    if 'workout' in request.form:
        workouts = Workout.find_by_name(request.form['workout'])

        if workouts is not None:
            for workout in workouts:
                result.append(workout.to_search_query_hash())

    elif 'description' in request.form:
        workouts = Workout.find_by_description(request.form['description'])

        if workouts is not None:
            for workout in workouts:
                result.append(workout.to_search_query_hash())

    elif 'tag_auto' in request.form:
        tags = ExerciseTag.find_all_by_name(request.form['tag_auto'])

        if tags is not None:
            for tag in tags:

                for exercise in tag.exercises:
                    workout_ids.append(exercise.workOutId)

            #remove dupes
            workout_ids = set(workout_ids)

            for id in workout_ids:
                workouts.append(Workout.find_by_id(id))

            for workout in workouts:
                result.append(workout.to_search_query_hash())


    elif 'exercise' in request.form:
        tag = ExerciseTag.find_by_name(request.form['exercise'])

        if tag is not None:

            for exercise in tag.exercises:
                workout_ids.append(exercise.workOutId)
                
            #remove dupes
            workout_ids = set(workout_ids)

            for id in workout_ids:
                workouts.append(Workout.find_by_id(id))

            for workout in workouts:
                result.append(workout.to_search_query_hash())

    elif 'author' in request.form:

        authors = User.find_all_by_username(request.form['author'])

        if authors is not None:
            for author in authors:
                works = Workout.find_by_userid(author.id)
                if works is not None:
                    for work in works:
                        workouts.append(work)
            for workout in workouts:
                result.append(workout.to_search_query_hash())

    w = {"Result":"OK", "Records": result}

    return jsonify(w)

@app.route("/workouts/getExerciseTagUnit")
def get_exercise_tag_unit():
    exerciseTagName = request.args.get('name', '')
    exercise = ExerciseTag.find_by_name(exerciseTagName)
    if exercise is None:
        result = {"unit":"minutes"}
        return jsonify(result)
    else:
        result = {"unit":exercise.unit}
        return jsonify(result)

@app.route("/workouts/checkIfNameIsUnique")
def check_if_name_is_unique():
    workoutName = request.args.get('name', '')
    workout = Workout.find_single_workout_by_name_(workoutName)
    
    if workout is None:
        result = {"Result":"True"}
        return jsonify(result)
    else:
        result = {"Result":"False"}
        return jsonify(result)

@app.route("/workouts/submitWorkout", methods=["PUT", "POST", "GET"])
def submit_workout():
    exercises = request.data
    if(len(exercises) == 0):
        result = {"Result":"Failure: No JSON Data sent."}
	return jsonify(result)
    
    jsonExercises = json.loads(exercises)
    name = jsonExercises['name']
    description = jsonExercises['description']
    level = jsonExercises['level']

    isPublic = jsonExercises['isPublic']
    if isPublic == 'true':
        isPublic = True
    else:
        isPublic = False
    isLikeable = jsonExercises['isLikeable']
    if isLikeable == 'true':
        isLikeable = True
    else:
        isLikeable = False
    isCommentable = jsonExercises['isCommentable']
    if isCommentable == 'true':
        isCommentable = True
    else:
        isCommentable = False    

    user = g.user
    if user.is_anonymous():
        user = User.find_by_username("Guest")
    else:
        user.add_newsfeed("Has added a workout: " + name + "")
    if user is None:
        user = User.find_by_username("Guest")
        if user is None:
            user = User(username="Guest", password="Guest", email=None, firstname=None, lastname=None, location=None, sex=None, date_of_birth=None, avatar=None, about_me=None, last_seen=None)
            User.save_to_db(user)
        
    newWorkout = Workout(user_id=user.id, parent_user_id=user.id, name=name, level=level, 
                         is_public=isPublic, is_likeable=isLikeable, is_commentable=isCommentable, description=description)
    Workout.save_to_db(newWorkout)
    
    logging.warning("saving workout")
    for exercise in jsonExercises['exercises']:
        order = exercise['order']
        type = exercise['type']
        unit = exercise['unit']
        exerciseTag = ExerciseTag.find_by_name(type)
        if exerciseTag is None:
            exerciseTag = ExerciseTag(type, unit)
            ExerciseTag.save_to_db(exerciseTag)
        amount = exercise['amount']
        additionalInfo = exercise['additionalInfo']

        newExercise = Exercise(newWorkout.id, exerciseTag.id, order, amount, additionalInfo)
        Exercise.save_to_db(newExercise)
    
    result = {"Result":"Success"}
    return jsonify(result)

@app.route("/workouts/editWorkout", methods=["PUT", "POST", "GET"])
def edit_workout():
    exercises = request.data
    
    if(len(exercises) == 0):
        result = {"Result":"Failure"}
        return jsonify(result)
    
    jsonExercises = json.loads(exercises)
    
    if jsonExercises == None:
        result = {"Result":"Failure"}
        return jsonify(result)
    else:
        if len(jsonExercises) == 0:
            result = {"Result":"Failure"}
            return jsonify(result)
        else:
            name = jsonExercises['name']
            description = jsonExercises['description']
            level = jsonExercises['level']

            isPublic = jsonExercises['isPublic']
            if isPublic == 'true':
                isPublic = True
            else:
                isPublic = False
            isLikeable = jsonExercises['isLikeable']
            if isLikeable == 'true':
                isLikeable = True
            else:
                isLikeable = False
            isCommentable = jsonExercises['isCommentable']
            if isCommentable == 'true':
                isCommentable = True
            else:
                isCommentable = False
            
            currentWorkout = Workout.find_single_workout_by_name_(name)
            currentWorkout.level = level
            currentWorkout.is_public = isPublic
            currentWorkout.is_likeable = isLikeable
            currentWorkout.is_commentable = isCommentable
            currentWorkout.description = description
            Workout.update_workout_info(currentWorkout)
            
            for exercise in jsonExercises['exercises']:
                order = exercise['order']
                type = exercise['type']
                unit = exercise['unit']
                exerciseTag = ExerciseTag.find_by_name(type)
                if exerciseTag is None:
                    exerciseTag = ExerciseTag(type, unit)
                    ExerciseTag.save_to_db(exerciseTag)
                amount = exercise['amount']
                additionalInfo = exercise['additionalInfo']
                
                currentExercise = Exercise.find_by_workOutId_and_order(currentWorkout.id, order)
                if currentExercise is None:
                    newExercise = Exercise(currentWorkout.id, exerciseTag.id, order, amount, additionalInfo)
                    Exercise.save_to_db(newExercise)
                else:
                    currentExercise.eTagId = exerciseTag.id
                    currentExercise.amount = amount
                    currentExercise.additionalInfo = additionalInfo
                    Exercise.update_exercise_info(currentExercise)
            
            result = {"Result":"Success"}
            return jsonify(result)

@app.route("/workouts/getWorkoutHistory", methods=["GET"])
def getWorkoutHistory():
    results = []
    uName = request.args.get('name')
    
    current_user = User.find_by_username(uName)
    if current_user is None:
        w = {"Result":"BAD"}
        return jsonify(w)
    
    completed = WorkoutHistory.get_completed_workouts(current_user.id)
    
    for item in completed:
        name = Workout.find_by_id(item.workout_id).name
        results.append(item.toHash(name))

    w = {"Result":"OK", "Contents":results, "User":current_user.username}
    return jsonify(w)
