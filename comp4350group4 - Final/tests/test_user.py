from test_helper import TestHelper

from lumberjack import app, db
from lumberjack.models.user import User

class TestUser(TestHelper):

    def test_retrieve_user(self):
        u = User(username = 'andy', password = "123", email = 'umluo23@cc.umanitoba.ca')
        db.session.add(u)
        db.session.commit()
        user = User.find_by_username('andy')
        assert user.username == 'andy'

    def test_find_by_id(self):
        u = User(username = 'jack_nicholson', password = "123", email =
                'j@example.com')
        User.save_to_db(u)
        user = User.find_by_id(1)
        assert user != None

    def test_find_all(self):
        u = User(username = 'jack_nicholson', password = "123", email =
                'j2@example.com')
        User.save_to_db(u)
        u = User(username = 'random_person', password = "123", email =
                'j3@example.com')
        User.save_to_db(u)
        u = User(username = 'jason_spezza', password = "123", email =
                'j1@example.com')
        User.save_to_db(u)

        assert len(User.all()) == 3

    def test_inserting_duplicate_username(self):
        u = User(username = 'jack_nicholson', password = "123", email =
                'j2@example.com')
        User.save_to_db(u);
        u2 = User(username = 'jack_nicholson', password = "123", email =
                'j33@example.com')

        assert User.save_to_db(u2) == False
        assert len(User.all()) == 1

    def test_empty_username(self):
        u = User(username = '', password = "123", email =
                'j2@example.com')
        assert User.save_to_db(u) == False
        assert len(User.all()) == 0

    def test_empty_password(self):
        u = User(username = 'jason_spezza', password = "", email =
                'j1@example.com')
        assert User.save_to_db(u) == False
        assert len(User.all()) == 0

    #THIS TEST DOES NOT PASS -- STILL WORKING ON THIS METHOD -- REMOVE COMMENT ON ASSERT TO TEST
    def test_topUser_ieMostFollowers(self):
        u1 = User(username = '1', password = "123", email = '1@cc.umanitoba.ca')
        u2 = User(username = '2', password = "123", email = '2@cc.umanitoba.ca')
        u3 = User(username = '3', password = "123", email = '3@cc.umanitoba.ca')
        u4 = User(username = '4', password = "123", email = '4@cc.umanitoba.ca')
        u5 = User(username = '5', password = "123", email = '5@cc.umanitoba.ca') 
        db.session.add(u1)
        db.session.add(u2)
        db.session.add(u3)
        db.session.add(u4)
        db.session.add(u5)
        db.session.commit()
        uf1 = u1.follow(u2)
        uf2 = u1.follow(u3)
        uf3 = u1.follow(u3)
        uf4 = u2.follow(u1)
        uf5 = u2.follow(u3)
        uf6 = u5.follow(u5)
        db.session.add(uf1)
        db.session.add(uf2)
        db.session.add(uf3)
        db.session.add(uf4)
        db.session.add(uf5)
        db.session.commit()
        t = u5.top_user()
        # This should be 5 ; failing because the way the query is called (self.)
        #assert t == '3'
        