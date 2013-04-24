
from flask import render_template, flash, redirect, session, url_for, request, g, json, jsonify
from flask.ext.login import login_user, logout_user, current_user, login_required
from lumberjack import app, login_manager, db
from lumberjack.models import *
from lumberjack.models.user import User
from lumberjack.models.workout import Workout
from lumberjack.models.workout_history import WorkoutHistory
from lumberjack.forms import LoginForm, RegistrationForm
from sqlalchemy import or_
from datetime import datetime, time
import json
from config import MAX_SEARCH_RESULTS, POSTS_PER_PAGE

def request_wants_json():
    best = request.accept_mimetypes \
        .best_match(['application/json', 'text/html'])
    return best == 'application/json' and \
        request.accept_mimetypes[best] > \
        request.accept_mimetypes['text/html']

@app.route("/")
def home_index():
    if( g.user.is_authenticated() ):
        return redirect(url_for('display_spash'))
    return render_template("home.html")

@app.route("/users/splash/")
@login_required
def display_spash():
    return render_template("users/splash.html")

@app.route("/user/splash/contents", methods=['GET'])
def display_splash_contents():
    ret = Workout.getNewest()
    nWorkout = ret.to_hash()
    
    ret = User.getNewest()
    nuPic = ret.get_avatar(200)
    nUser = ret.to_hash()
    
    ret = User.find_by_id(8)
    mfPic = ret.get_avatar(200)
    mFollowed = ret.to_hash()
        
    w = {"Result":"OK", "nUser":nUser, "nuPic": nuPic,"nWorkout":nWorkout, "mostFollowed":mFollowed, "mfPic":mfPic}
    return jsonify(w)

@app.before_request
def before_request():
    g.user = current_user

@app.route("/login", methods=['GET', 'POST'])
def login():
    form = LoginForm(csrf_enabled=False)
    if g.user is not None and g.user.is_authenticated():
        if(request_wants_json()):
            return g.user.to_json();
        else:
            return redirect(url_for('home_index'))

    if request.method == 'GET':
        return render_template('users/login.html',
            title = 'Sign In',
            form = form)
    elif request.method == 'POST':
        if form.validate_on_submit():
            login_user(form.user)
            flash("Login successful")
            session['username'] = form.username.data
            user = User.find_by_username(form.username.data)
            if(request_wants_json()):
                return user.to_json();
            else:
                return redirect(request.args.get("next") or url_for("home_index"))
        else:
            if(request_wants_json()):
                return form.to_json();
            else:
                return render_template('users/login.html',
                    title = 'Sign In',
                    form = form)


@app.route('/logout')
def logout():
    logout_user()
    session.pop('username', None)
    if(request_wants_json()):
        return json.dumps({'logged_out': 'true'})
    else:
        return redirect(url_for('home_index'))

@app.route("/users/")
def users_index():
    users = User.all()
    output = ""
    for user in users:
        output += user.username + "\n"
    return output

@app.route("/users/getUsers", methods=["POST"])
def get_users():
    """

    """
    result = []
    userids = []
    usernames = []

    if 'username' in request.form:
        usernames = User.find_all_by_username(request.form['username'])

        if usernames is not None:
            for username in usernames:
                result.append(username.to_hash())

    elif 'email' in request.form:
        usernames = User.find_all_by_email(request.form['email'])

        if usernames is not None:
            for username in usernames:
                result.append(username.to_hash())
    w = {"Result":"OK", "Records": result}

    return jsonify(w)

@app.route("/users/new", methods=['GET', 'POST'])
def new_user():
    if request.headers['Content-Type'] == 'application/json':
        form = RegistrationForm.from_json(request.json, csrf_enabled=False)
    else:
        form = RegistrationForm()

    if request.method == 'GET':
        return render_template('users/new.html', form=form)
    elif request.method == 'POST':
        if form.validate():
            user = User(form.username.data,
                        form.password.data)
            User.save_to_db(user)
            user = user.follow(user)
            User.add_newsfeed(user,"Has joined Lumberjack.")
            flash("Registration Successful!")
            if request.headers['Content-Type'] == 'application/json':
                return user.to_json()
            else:
                login_user(user);
                session['username'] = form.username.data
                return redirect(url_for('display_user_profile',
                    username=user.username))
        else:
            if request.headers['Content-Type'] == 'application/json':
                return form.to_json()
            else:
                return render_template('users/new.html', form=form)

