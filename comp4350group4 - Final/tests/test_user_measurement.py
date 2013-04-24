from test_helper import TestHelper

from lumberjack import app, db
from lumberjack.models.user_measurement import UserMeasurement
from lumberjack.models.user import User
from datetime import datetime, timedelta

class TestUserMeasurement(TestHelper):

    def test_find_all_by_user_id(self):
        u = User(username = 'jack_nicholson', password = "123", email = 'j@example.com')
        another_user = User(username = 'andy', password = "123", email = 'umluo23@cc.umanitoba.ca')
        User.save_to_db(u)
        User.save_to_db(another_user)
        measurement1 = UserMeasurement(user_id=1, type="distance ran", value=2, unit="miles")
        measurement2 = UserMeasurement(user_id=1, type="distance ran", value=5, unit="miles")
        measurement3 = UserMeasurement(user_id=2, type="distance ran", value=23, unit="miles")

        UserMeasurement.save_to_db(measurement1)
        UserMeasurement.save_to_db(measurement2)
        UserMeasurement.save_to_db(measurement3)
        u_measurements = UserMeasurement.find_all_by_user_id(u.id)
        assert len(u_measurements) == 2

    def test_get_latest_measurement_for_each_type_by_user(self):
        u = User(username = 'jack_nicholson', password = "123", email = 'j@example.com')
        bieber = User(username = 'justin_beiber', password = "123", email = 'beibs@example.com')
        another_user = User(username = 'andy', password = "123", email = 'umluo23@cc.umanitoba.ca')
        User.save_to_db(u)
        User.save_to_db(another_user)
        User.save_to_db(bieber)

        measurement_list = []
        measurement_list.append(UserMeasurement(user_id=1, type="distance ran", value=2, unit="miles", date=datetime.now()))
        u_latest_distance_ran =datetime.now() + timedelta(minutes =10)
        measurement_list.append(UserMeasurement(user_id=1, type="distance ran", value=5, unit="miles", date=u_latest_distance_ran))
        measurement_list.append(UserMeasurement(user_id=2, type="distance ran", value=23, unit="miles",date=datetime.now() + timedelta(minutes =15)))
        measurement_list.append(UserMeasurement(user_id=1, type="height", value=5, unit="cm", date=datetime.now()))
        u_latest_height = date=datetime.now() + timedelta(minutes =3)
        measurement_list.append(UserMeasurement(user_id=1, type="height", value=5, unit="cm", date=u_latest_height))
        u_latest_weight = datetime.now() + timedelta(minutes = 20)
        measurement_list.append(UserMeasurement(user_id=1, type="weight", value=23, unit="lbs", date=u_latest_weight))

        for measurement in measurement_list:
            UserMeasurement.save_to_db(measurement)

        u_measurements = UserMeasurement.latest_measurement_for_each_type_by_user(u.id)
        assert len(u_measurements) == 3

        u_measurements_types = [m.type for m in u_measurements]
        assert len(u_measurements_types) == len(set(u_measurements_types))

        for m in u_measurements:
            if m.type == "distance ran":
                u_dist_ran = m
            elif m.type == "height":
                u_height = m
            elif m.type == "weight":
                u_weight = m

        assert u_dist_ran.date == u_latest_distance_ran
        assert u_height.date == u_latest_height
        assert u_weight.date == u_latest_weight

    def test_measurement_history_by_user(self):
        u = User(username = 'jack_nicholson', password = "123", email = 'j@example.com')
        bieber = User(username = 'justin_beiber', password = "123", email = 'beibs@example.com')
        User.save_to_db(u)
        User.save_to_db(bieber)
        measurement_list = []
        measurement_list.append(UserMeasurement(user_id=1, type="distance ran", value=2, unit="miles", date=datetime.now()))
        u_latest_distance_ran =datetime.now() + timedelta(minutes =10)
        measurement_list.append(UserMeasurement(user_id=1, type="distance ran", value=5, unit="miles", date=u_latest_distance_ran))
        measurement_list.append(UserMeasurement(user_id=1, type="distance ran", value=23, unit="miles",date=datetime.now() + timedelta(minutes =15)))
        for measurement in measurement_list:
            UserMeasurement.save_to_db(measurement)

        u_measurements = UserMeasurement.measurement_history_by_user(u.id, "distance ran")
        beiber_measurements = UserMeasurement.measurement_history_by_user(bieber.id, "distance ran")

        assert len(u_measurements) == 3
        assert len(beiber_measurements) == 0
        
        u_measurements_types = [m.type for m in u_measurements]
        assert len(set(u_measurements_types)) == 1
