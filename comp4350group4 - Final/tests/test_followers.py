
import os
import unittest
from config import basedir
from lumberjack import app, db
from lumberjack.models.user import User
from test_helper import TestHelper

class TestFollowers(TestHelper):

  def test_follow_unfollow_methods(self):
        #make users
        u1 = User(username = 'jer', password = '123', email = 'jer@example.com')
        u2 = User(username = 'shaw', password = '123', email = 'shaw@example.com')
        db.session.add(u1)
        db.session.add(u2)
        db.session.commit()
        assert u1.unfollow(u2) == None
        u = u1.follow(u1)
        u2 = u2.follow(u2)
        u3 = u2.follow(u1)
        db.session.add(u)
        db.session.add(u2)
        db.session.add(u3)
        db.session.commit()
        assert u2.follow(u1) == None
        assert u1.is_following(u1)
        assert u1.followed.count() == 1
        assert u1.followed.first().username == 'jer'
        assert u2.followers.count() == 1
        assert u2.followed.count() == 2
        assert u2.followers.first().username == 'shaw'
        u1.unfollow(u2)
        db.session.commit()
        assert u1.is_following(u2) == False
        assert u1.followed.count() == 1
        assert u2.followers.count() == 1

  def test_user_followers_method(self):
        #make users
        u1 = User(username = 'jer', password = '123', email = 'jer@example.com')
        u2 = User(username = 'shaw', password = '123', email = 'shaw@example.com')
        u3 = User(username = 'andy', password = '123', email = 'andy@example.com')
        db.session.add(u1)
        db.session.add(u2)
        db.session.add(u3)
        db.session.commit()
        assert u1.unfollow(u2) == None
        u = u1.follow(u2)
        uf = u3.follow(u1)
        uf2 = u3.follow(u2)
        uf3 = u3.follow(u3)
        db.session.add(u)
        db.session.add(uf2)
        db.session.add(uf3)
        db.session.commit()
        assert u1.follow(u2) == None
        assert u1.is_following(u2)
        assert u1.followed.count() == 1
        assert u1.followed.first().username == 'shaw'
        #Test desired method
        uf1 = u1.user_is_following()
        uf2 = u2.user_is_following()
        uf3 = u3.user_is_following()
        assert uf1.count() == 1 
        assert uf2.count() == 0
        assert uf3.count() == 3
        
  def test_follow_self(self):
        #make users
        u1 = User(username = 'jer', password = '123', email = 'jer@example.com')
        u2 = User(username = 'shaw', password = '123', email = 'shaw@example.com')
        u3 = User(username = 'andy', password = '123', email = 'andy@example.com')
        db.session.add(u1)
        db.session.add(u2)
        db.session.add(u3)
        #make users follow themselves
        f1 = u1.follow(u1) 
        f2 = u2.follow(u2)
        f3 = u3.follow(u3)
        db.session.add(f1)
        db.session.add(f2)
        db.session.add(f3)
        db.session.commit()
        #make sure they are following themselves
        assert u1.is_following(u1)
        assert u2.is_following(u2)
        assert u3.is_following(u3)
             
  def test_attempt_unfollow_self(self):
        #make users
        u1 = User(username = 'jer', password = '123', email = 'jer@example.com')
        u2 = User(username = 'shaw', password = '123', email = 'shaw@example.com')
        u3 = User(username = 'andy', password = '123', email = 'andy@example.com')
        db.session.add(u1)
        db.session.add(u2)
        db.session.add(u3)
        #set followers
        f1 = u1.follow(u1) 
        f2 = u2.follow(u2)
        f3 = u3.follow(u3)
        f4 = u2.follow(u3)
        db.session.add(f1)
        db.session.add(f2)
        db.session.add(f3)
        db.session.add(f4)
        db.session.commit()
        assert u2.is_following(u3) == True
        #Try to unfollow self on u1 and u2, and u2 unfollow u3 for comparison
        u1.unfollow(u1)
        db.session.commit()
        u2.unfollow(u2)
        db.session.commit()
        u2.unfollow(u3)
        db.session.commit()
        #After the unfollow, u1,u2 still following themselvs but u2 not following u3
        assert u1.is_following(u1) == True
        assert u2.is_following(u2) == True
        assert u2.is_following(u3) == False
        
        