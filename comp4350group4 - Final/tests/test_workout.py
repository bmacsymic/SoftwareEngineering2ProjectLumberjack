
import os
import unittest
from config import basedir
from lumberjack import app, db
from lumberjack.models.user import User
from lumberjack.models.workout import Workout
from test_helper import TestHelper

class TestWorkout(TestHelper):

    def test_findbyid(self):
        
        uc = User(username = 'chrycyna', password = '123', email = 'cameron.hrycyna@gmail.com')
        ut = User(username = 'thrycyna', password = '123', email = 'tim.hrycyna@gmail.com')
        db.session.add(uc)
        db.session.add(ut)
        db.session.commit()
        
        w = Workout(user_id= uc.id, 
                    parent_user_id= ut.id, 
                    name="super buff up",
                    level="Medium",
                    is_public=False,
                    is_likeable=False,
                    is_commentable=False)
        
        db.session.add(w)
        db.session.commit()

        assert w.id == 1
        assert w.user_id == 1
        assert w.parent_user_id == 2
        
        assert w.name == 'super buff up'
        assert w.level == "Medium"
        assert w.is_public == False
        assert w.is_likeable == False
        assert w.is_commentable == False
                
    def test_getUserWorkouts(self):
        uc = User(username = 'chrycyna', password = '123', email = 'cameron.hrycyna@gmail.com')
        ut = User(username = 'thrycyna', password = '123', email = 'tim.hrycyna@gmail.com')
        db.session.add(uc)
        db.session.add(ut)
        db.session.commit()
        
        w1 = Workout(user_id = uc.id, name = "Work Out 1")
        db.session.add(w1)
        db.session.commit()
        w2 = Workout(user_id = uc.id, parent_user_id = ut.id, name = "Work Out 2")
        db.session.add(w2)
        db.session.commit()
        
        workouts = Workout.getUsersWorkouts(uc.id)
        
        assert workouts[0].id == 1
        assert workouts[1].id == 2
        
    def test_getParentWorkouts(self):
        uc = User(username = 'chrycyna', password = '123', email = 'cameron.hrycyna@gmail.com')
        ut = User(username = 'thrycyna', password = '123', email = 'tim.hrycyna@gmail.com')
        db.session.add(uc)
        db.session.add(ut)
        db.session.commit()
        
        w1 = Workout(user_id = uc.id, name = "Work Out 1")
        db.session.add(w1)
        db.session.commit()
        w2 = Workout(user_id = uc.id, parent_user_id = ut.id, name = "Work Out 2")
        db.session.add(w2)
        db.session.commit()
        
        workouts = Workout.getParentWorkouts(ut.id)
        
        assert workouts[0].id == 2
        
    def test_getPublicWorkouts(self):
        uc = User(username = 'chrycyna', password = '123', email = 'cameron.hrycyna@gmail.com')
        ut = User(username = 'thrycyna', password = '123', email = 'tim.hrycyna@gmail.com')
        db.session.add(uc)
        db.session.add(ut)
        db.session.commit()
        
        w1 = Workout(user_id = uc.id, name = "Work Out 1")
        db.session.add(w1)
        db.session.commit()
        w2 = Workout(user_id = uc.id, parent_user_id = ut.id, name = "Work Out 2", is_public = False)
        db.session.add(w2)
        db.session.commit()
        w3 = Workout(user_id = uc.id, name = "Work Out 3")
        db.session.add(w3)
        db.session.commit()
        w4 = Workout(user_id = uc.id, parent_user_id = ut.id, name = "Work Out 4", is_public = False)
        db.session.add(w4)
        db.session.commit()
        
        workouts = Workout.getPublicWorkouts()
        
        assert workouts[0].id == 1
        assert workouts[1].id == 3
        
    def test_searchByLevel(self):
        uc = User(username = 'chrycyna', password = '123', email = 'cameron.hrycyna@gmail.com')
        ut = User(username = 'thrycyna', password = '123', email = 'tim.hrycyna@gmail.com')
        db.session.add(uc)
        db.session.add(ut)
        db.session.commit()
        
        w1 = Workout(user_id = uc.id, name = "Work Out 1", level = "Easy")
        db.session.add(w1)
        db.session.commit()
        w2 = Workout(user_id = uc.id, parent_user_id = ut.id, name = "Work Out 2", is_public = False, level = "Medium")
        db.session.add(w2)
        db.session.commit()
        w3 = Workout(user_id = uc.id, name = "Work Out 3", level = "Hard")
        db.session.add(w3)
        db.session.commit()
        w4 = Workout(user_id = uc.id, parent_user_id = ut.id, name = "Work Out 4", is_public = False, level = "Medium")
        db.session.add(w4)
        db.session.commit()
        
        workouts = Workout.searchByLevel('Easy')
        assert workouts[0].id == 1
        
        workouts = Workout.searchByLevel('Medium')
        assert workouts[0].id == 2
        assert workouts[1].id == 4
        
        workouts = Workout.searchByLevel('Hard')
        assert workouts[0].id == 3
        
    def test_getMostRecent(self):
        
        uc = User(username = 'chrycyna', password = '123', email = 'cameron.hrycyna@gmail.com')
        ut = User(username = 'thrycyna', password = '123', email = 'tim.hrycyna@gmail.com')
        db.session.add(uc)
        db.session.add(ut)
        db.session.commit()
        
        list = Workout.getMostRecent(10)
        assert len(list) == 0
        
        w1 = Workout(user_id = uc.id, name = "Work Out 1", level = "Easy")
        w2 = Workout(user_id = uc.id, name = "Work Out 2", level = "Easy")
        db.session.add(w1)
        db.session.add(w2)
        db.session.commit()
        
        list = Workout.getMostRecent(10)
        assert len(list) == 2
        
        w3 = Workout(user_id = uc.id, name = "Work Out 3", level = "Easy")
        w4 = Workout(user_id = uc.id, name = "Work Out 4", level = "Easy")
        w5 = Workout(user_id = uc.id, name = "Work Out 5", level = "Easy")
        w6 = Workout(user_id = uc.id, name = "Work Out 6", level = "Easy")
        db.session.add(w3)
        db.session.add(w4)
        db.session.add(w5)
        db.session.add(w6)
        db.session.commit()
        
        list = Workout.getMostRecent(10)
        assert len(list) == 6
        
        w7 = Workout(user_id = uc.id, name = "Work Out 7", level = "Easy")
        w8 = Workout(user_id = uc.id, name = "Work Out 8", level = "Easy")
        w9 = Workout(user_id = uc.id, name = "Work Out 9", level = "Easy")
        w10 = Workout(user_id = uc.id, name = "Work Out 10", level = "Easy")
        w11 = Workout(user_id = uc.id, name = "Work Out 11", level = "Easy")
        w12 = Workout(user_id = uc.id, name = "Work Out 12", level = "Easy")
        db.session.add(w7)
        db.session.add(w8)
        db.session.add(w9)
        db.session.add(w10)
        db.session.add(w11)
        db.session.add(w12)
        db.session.commit()
        
        list = Workout.getMostRecent(10)
        assert len(list) == 10
        
    def test_getSingleWorkoutByName(self):
        
        user = User(username = 'b-rad', password = '123', email = 'bmacsymic@gmail.com')
        db.session.add(user)
        db.session.commit()
        
        w1 = Workout(user_id = user.id, name = "Work Out 1", level = "Easy")
        w2 = Workout(user_id = user.id, name = "Work Out 2", level = "Easy")
        db.session.add(w1)
        db.session.add(w2)
        db.session.commit()
        
        workoutName1 = Workout.find_single_workout_by_name_("Work Out 1")
        workoutName2 = Workout.find_single_workout_by_name_("Work Out 2")
        
        assert workoutName2.name == w2.name
        assert workoutName1.name == w1.name
        
    def test_getNewest(self):
        user = User(username = 'b-rad', password = '123', email = 'bmacsymic@gmail.com')
        db.session.add(user)
        db.session.commit()
        
        w1 = Workout(user_id = user.id, name = "Newest Work Out 1", level = "Easy")
        db.session.add(w1)
        db.session.commit()
        
        w = Workout.getNewest()
        assert w.name == w1.name