@login_manager.user_loader
@app.route("/user/find/", methods=['GET'])
def load_user(id):
    return User.find_by_id(int(id))

@app.route("/user/<username>")
@app.route('/user/<username>/<int:page>', methods = ['GET'])
def display_user_profile(username, page=1):
    user = User.find_by_username(username)
    posts = None
    if not request_wants_json():
        if user == None:
            return render_template("users/user.html", user = user, posts = posts) #user not found
        if g.user.is_authenticated() and g.user.id == user.id:
            if user.firstname == None or user.firstname == "" or user.lastname == None or user.lastname == "" or user.email == None or user.email == "":
                flash("We can't display your profile until you have filled out the form")
                return render_template("users/update_info.html")
            posts = g.user.followed_posts().paginate(page, 10, False)
    else:
        if user == None:
            return json.dumps({"Error": "User not found."})
        return user.to_json() 
    return render_template("users/user.html", user = user, posts = posts)

@app.route("/user/update-profile/", methods=['GET', 'POST'])
@login_required
def update_info():
    if request.method == 'POST':
        if not request_wants_json():
            user = User.find_by_id(g.user.id)
        else:
            user = User.find_by_id(request.form['uid'])
        user.firstname = request.form['firstname']
        user.lastname = request.form['lastname']
        user.email = request.form['email']
        email_user = User.find_by_email(user.email)
        if not request_wants_json():
            if email_user != None and email_user.id != g.user.id:
                flash("Our record shows that you have an account under the given email address already.")
                return render_template("users/update_info.html")
        else:
            if email_user != None and str(email_user.id) != request.form['uid']:
                ret = {"result": "Email address already exist."}
                return json.dumps(ret)
        if len(request.form['gender']) > 0:
            user.sex = request.form['gender'][0].upper()
        user.location = request.form['location']
        user.date_of_birth = request.form['date_of_birth']
        user.avatar = request.form['gravatar']
        user.about_me = request.form['about-me']
        User.save_to_db(user)
        if request_wants_json():
            ret = {"result": "OK"}
            return json.dumps(ret)
        flash('Your changes have been made!')
    return render_template("users/update_info.html")
    
@app.route('/follow_btn')
def follow_btn():
    followee = request.args.get('followee', '', type=int)
    state = request.args.get('state', '', type=str)
    user = User.find_by_id(followee)    
    if state.startswith("Follow"):
        follower = g.user.follow(user)
        User.save_to_db(follower)
        if g.user.is_following(user):
            return jsonify(result="Unfollow") #g.user successfully followed user. So, we must change the state of the button
        else:
            return jsonify(resul="error") #we could return 'Follow' to just keep the state. But returning 'error' will say that something went wrong. Could be a database problem.
    follower = g.user.unfollow(user)
    User.save_to_db(follower)
    if not g.user.is_following(user):
        return jsonify(result="Follow") #g.user successfully unfollowed user
    else:
        return jsonify(result="error")


@app.route("/<username>/followers")
@app.route('/<username>/followers/<int:page>', methods = ['GET'])
def followers(username, page=1):
    user = g.user
    posts = g.user.followed_posts().paginate(page, POSTS_PER_PAGE, False)
    return render_template("users/followers.html",user = user)


