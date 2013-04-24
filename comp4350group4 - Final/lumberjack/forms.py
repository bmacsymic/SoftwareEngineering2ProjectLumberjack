from flask import flash
from flask.ext.wtf import Form, TextField, BooleanField, PasswordField
from flask.ext.wtf import Required, EqualTo
from lumberjack.models.user import User
import json

class RegistrationForm(Form):
    username = TextField('Username', validators = [Required()])
    password = PasswordField('Password', validators = [Required(),
                                        EqualTo('confirm', message='Passwords do not match!')])

    confirm = PasswordField('Confirm Password', validators = [Required()])

    def validate(self):
        valid_form = Form.validate(self)
        if not valid_form:
            return False

        user = User.find_by_username(self.username.data)
        if user != None:
            self.username.errors.append('Username ' + self.username.data + ' is already taken')
            return False
        return True

    def to_json(self):
        return json.dumps({'errors': self.errors})

class LoginForm(Form):
    username = TextField('username', validators = [Required()])
    password = PasswordField('password',  validators = [Required()])
    #remember_me = BooleanField('remember_me', default = False)

    def validate(self):
        valid_form = Form.validate(self)
        if not valid_form:
            return False

        user = User.find_by_username(self.username.data)
        if user is None:
            #self.username.errors.append('User does not exist!')
            flash("User does not exist!", "error")
            self.username.errors.append('User does not exist!') 
            return False
        if not user.valid_password(self.password.data):
            flash('Invalid password!', "error")
            self.password.errors.append('Invalid Password')
            return False
        self.user = user
        return True

    def to_json(self):
        return json.dumps({'errors': self.errors})
