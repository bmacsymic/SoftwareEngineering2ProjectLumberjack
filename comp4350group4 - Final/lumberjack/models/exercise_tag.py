from lumberjack import db

class ExerciseTag(db.Model):
    __tablename__ = 'exercise_tags'
    
    id        = db.Column(db.Integer, primary_key = True)
    name      = db.Column(db.String, index = True, unique = True)
    unit      = db.Column(db.String)
    exercises = db.relationship('Exercise', backref = 'tag', lazy = 'dynamic')

    def __init__(self, name=None, unit=None):
        self.name = name
        self.unit = unit
    
    def __repr__(self):
        return '<Exercise Tag %s>' % self.name
    
    def to_hash(self):
        ret = {"id": self.id, "name": self.name, "unit": self.unit, "exercises": self.exercises}
        return ret

    def to_json(self):
        ret = {"id": self.id, "name": self.name, "unit": self.unit, "exercises": self.exercises}
        return json.dumps(ret)
    
    @staticmethod
    def all():
        return (ExerciseTag.query.all())
    
    @staticmethod
    def find_by_id(id):
        return (ExerciseTag.query.filter(ExerciseTag.id == id).first())
    
    @staticmethod
    def find_by_name(name):
        return (ExerciseTag.query.filter(ExerciseTag.name == name).first())

    @staticmethod
    def find_all_by_name(name):
        print name
        return ExerciseTag.query.filter(ExerciseTag.name.like('%' + name + '%')).all()
    
    @staticmethod
    def save_to_db(exercise):
        db.session.add(exercise)
        db.session.commit()
