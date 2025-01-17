import unittest

class TestMyFeature(unittest.TestCase):
    def test_something(self):
        print('Test is running')
        self.assertEqual(2 + 2, 4)