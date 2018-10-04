from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions
from Objectrepository import LoginPageObjects
from TestData import TestSuiteData

class LoginPage(object):

    def __init__(self, driver):
        # type: (object) -> object
        self.driver = driver
    def EnterUserName(self, username):

        self.driver.find_element_by_name(LoginPageObjects.User_Name_name).send_keys(username)
    def EnterPassword(self, password):

        self.driver.find_element_by_name(LoginPageObjects.Password_name).send_keys(password)
    def ClickLogin(self):

        self.driver.find_element_by_xpath(LoginPageObjects.Login_button_xpath).click()

    def GetUserIDonHomeScreen(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.User_ID_Home_Screen_xpath)))
        actual_user_id = self.driver.find_element_by_xpath(LoginPageObjects.User_ID_Home_Screen_xpath).text
        return actual_user_id

    def ClickLogout(self):

        self.driver.find_element_by_xpath(LoginPageObjects.LogOut_Button_Xpath).click()

    def VerifyLoginUnsuccessfulMessage(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Login_Error_Message_xpath)))
        ActualErrorMessage = self.driver.find_element_by_xpath(LoginPageObjects.Login_Error_Message_xpath).text
        return ActualErrorMessage

    def get_login_check_box_text(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Login_Check_Box_Text_xpath)))
        check_box_text = self.driver.find_element_by_xpath(LoginPageObjects.Login_Check_Box_Text_xpath).text
        return check_box_text

    def get_reset_password_link_text(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Login_Reset_Password_Link_xpath)))
        reset_password_link_text = self.driver.find_element_by_xpath(LoginPageObjects.Login_Reset_Password_Link_xpath).text
        return reset_password_link_text

    def get_login_header_text(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Login_Header_Text_xpath)))
        login_header_text = self.driver.find_element_by_xpath(LoginPageObjects.Login_Header_Text_xpath).text
        return login_header_text

    def get_login_button_text(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Login_button_xpath)))
        login_button_text = self.driver.find_element_by_xpath(LoginPageObjects.Login_button_xpath).text
        return login_button_text

    def get_user_name_error_message(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.User_Name_Mandatory_Message_xpath)))
        error_message = self.driver.find_element_by_xpath(LoginPageObjects.User_Name_Mandatory_Message_xpath).text
        return error_message

    def get_password_error_message(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Password_Mandatory_Message_xpath)))
        error_message = self.driver.find_element_by_xpath(LoginPageObjects.Password_Mandatory_Message_xpath).text
        return error_message

    def get_reset_password_header_text(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Reset_Password_Header_xpath)))
        header_text = self.driver.find_element_by_xpath(LoginPageObjects.Reset_Password_Header_xpath).text
        return header_text

    def get_reset_password_message_text(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Reset_Password_Message_xpath)))
        message_text = self.driver.find_element_by_xpath(LoginPageObjects.Reset_Password_Message_xpath).text
        return message_text

    def click_on_reset_password_link(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Login_Reset_Password_Link_xpath)))
        self.driver.find_element_by_xpath(LoginPageObjects.Login_Reset_Password_Link_xpath).click()

    def enter_email_for_reset_password(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Reset_Password_Email_Textbox_xpath)))
        self.driver.find_element_by_xpath(LoginPageObjects.Reset_Password_Email_Textbox_xpath).send_keys()

    def click_on_reset_password_button(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Reset_Password_Button_xpath)))
        self.driver.find_element_by_xpath(LoginPageObjects.Reset_Password_Button_xpath).click()

    def get_reset_success_header_text(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Reset_Password_Success_Header_xpath)))
        header_text = self.driver.find_element_by_xpath(LoginPageObjects.Reset_Password_Success_Header_xpath).text
        return header_text

    def get_reset_success_message_text(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Rest_Password_Success_Message_xpath)))
        message_text = self.driver.find_element_by_xpath(LoginPageObjects.Rest_Password_Success_Message_xpath).text
        return message_text

    def select_keep_me_logged_in(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Login_Check_Box_Text_xpath)))
        self.driver.find_element_by_xpath(LoginPageObjects.Login_Check_Box_Text_xpath).click()

    def click_login_button_on_main_page(self):

        wait = WebDriverWait(self.driver, 10)
        wait.until(expected_conditions.presence_of_element_located((By.XPATH, LoginPageObjects.Login_button_Main_Page_xpath)))
        self.driver.find_element_by_xpath(LoginPageObjects.Login_button_Main_Page_xpath).click()
