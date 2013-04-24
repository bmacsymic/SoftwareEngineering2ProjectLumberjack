from lumberjack import db

class WorkoutComment(db.Model):

    __tablename__ = 'workout_comment'

    id         = db.Column(db.Integer, primary_key = True)
    user_id    = db.Column(db.Integer, db.ForeignKey('users.id'))
    workout_id = db.Column(db.Integer, db.ForeignKey('workouts.id'))
    comment    = db.Column(db.String)

    def __init__(self, user_id=None, workout_id=None, comment=None):
        self.user_id    = user_id
        self.workout_id = workout_id
        self.comment    = comment

    def __repr__(self):
        return "<WorkoutComment id %d>" % self.id
