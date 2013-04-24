from lumberjack import db

class WorkoutLike(db.Model):

    __tablename__ = 'workout_likes'

    id         = db.Column(db.Integer, primary_key = True)
    user_id    = db.Column(db.Integer, db.ForeignKey('users.id'))
    workout_id = db.Column(db.Integer, db.ForeignKey('workouts.id'))

    def __init__(self, user_id=None, workout_id=None):
        self.user_id    = user_id
        self.workout_id = workout_id

    def __repr__(self):
        return "<WorkoutLike id %d>" % self.id