@app.route("/user_feeds/")
@app.route('/user_feeds/<int:page>', methods = ['GET'])
def user_feeds(page=1):
    user = g.user
    
    if user.is_anonymous():
        return jsonify(result="")
    
    posts = g.user.followed_posts().paginate(request.args.get('page', '', type=int), 10, False)
    if not posts.items:
        return jsonify(result="")
    
    feeds = "{\"feed\":["
    for post in posts.items:
        feeds += "{\"username\":\"" + post.userName + "\"," + "\"body\":\"" + post.body + "\"," + "\"time\":\"" + str(post.timestamp) + "\"," + "\"avatar\":\"" + post.get_feed_avatar(post.userName, 40) + "\"},"  
    feeds = feeds[:len(feeds)-1]    
    feeds += "]}"
    return jsonify(result = feeds)

@app.route("/all_user_feeds/<uid>", methods=["GET"])
def all_user_feeds(uid):
    user = User.find_by_id(uid)
    posts = user.followed_posts().paginate(1, 100, False)
    feeds = '{"feed":['
    for post in posts.items:
        feeds += '{"username":"' + post.userName + '",' + '"body":"' + post.body + '",' + '"time":"' + str(post.timestamp) + '",' + '"avatar":"' + post.get_feed_avatar(post.userName, 80) + '"},'
    feeds = feeds[:len(feeds)-1]
    feeds += "]}"
    return feeds

@app.route("/post-status/", methods = ['POST'])
def post_status():
    body = request.form['body']
    if 'uid' not in request.form:
        g.user.add_newsfeed(body)
    else:
        user = User.find_by_id(request.form['uid'])
        user.add_newsfeed(body)
    return jsonify(result="success");

@app.route("/followers/get_followers", methods=["POST"])
def get_followers():
    user = g.user
    fw = user.user_is_following()
    users = []
    for foll in fw:
        users.append(foll.to_hash())
    res ={"Result":"OK", "Records": users} 
    return jsonify(res)

@app.route("/followers/get_following_count", methods=["POST"])
def get_following_count():
    count = g.user.followed.count()
    return jsonify(following = count)


@app.route("/followers/get_top_dog")
def get_top_dog():
    user = g.user
    output = ""
    fw = user.top_user()
    return jsonify(topUser = fw)

@app.route("/submit_workout_history", methods = ['POST'])
def submit_workout_history():
    wName = request.form['wName']
    date = request.form['date']
    desc = request.form['desc']
    user = User.find_by_username(request.form['user'])
    workout = Workout.find_single_workout_by_name_(wName)
    if(workout == None):
        return jsonify(result="errorName", content=" The workout name you have entered may not exist. Please double check the spelling of the workout name. Thank you")
    if(date == ""):
        return jsonify(result="errorDate", content=" Please enter the date and time of the completed workout")
    
    wh = WorkoutHistory(user.id, workout.id, datetime.strptime(date, "%m/%d/%Y %I:%M:%S %p"), desc, True)
    WorkoutHistory.save_to_db(wh)
       
    feed = "comleted "+wName+" on "+date+" - "+desc;
    user.add_newsfeed(feed);
    return jsonify(result="success");
    
@app.route("/user/<username>/workouthistory", methods=['GET'])
def display_user_workout_history (username):
    user = User.find_by_username(username)
    return render_template("users/workout_history.html", user=user)

############################
##WORKOUT SEARCH
############################
#workout search

@app.route('/workout_search')
def workout_search():
    return render_template('workout_search.html')


@app.route("/search", methods=['GET'])
def search_for_key():
    query = request.args.get('key', '')
    if query.startswith('#'):
        return redirect(url_for('display_user_profile', username=query[1:]))
    user_search_result = (User.query.filter(or_((User.first_last_name.like("%" + query + "%")), (User.last_first_name.like("%" + query + "%"))))).all()
    workout_search_result = (Workout.query.filter(Workout.name.like("%" + query + "%"))).all()
    return render_template("/results.html", query = query, user_list = user_search_result, workout_list = workout_search_result)

#
#ErrorHandlers
#
@app.errorhandler(404)
def page_not_found(error):
    return render_template('404.html'), 404

@app.errorhandler(500)
def internal_server_error(error):
    db.session.rollback()
    return render_template('500.html'), 500
