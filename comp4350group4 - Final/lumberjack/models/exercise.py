
from lumberjack import db
from lumberjack.models.exercise_tag import ExerciseTag
import json

class Exercise(db.Model):

    __tablename__ = 'exercises'

    id             = db.Column(db.Integer, primary_key=True)
    workOutId      = db.Column(db.Integer)
    eTagId         = db.Column(db.Integer, db.ForeignKey('exercise_tags.id'))
    order          = db.Column(db.Integer)
    amount         = db.Column(db.Integer)
    additionalInfo = db.Column(db.String, nullable=True)
    
    def __init__(self, workOutId=None, eTagId=None, order=None, amount=None, additionalInfo=None):
        self.workOutId = workOutId
        self.eTagId = eTagId
        self.order = order
        self.amount = amount
        self.additionalInfo = additionalInfo
    
    def __repr__(self):
        return '<Exercise %d>' % self.id
    
    def to_hash(self):
        exerciseTag = ExerciseTag.find_by_id(self.eTagId)
        
        ret = { "id": self.id, "workOutId": self.workOutId, "eTagName": exerciseTag.name, "eTagUnit": exerciseTag.unit, 
                "order": self.order, "amount": self.amount, "additionalInfo": self.additionalInfo}
        return ret

    def to_json(self):
        exerciseTag = ExerciseTag.find_by_id(self.eTagId)
        
        ret = { "id": self.id, "workOutId": self.workOutId, "eTagName": exerciseTag.name, "eTagUnit": exerciseTag.unit, 
                "order": self.order, "amount": self.amount, "additionalInfo": self.additionalInfo}
        return json.dumps(ret)
    
    @staticmethod
    def find_all_by_workOutId(id):
        return (Exercise.query.filter(Exercise.workOutId == id).all())
    
    @staticmethod
    def find_by_workOutId_and_order(id, order):
        return (Exercise.query.filter(Exercise.workOutId == id).filter(Exercise.order == order).first())
    
    @staticmethod
    def find_by_id(id):
        return (Exercise.query.filter(Exercise.id == id).first())
    
    @staticmethod
    def save_to_db(exercise):
        db.session.add(exercise)
        db.session.commit()
        
    @staticmethod
    def update_exercise_info(exercise):
        db.session.commit()
