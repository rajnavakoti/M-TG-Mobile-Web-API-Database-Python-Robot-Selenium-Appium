import appium
import unittest, time, os
import subprocess
from appium import webdriver
from subprocess import Popen
from time import sleep

class PythonFunctions():
    def round_of_number(self,a):
        c = format (float(a),'.2f')
        print c
        return c

    def start_appium_server(self):
        #self.appium = subprocess.Popen('appium', shell=True)
        subprocess.Popen('appium -a 127.0.0.1 -p 4723', shell=True)
        time.sleep(5)
        #desired_caps = dict()
        #desired_caps['platformName'] = 'Android'
        #desired_caps['platformVersion'] = '5.1.1'
        #desired_caps['deviceName'] = 'ZH8006HQCF'
        #desired_caps['app'] = os.path.abspath('AndroidSampleApp.apk')
        #desired_caps['appPackage'] = 'com.vbanthia.androidsampleapp'
        #desired_caps['appActivity'] = 'com.vbanthia.androidsampleapp.MainActivity'
        #self.driver = webdriver.Remote('http://localhost:4723/wd/hub', desired_caps)
        #return self.driver

    def stop_appium_server(self):
        #self.driver.quit()
        subprocess.Popen('taskkill /F /IM node.exe', shell=True)

