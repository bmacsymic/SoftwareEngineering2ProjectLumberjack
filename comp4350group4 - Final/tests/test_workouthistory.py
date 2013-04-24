from test_helper import TestHelper
import os
import unittest
from config import basedir
from lumberjack import app, db
from lumberjack.models.user import User
from lumberjack.models.workout import Workout
from lumberjack.models.workout_history import WorkoutHistory
from datetime import datetime, date, time

        
class TestWorkoutHistory(TestHelper):
    
    def test_init(self):
        u = User(username = 'chrycyna', password = '123', email = 'cameron.hrycyna@gmail.com')
        db.session.add(u)
        db.session.commit()
       
        w = Workout(user_id= u.id, 
                    name="super buff up",
                    level="Medium",
                    is_public=False,
                    is_likeable=False,
                    is_commentable=False)
        
        db.session.add(w)
        db.session.commit()
        
        d = date(2013, 02, 13)
        t = time(2, 52)
        
        wh = WorkoutHistory(user_id = u.id,
                            workout_id = w.id,
                            date = datetime.combine(d, t),
                            is_completed = True)
        
        db.session.add(wh)
        db.session.commit()
        
        assert wh.id == 1
        assert wh.user_id == 1
        assert wh.workout_id == 1
        assert wh.date == datetime.combine(d, t)
        assert wh.is_completed == True
    
    def test_last_workout_session(self):
        u = User(username = 'chrycyna', password = '123', email = 'cameron.hrycyna@gmail.com')
        db.session.add(u)
        db.session.commit()
       
        w = Workout(user_id= u.id, 
                    name="super buff up",
                    level="Medium",
                    is_public=False,
                    is_likeable=False,
                    is_commentable=False)
        
        db.session.add(w)
        db.session.commit()
        
        d = date(2013, 02, 13)
        t = time(2, 52)
        
        wh = WorkoutHistory(user_id = u.id,
                            workout_id = w.id,
                            date = datetime.combine(d, t),
                            is_completed = True)
        
        db.session.add(wh)
        db.session.commit()
        
        wh1 = WorkoutHistory.find_last_workout_session(u.id)
        assert wh1.id == wh.id
        
        d = date(2013, 02, 13)
        t = time(2, 53)
        
        wh = WorkoutHistory(user_id = u.id,
                            workout_id = w.id,
                            date = datetime.combine(d, t),
                            is_completed = True)
        
        db.session.add(wh)
        db.session.commit()
        
        wh2 = WorkoutHistory.find_last_workout_session(u.id)
        assert wh2.id == wh.id
        
        d = date(2013, 02, 13)
        t = time(2, 51)
        
        wh = WorkoutHistory(user_id = u.id,
                            workout_id = w.id,
                            date = datetime.combine(d, t),
                            is_completed = True)
        
        db.session.add(wh)
        db.session.commit()
        
        wh3 = WorkoutHistory.find_last_workout_session(u.id)
        assert wh3.id == wh2.id
        
    def test_find_last_session(self):
        u = User(username = 'chrycyna', password = '123', email = 'cameron.hrycyna@gmail.com')
        db.session.add(u)
        db.session.commit()
       
        w1 = Workout(user_id= u.id, 
                    name="super buff up",
                    level="Medium",
                    is_public=False,
                    is_likeable=False,
                    is_commentable=False)
        w2 = Workout(user_id= u.id, 
                    name="runners high",
                    level="Medium",
                    is_public=False,
                    is_likeable=False,
                    is_commentable=False)
        w3 = Workout(user_id= u.id, 
                    name="hack the riper",
                    level="Medium",
                    is_public=False,
                    is_likeable=False,
                    is_commentable=False)
        
        
        db.session.add(w1)
        db.session.add(w2)
        db.session.add(w3)
        db.session.commit()
        
        d = date(2013, 02, 13)
        t = time(2, 52)
        wh = WorkoutHistory(user_id = u.id, workout_id = w1.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh)
        db.session.commit()
        
        wh1 = WorkoutHistory.find_last_session(u.id, w1.id)
        assert wh1.id == wh.id
        
        d = date(2013, 02, 13)
        t = time(4, 52)
        wh = WorkoutHistory(user_id = u.id,  workout_id = w1.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh)
        db.session.commit()
        
        wh2 = WorkoutHistory.find_last_session(u.id, w1.id)
        assert wh2.id == wh.id
        
        d = date(2013, 02, 13)
        t = time(3, 52)
        wh = WorkoutHistory(user_id = u.id, workout_id = w2.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh)
        db.session.commit()
        
        wh3 = WorkoutHistory.find_last_session(u.id, w1.id)
        assert wh3.id == wh2.id
        wh4 = WorkoutHistory.find_last_session(u.id, w2.id)
        assert wh4.id == wh.id
        
        d = date(2015, 02, 13)
        t = time(2, 52)
        wh = WorkoutHistory(user_id = u.id, workout_id = w1.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh)
        db.session.commit()
        
        wh5 = WorkoutHistory.find_last_session(u.id, w1.id)
        assert wh5.id == wh.id
        
        d = date(2015, 02, 13)
        t = time(2, 52)
        wh = WorkoutHistory(user_id = u.id, workout_id = w3.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh)
        db.session.commit()
        
        wh6 = WorkoutHistory.find_last_session(u.id, w3.id)
        assert wh6.id == wh.id
        
        d = date(2013, 02, 13)
        t = time(3, 52)
        wh = WorkoutHistory(user_id = u.id, workout_id = w1.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh)
        db.session.commit()
        
        wh7 = WorkoutHistory.find_last_session(u.id, w1.id)
        assert wh7.id == wh5.id
        
    def test_get_workout_sessions(self):
        u = User(username = 'chrycyna', password = '123', email = 'cameron.hrycyna@gmail.com')
        db.session.add(u)
        db.session.commit()
       
        w1 = Workout(user_id= u.id, name="super buff up", level="Medium", is_public=False, is_likeable=False, is_commentable=False)
        db.session.add(w1)
        db.session.commit()
        
        w2 = Workout(user_id= u.id, name="runners riff", level="Easy", is_public=False, is_likeable=False, is_commentable=False)
        db.session.add(w2)
        db.session.commit()
        
        d = date(2013, 02, 13)
        t = time(2, 52)
        wh1 = WorkoutHistory(user_id = u.id, workout_id = w1.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh1)
        db.session.commit()
        
        wh = WorkoutHistory.get_workout_settions(u.id, w1.id)
        assert wh[0].id == wh1.id
        
        d = date(2013, 02, 10)
        t = time(2, 51)
        wh2 = WorkoutHistory(user_id = u.id, workout_id = w1.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh2)
        db.session.commit()
        
        wh = WorkoutHistory.get_workout_settions(u.id, w1.id)
        assert wh[0].id == wh2.id
        assert wh[1].id == wh1.id
        
        d = date(2013, 02, 11)
        t = time(2, 51)
        wh3 = WorkoutHistory(user_id = u.id, workout_id = w1.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh3)
        db.session.commit()
        
        wh = WorkoutHistory.get_workout_settions(u.id, w1.id)
        assert wh[0].id == wh2.id
        assert wh[1].id == wh3.id
        assert wh[2].id == wh1.id
        
        d = date(2010, 02, 13)
        t = time(2, 52)
        wh5 = WorkoutHistory(user_id = u.id, workout_id = w2.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh5)
        db.session.commit()
        
        wh = WorkoutHistory.get_workout_settions(u.id, w2.id)
        assert wh[0].id == wh5.id
        
    def test_get_completed_workouts(self):
        u = User(username = 'chrycyna', password = '123', email = 'cameron.hrycyna@gmail.com')
        u2 = User(username = 'andy', password = '123', email = 'andy.hrycyna@gmail.com')
        db.session.add(u)
        db.session.add(u2)
        db.session.commit()
        print u.id
        print u2.id
       
        w1 = Workout(user_id= u.id, name="super buff up", level="Medium", is_public=False, is_likeable=False, is_commentable=False)
        w2 = Workout(user_id= u.id, name="runners high", level="Medium", is_public=False, is_likeable=False, is_commentable=False)
        w3 = Workout(user_id= u.id, name="hack the riper", level="Medium", is_public=False, is_likeable=False, is_commentable=False)
        db.session.add(w1)
        db.session.add(w2)
        db.session.add(w3)
        db.session.commit()
        
        
        d = date(2013, 02, 10)
        t = time(2, 51)
        wh1 = WorkoutHistory(user_id = u.id, workout_id = w1.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh1)
        db.session.commit()
        
        wh = WorkoutHistory.get_completed_workouts(u.id)
        assert wh[0].id == wh1.id
        
        d = date(2013, 02, 10)
        t = time(2, 52)
        wh2 = WorkoutHistory(user_id = u.id, workout_id = w1.id, date = datetime.combine(d, t), is_completed = False)
        db.session.add(wh2)
        db.session.commit()
        
        wh = WorkoutHistory.get_completed_workouts(u.id)
        assert wh[0].id == wh1.id
        
        d = date(2013, 02, 12)
        t = time(2, 51)
        wh3 = WorkoutHistory(user_id = u.id, workout_id = w1.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh3)
        db.session.commit()
        
        d = date(2013, 02, 11)
        t = time(2, 51)
        wh4 = WorkoutHistory(user_id = u2.id, workout_id = w1.id, date = datetime.combine(d, t), is_completed = True)
        db.session.add(wh4)
        db.session.commit()
        
        wh = WorkoutHistory.get_completed_workouts(u.id)
        assert wh[0].id == wh3.id
        assert wh[1].id == wh1.id
        
        wh = WorkoutHistory.get_completed_workouts(u2.id);
        assert wh[0].id == wh4.id

