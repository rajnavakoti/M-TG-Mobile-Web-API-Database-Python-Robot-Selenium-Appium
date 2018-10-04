import unittest
import selenium
from selenium import webdriver
from selenium.webdriver.common import keys

class example():
    def setUp(self):
        self.driver = webdriver.Firefox()
    def fucntionone(self):
        driver = self.driver
        driver.get("http://google.com")

myobject = example()
myobject.setUp()
myobject.fucntionone()


