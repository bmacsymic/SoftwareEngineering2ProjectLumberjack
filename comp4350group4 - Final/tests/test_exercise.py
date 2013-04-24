from test_helper import TestHelper
from lumberjack import app, db
from lumberjack.models.exercise import Exercise
from lumberjack.models.exercise_tag import ExerciseTag
from lumberjack.models.workout import Workout
from lumberjack.models.user import User

class TestExercise(TestHelper):
    
    def test_find_all_by_workOutId(self):
        user = User(username = 'brad', password = "123", email = 'bmacsymic@gmail.com')
        db.session.add(user)
        db.session.commit()
        
        exerciseTag1 = ExerciseTag(name="running", unit="minutes")
        workout = Workout(user.id, user.id, name="Get Fit Workout", 
                          description="This is the best way to shed those pounds!", level="Hard", 
                          is_public=True, is_likeable=True, is_commentable=True)
        db.session.add(exerciseTag1)
        db.session.add(workout)
        db.session.commit()
        
        exercise1 = Exercise(workOutId=workout.id, eTagId=exerciseTag1.id, order="1", amount="5", additionalInfo="No Additional Info")
        exercise2 = Exercise(workOutId=workout.id, eTagId=exerciseTag1.id, order="2", amount="10", additionalInfo="No Additional Info")
        db.session.add(exercise1)
        db.session.add(exercise2)
        db.session.commit()
        
        exercisesFound = Exercise.find_all_by_workOutId(workout.id)
        assert len(exercisesFound) == 2
    
    def test_find_by_workOutId_and_order(self):
        user = User(username = 'brad', password = "123", email = 'bmacsymic@gmail.com')
        db.session.add(user)
        db.session.commit()
        
        exerciseTag1 = ExerciseTag(name="running", unit="minutes")
        workout = Workout(user.id, user.id, name="Get Fit Workout", 
                          description="This is the best way to shed those pounds!", level="Hard", 
                          is_public=True, is_likeable=True, is_commentable=True)
        db.session.add(exerciseTag1)
        db.session.add(workout)
        db.session.commit()
        
        exercise1 = Exercise(workOutId=workout.id, eTagId=exerciseTag1.id, order=1, amount=5, additionalInfo="No Additional Info")
        exercise2 = Exercise(workOutId=workout.id, eTagId=exerciseTag1.id, order=2, amount=10, additionalInfo="No Additional Info")
        db.session.add(exercise1)
        db.session.add(exercise2)
        db.session.commit()
        
        exerciseFound = Exercise.find_by_workOutId_and_order(workout.id, 1)
        assert exerciseFound.amount == 5
        exerciseFound = Exercise.find_by_workOutId_and_order(workout.id, 2)
        assert exerciseFound.amount == 10
        
    def test_find_by_id(self):
        user = User(username = 'brad', password = "123", email = 'bmacsymic@gmail.com')
        db.session.add(user)
        db.session.commit()
        
        exerciseTag1 = ExerciseTag(name="running", unit="minutes")
        workout = Workout(user.id, user.id, name="Get Fit Workout", 
                          description="This is the best way to shed those pounds!", level="Hard", 
                          is_public=True, is_likeable=True, is_commentable=True)
        db.session.add(exerciseTag1)
        db.session.add(workout)
        db.session.commit()
        
        exercise1 = Exercise(workOutId=workout.id, eTagId=exerciseTag1.id, order="1", amount="5", additionalInfo="No Additional Info")
        db.session.add(exercise1)
        db.session.commit()
        
        exerciseFound = Exercise.find_by_id(exercise1.id)
        assert exerciseFound.id == exercise1.id

    def test_save_to_db(self):
        user = User(username = 'brad', password = "123", email = 'bmacsymic@gmail.com')
        db.session.add(user)
        db.session.commit()
        
        exerciseTag1 = ExerciseTag(name="running", unit="minutes")
        workout = Workout(user.id, user.id, name="Get Fit Workout", 
                          description="This is the best way to shed those pounds!", level="Hard", 
                          is_public=True, is_likeable=True, is_commentable=True)
        
        exercise1 = Exercise(workOutId=workout.id, eTagId=exerciseTag1.id, order="1", amount="5", additionalInfo="No Additional Info")
        db.session.add(exerciseTag1)
        db.session.add(workout)
        Exercise.save_to_db(exercise1);
        
        exerciseFound = Exercise.find_by_id(exercise1.id)
        assert exerciseFound.id == exercise1.id
        
    def test_update_exercise_info(self):
        user = User(username = 'brad', password = "123", email = 'bmacsymic@gmail.com')
        db.session.add(user)
        db.session.commit()
        
        exerciseTag1 = ExerciseTag(name="running", unit="minutes")
        workout = Workout(user.id, user.id, name="Get Fit Workout", 
                          description="This is the best way to shed those pounds!", level="Hard", 
                          is_public=True, is_likeable=True, is_commentable=True)
        
        exercise1 = Exercise(workOutId=workout.id, eTagId=exerciseTag1.id, order="1", amount="5", additionalInfo="No Additional Info")
        db.session.add(exerciseTag1)
        db.session.add(workout)
        Exercise.save_to_db(exercise1);
        
        
        exerciseFound = Exercise.find_by_id(exercise1.id)
        exerciseFound.amount = 10
        
        Exercise.update_exercise_info(exerciseFound)
        exerciseFound = Exercise.find_by_id(exercise1.id)
        assert exerciseFound.amount == 10