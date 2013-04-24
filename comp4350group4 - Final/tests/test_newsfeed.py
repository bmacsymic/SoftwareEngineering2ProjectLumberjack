import os
import unittest
from config import basedir
from lumberjack import app, db
from lumberjack.models.user import *
from datetime import datetime, timedelta
from test_helper import TestHelper
import logging

class TestNewsfeeds(TestHelper):

    def test_feed_creation(self):
        #make users
        u1 = User(username = 'jer', password = '123', email = 'jer@example.com')
        u2 = User(username = 'shaw', password = '123', email = 'shaw@example.com')
        u3 = User(username = 'andy', password = '123', email = 'andy@example.com')
        u4 = User(username = 'cam', password = '123', email = 'cam@example.com')
        db.session.add(u1)
        db.session.add(u2)
        db.session.add(u3)
        db.session.add(u4)
        # make posts
        utcnow = datetime.utcnow()
        p1 = Newsfeed(body = "post from jer", timestamp = utcnow + timedelta(seconds = 1), author = u1)
        p2 = Newsfeed(body = "post from shaw", timestamp = utcnow + timedelta(seconds = 2),  author = u2)
        p3 = Newsfeed(body = "post from andy", timestamp = utcnow + timedelta(seconds = 3),  author = u3)
        p4 = Newsfeed(body = "post from cam", timestamp = utcnow + timedelta(seconds = 4),  author = u4)
        db.session.add(p1)
        db.session.add(p2)
        db.session.add(p3)
        db.session.add(p4)
        db.session.commit()
        # make sure the users have followers to view their posts
        u1.follow(u1)
        u2.follow(u2)
        u3.follow(u3) 
        u4.follow(u4)
        db.session.commit()
        u1.follow(u2) 
        u1.follow(u4)  
        u2.follow(u3) 
        u3.follow(u4) 
        db.session.commit() 
        # check the followed posts of each user
        f1 = u1.followed_posts()
        f2 = u2.followed_posts()
        f3 = u3.followed_posts()
        f4 = u4.followed_posts()
        assert f1 != None
        assert f1.count() == 3
        assert f2 != None
        assert f2.count() == 2
        assert f3 != None
        assert f3.count() == 2
        assert f4 != None
        assert f4.count() == 1
        #remove followers and make sure users CANNOT see newsfeeds now
        u1.unfollow(u1)
        u3.unfollow(u3)
        u4.unfollow(u4)
        db.session.commit()
        u1.unfollow(u2) 
        u1.unfollow(u4)
        u2.unfollow(u2) 
        u2.unfollow(u3) 
        u3.unfollow(u4) 
        db.session.commit()
        f1 = u1.followed_posts()
        f2 = u2.followed_posts()
        f3 = u3.followed_posts()
        f4 = u4.followed_posts()
        #Lenght == 0 but not null
        assert f1.count() == 1
        assert f2.count() == 1
        assert f3.count() == 1
        assert f4.count() == 1   
      
    def test_alternative_feed_creation(self):   
        #make users
        u1 = User(username = 'jer', password = '123', email = 'jer@example.com')
        u2 = User(username = 'shaw', password = '123', email = 'shaw@example.com')
        u3 = User(username = 'andy', password = '123', email = 'andy@example.com')
        u4 = User(username = 'cam', password = '123', email = 'cam@example.com')
        db.session.add(u1)
        db.session.add(u2)
        db.session.add(u3)
        db.session.add(u4)
        db.session.commit()
        # make posts
        p1 = u1.add_newsfeed("first post by jer")
        p2 = u2.add_newsfeed("first post by shaw")
        p3 = u3.add_newsfeed("first post by andy")
        p4 = u4.add_newsfeed("first post by cam")
        db.session.add(p1)
        db.session.add(p2)
        db.session.add(p3)
        db.session.add(p4)
        db.session.commit()
        # make sure the users have followers to view their posts
        u1.follow(u1)
        u2.follow(u2)
        u3.follow(u3) 
        u4.follow(u4)
        db.session.commit()
        u1.follow(u2) 
        u1.follow(u4)  
        u2.follow(u3) 
        u3.follow(u4) 
        db.session.commit() 
        # check the followed posts of each user
        f1 = u1.followed_posts()
        f2 = u2.followed_posts()
        f3 = u3.followed_posts()
        f4 = u4.followed_posts()
        assert f1 != None
        assert f1.count() == 3
        assert f2 != None
        assert f2.count() == 2
        assert f3 != None
        assert f3.count() == 2
        assert f4 != None
        assert f4.count() == 1
        #remove followers and make sure users CANNOT see newsfeeds now
        u1.unfollow(u1) 
        u1.unfollow(u2) 
        u1.unfollow(u4)
        u2.unfollow(u2) 
        u2.unfollow(u3) 
        u3.unfollow(u3) 
        u3.unfollow(u4) 
        u4.unfollow(u4)
        db.session.add(u1)
        db.session.add(u2)
        db.session.add(u3)
        db.session.add(u4)
        db.session.commit()
        f1 = u1.followed_posts()
        f2 = u2.followed_posts()
        f3 = u3.followed_posts()
        f4 = u4.followed_posts()
        #Lenght == 0 but not null
        assert f1.count() == 1
        assert f2.count() == 1
        assert f3.count() == 1
        assert f4.count() == 1 