import unittest
from lumberjack.utility import is_blank

class TestUtility(unittest.TestCase):
    def test_is_blank_identifies_blank_strings(self):
        blanks = ["", " ", " \n\n\n ", None]
        for string in blanks:
            assert is_blank(string) == True

    def test_is_blank_ignores_valid_strings(self):
        strings = ["hi", "h", "hel212"]
        for string in strings:
            assert is_blank(string) != True
