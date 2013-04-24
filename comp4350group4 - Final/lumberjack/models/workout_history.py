
from lumberjack import db
from sqlalchemy import desc

class WorkoutHistory(db.Model):
    __tablename__ = 'workout_history'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    workout_id = db.Column(db.Integer, db.ForeignKey('workouts.id'))
    date = db.Column(db.DateTime)
    comments = db.Column(db.String)
    is_completed = db.Column(db.Boolean, default=False)

    def __init__(self, user_id=None, workout_id=None, date=None, comments=None, is_completed=False):
        self.user_id = user_id
        self.workout_id = workout_id
        self.date = date
        self.comments = comments
        self.is_completed = is_completed

    def __repr__(self):
        return '<Workout History %d>' % self.id
    
    def toHash(self, wName):
        format = '%d-%m-%Y / %H:%M'
        ret = { "id": self.id, "userid": self.user_id, "workout_id": self.workout_id, "name":wName, "date": self.date.strftime(format), "comments":self.comments, "is_completed": self.is_completed}
        return ret
    
    @staticmethod
    def find_last_workout_session(uid):
        return (WorkoutHistory.query.filter(WorkoutHistory.user_id == uid).order_by(desc(WorkoutHistory.date))).first()
    
    @staticmethod
    def find_last_session(uid, wid):
        return (WorkoutHistory.query.filter(WorkoutHistory.user_id == uid).filter(WorkoutHistory.workout_id == wid).order_by(desc(WorkoutHistory.date))).first()
    
    @staticmethod
    def get_workout_settions(uid, wid):
        return (WorkoutHistory.query.filter(WorkoutHistory.workout_id == wid).order_by(WorkoutHistory.date)).all()
    
    @staticmethod       
    def get_completed_workouts(uid):
        return (WorkoutHistory.query.filter(WorkoutHistory.is_completed == True).filter(WorkoutHistory.user_id == uid).order_by(desc(WorkoutHistory.date))).all()

    @staticmethod
    def save_to_db(workout_history):
       db.session.add(workout_history)
       db.session.commit()
       return True
