from lumberjack import db
import json
from datetime import datetime
from sqlalchemy.sql import *
class UserMeasurement(db.Model):
    __tablename__ = 'user_measurement'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    type = db.Column(db.String)
    value = db.Column(db.Integer, nullable=True)
    unit = db.Column(db.String, nullable=True)
    date = db.Column(db.DateTime, nullable=True)

    def __init__(self, user_id=None, type=None, value=None, unit=None,
                date=None):
        self.user_id = user_id
        self.type = type
        self.value = value
        self.unit = unit
        self.date = date

    @staticmethod
    def save_to_db(user_measurement):
        db.session.add(user_measurement)
        db.session.commit()

    @staticmethod
    def find_all_by_user_id(user_id):
        return UserMeasurement.query.filter(UserMeasurement.user_id == user_id).all()
       
    @staticmethod
    def latest_measurement_for_each_type_by_user(user_id):
        return db.session.query(UserMeasurement).filter(UserMeasurement.user_id == user_id) \
                                                .order_by(desc(UserMeasurement.date)) \
                                                .group_by(UserMeasurement.type).all()

    @staticmethod
    def measurement_history_by_user(user_id, type):
        return UserMeasurement.query.filter(UserMeasurement.user_id == user_id) \
                                    .filter(UserMeasurement.type == type) \
                                    .order_by(desc(UserMeasurement.date)).all()

    def __repr__(self):
        return '<User Measurement %d>' % self.id

    def to_hash(self):
        return {"user_id": self.user_id, "type": self.type,
                "value": self.value, "unit": self.unit,
                "date": self.date.strftime("%m/%d/%Y %H:%M")}

    def to_json(self):
        return json.dumps(self.to_hash())
