from lumberjack import db

class WorkoutGoal(db.Model):
    __tablename__ = 'workout_goals'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    type = db.Column(db.String)
    value = db.Column(db.Integer, nullable=True)
    unit = db.Column(db.String, nullable=True)
    date = db.Column(db.DateTime, nullable=True)
    is_done = db.Column(db.Boolean, default=False)

    def __init__(self, user_id=None, type=None, value=None, unit=None,
                date=None, is_done=None):
        self.user_id = user_id
        self.type = type
        self.value = value
        self.unit = unit
        self.date = date
        self.is_done = is_done

    def __repr__(self):
        return '<Workout goal %d>' % self.id
