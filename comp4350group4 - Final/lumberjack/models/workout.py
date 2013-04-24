
from lumberjack import db, app
from lumberjack.models.workout_history import WorkoutHistory
from lumberjack.models.workout_like import WorkoutLike
from lumberjack.models.workout_comment import WorkoutComment
from lumberjack.models.user import User
from datetime import datetime
from sqlalchemy import desc
import json
import logging

class Workout(db.Model):

    __tablename__ = 'workouts'

    id              = db.Column(db.Integer, primary_key = True)
    user_id         = db.Column(db.Integer, db.ForeignKey('users.id'))
    parent_user_id  = db.Column(db.Integer, db.ForeignKey('users.id'))
    name            = db.Column(db.String, unique = True)
    description     = db.Column(db.String)
    level           = db.Column(db.String, nullable = True)
    is_public       = db.Column(db.Boolean, default = True)
    is_likeable     = db.Column(db.Boolean, default = True)
    is_commentable  = db.Column(db.Boolean, default = True)
    date            = db.Column(db.DateTime)

    workout_history = db.relationship('WorkoutHistory', backref = 'workout', lazy = 'dynamic')
    workout_likes   = db.relation('WorkoutLike', backref = 'workout', lazy = 'dynamic')
    workout_comments   = db.relation('WorkoutComment', backref = 'workout', lazy = 'dynamic')

    def __init__(self, user_id=None, parent_user_id=None, name=None,
            description= None, level=None, is_public=True, is_likeable=True, is_commentable=True):
        self.user_id        = user_id
        self.parent_user_id = parent_user_id
        self.name           = name
        self.description    = description
        self.level          = level
        self.is_public      = is_public
        self.is_likeable    = is_likeable
        self.is_commentable = is_commentable
        self.date           = datetime.now()

    def to_hash(self):
        ret = { "id": self.id, "userid": self.user_id, "parent_user_id": self.parent_user_id, "name": self.name,
                "description": self.description, "level": self.level, "is_public": self.is_public, "is_likeable": self.is_likeable,
                "is_commentable": self.is_commentable}
        return ret

    def to_search_query_hash(self):
        author = User.query.filter(User.id == self.user_id).first()
        ret = { "id": self.id, "userid": author.username, "parent_user_id": self.parent_user_id, "name": self.name,
                "description": self.description, "level": self.level, "is_public": self.is_public, "is_likeable": self.is_likeable,
                "is_commentable": self.is_commentable}
        return ret

    def to_json(self):
        ret = { "id": self.id, "userid": self.user_id, "parent_user_id": self.parent_user_id, "name": self.name,
                "description": self.description, "level": self.level, "is_public": self.is_public, "is_likeable": self.is_likeable,
                "is_commentable": self.is_commentable}
        return json.dumps(ret)

    def __repr__(self):
        return "<Workout name %r>" % self.name

    @staticmethod
    def find_by_wid(id):
        return (Workout.query.filter(Workout.id == id).all())

    @staticmethod
    def find_by_starts_with(starts_with):
        return (Workout.query.filter(Workout.is_public and Workout.name.startswith(starts_with)).all())

    @staticmethod
    def find_by_userid(id):
        return Workout.query.filter(Workout.user_id == id).all()
    
    @staticmethod
    def find_by_parentid(id):
        return (Workout.query.filter(Workout.parent_user_id == id).first())
    
    @staticmethod
    def getUsersWorkouts(userid):
        return (Workout.query.filter(Workout.user_id == userid).all())
    
    @staticmethod
    def getParentWorkouts(userid):
        return (Workout.query.filter(Workout.parent_user_id == userid).all())
    
    @staticmethod
    def getPublicWorkouts():
        return (Workout.query.filter(Workout.is_public == True).all())

    @staticmethod
    def getAllWorkouts():
        return (Workout.query.all())
    
    @staticmethod
    def searchByLevel(level):
        return (Workout.query.filter(Workout.level == level).all())
    
    @staticmethod
    def find_by_name(workoutName):
        return Workout.query.filter(Workout.name.like('%' + workoutName + '%')).all()

    @staticmethod
    def find_by_description(description):
        return Workout.query.filter(Workout.description.like('%' + description + '%')).all()

    @staticmethod
    def find_single_workout_by_name_(workoutName):
        return (Workout.query.filter(Workout.name == workoutName).first())
    
    @staticmethod
    def find_single_workout_by_id(id):
        return (Workout.query.filter(Workout.id == id).first())

    @staticmethod
    def find_by_id(id):
        return Workout.query.filter(Workout.id == id and Workout.is_public == True).first()

    @staticmethod
    def getNewest():
        return Workout.query.order_by(desc(Workout.date)).first()

    @staticmethod
    def getMostRecent(max):
        all = Workout.query.order_by(desc(Workout.date)).all()
        list = []
        if(len(all) < max):
            max = len(all)
        for x in range(0, max):
            list.append(all[x])
        return list
            
    @staticmethod
    def save_to_db(workout):
        db.session.add(workout)
        db.session.commit()
    
    @staticmethod
    def update_workout_info(workout):
        db.session.commit()
