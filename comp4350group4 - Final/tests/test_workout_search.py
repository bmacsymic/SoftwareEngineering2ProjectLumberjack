from test_helper import TestHelper

from lumberjack import app, db
from lumberjack.models.user import User
from lumberjack.models.workout import Workout

class TestWorkoutSearch(TestHelper):

    def test_single_search(self):

        w = Workout(user_id = 1, name = "Kyle's Work Out 1")
        db.session.add(w)

        db.session.commit()

        results = Workout.query.filter(Workout.name.like('%Work%')).all()

        for workout in results:
            assert workout.user_id == 1

        for workout in results:
            assert workout.name == "Kyle's Work Out 1"

    def test_multi_search(self):

        w1 = Workout(user_id = 1, name = "Kyle's Work Out 1")
        db.session.add(w1)

        w2 = Workout(user_id = 2, name = "Kyle's Work Out 2")
        db.session.add(w2)

        db.session.commit()

        results = Workout.query.filter(Workout.name.like('%Work%')).all()
        
        for workout in results:
            assert workout.user_id == 1 or workout.user_id == 2
        for workout in results:
            assert workout.name == "Kyle's Work Out 1" or workout.name == "Kyle's Work Out 2"

    def test_only_search(self):
        w1 = Workout(user_id = 1, name = "Kyle's Work Out 1")
        db.session.add(w1)

        w2 = Workout(user_id = 2, name = "Kyle's Work Out 2")
        db.session.add(w2)

        w3 = Workout(user_id = 3, name = "Kyle's Cool Out 3")
        db.session.add(w3)

        db.session.commit()

        results = Workout.query.filter(Workout.name.like('%Work%')).all()

        for workout in results:
            assert workout.user_id != 3

        for workout in results:
            assert workout.name != "Kyle's Cool Out 3"

        for workout in results:
            assert workout.user_id == 1 or workout.user_id == 2

    def test_find_nothing(self):

        w1 = Workout(user_id = 1, name = "Kyle's Work Out 1")
        db.session.add(w1)

        w2 = Workout(user_id = 2, name = "Kyle's Work Out 2")
        db.session.add(w2)

        w3 = Workout(user_id = 3, name = "Kyle's Cool Out 3")
        db.session.add(w3)

        db.session.commit()

        results = Workout.query.filter(Workout.name.like('%Fred%')).all()

        for workout in results:
            assert False

    def test_find_massive(self):

        for i in range(500):
            w = Workout(user_id = i, name = "Kyle's Work Out %s" % i)
            db.session.add(w)
            if i % 25 == 0:
                db.session.commit()
        
        db.session.commit()

        results = Workout.query.filter(Workout.name.like('%Work%')).all()

        i = 0
        for workout in results:
            i += 1
        assert i == 500
