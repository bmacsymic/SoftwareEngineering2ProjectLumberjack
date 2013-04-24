
import os
import unittest
from config import basedir
from lumberjack import app, db
from lumberjack.models.exercise_tag import ExerciseTag
from test_helper import TestHelper

class TestExerciseTag(TestHelper):
    
    def test_all(self):
        exercise1 = ExerciseTag(name = "Exercise 1", unit = "reps")
        exercise2 = ExerciseTag(name = "Exercise 2", unit = "reps")
        
        db.session.add(exercise1)
        db.session.add(exercise2)
        db.session.commit()
        
        foundEntries = ExerciseTag.all()
        assert foundEntries != None
    
    def test_find_by_id(self):
        exercise3 = ExerciseTag(name = "Exercise 3", unit = "reps")
        db.session.add(exercise3)
        db.session.commit()
        
        exerciseFound = ExerciseTag.find_by_id(exercise3.id)
        
        assert exerciseFound is not None
        
    def test_find_by_name(self):
        exercise3 = ExerciseTag(name = "Exercise 3", unit = "reps")
        exercise4 = ExerciseTag(name = "Exercise 4", unit = "reps")
        
        db.session.add(exercise3)
        db.session.add(exercise4)
        db.session.commit()

        foundEntry = ExerciseTag.find_by_name('Exercise 3')
        assert foundEntry.name == 'Exercise 3'
        foundEntry = ExerciseTag.find_by_name('Exercise 4')
        assert foundEntry.name == 'Exercise 4'
    
    def test_save_to_db(self):
        exerciseTag1 = ExerciseTag("running", "minutes")
        exerciseTag2 = ExerciseTag("walking", "minutes")
        ExerciseTag.save_to_db(exerciseTag1);
        ExerciseTag.save_to_db(exerciseTag2);
        
        exerciseTagFound = ExerciseTag.find_by_name("running")
        assert exerciseTagFound != None
        exerciseTagFound = ExerciseTag.find_by_name("walking")
        assert exerciseTagFound != None

