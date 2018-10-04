# import selenium
# from time import sleep
from selenium import webdriver
import unittest
from PageActions import LoginPage
from TestData import TestSuiteData
from Objectrepository import LoginPageObjects



class LoginTestSuite(unittest.TestCase):
    @classmethod
    def setUpClass(self):
        self.driver = webdriver.Firefox()
        self.driver.get("https://demo.saloodo.com/login")

    def test_01_verify_Login_Screen_UI_Elements(self):
        login = LoginPage(self.driver)
        login_po = LoginPageObjects(self.driver)

        actual_header_text = login.get_login_header_text()                              # Step 1 : Verify Login Header
        expected_header_text = TestSuiteData.LoginHeaderText
        self.assertEqual(actual_header_text, expected_header_text)
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Login_Header_Text_xpath).is_displayed())

        actual_check_box_text = login.get_login_check_box_text()                        # Step 2 : Verify checkbox
        expected_check_box_text = TestSuiteData.LoginCheckBoxText
        self.assertEqual(actual_check_box_text, expected_check_box_text)
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Login_Check_Box_Text_xpath).is_displayed())
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Login_Check_Box_Text_xpath).is_enabled())

        actual_reset_pwd_text = login.get_reset_password_link_text()                    # Step 3 : Verify reset password
        expected_reset_pwd_text = TestSuiteData.LoginResetButtonText
        self.assertEqual(actual_reset_pwd_text, expected_reset_pwd_text)
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Login_Reset_Password_Link_xpath).is_displayed())
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Login_Reset_Password_Link_xpath).is_enabled())

        actual_login_button_text = login.get_login_button_text()                        # Step 4 : Verify login button
        expected_login_button_text = TestSuiteData.LoginButtonText
        self.assertEqual(actual_login_button_text, expected_login_button_text)
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Login_button_xpath).is_displayed())
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Login_button_xpath).is_enabled())

    def test_02_Login_with_valid_credentials(self):
        login = LoginPage(self.driver)

        login.EnterUserName(TestSuiteData.test_02_User_Name)                            # Step 1 : Enter User Name
        login.EnterPassword(TestSuiteData.test_02_Password)                             # Step 2 : Enter Password
        login.ClickLogin()                                                              # Step 3 : Click on Login button
        self.assertEqual(self.driver.current_url, TestSuiteData.DashboardURL)           # Step 4 : Verify Login
        actual_user_id = login.GetUserIDonHomeScreen()                                  # Step 5: Verify user ID
        expected_user_id = TestSuiteData.test_02_User_ID_Home_Screen
        self.assertEqual(expected_user_id, actual_user_id)
        login.ClickLogout()                                                             # Step 6 : Logout
        self.assertEqual(self.driver.current_url, TestSuiteData.LogOutURL)              # Step 7 : Verify Logout

    def test_03_Login_with_invalid_username(self):
        self.driver.refresh()

        if self.driver.current_url == TestSuiteData.LoginPageURL or self.driver.current_url == TestSuiteData.LogOutURL:
            login = LoginPage(self.driver)

            login.EnterUserName(TestSuiteData.test_03_User_Name)                        # Step 1 : Enter User Name
            login.EnterPassword(TestSuiteData.test_03_Password)                         # Step 2 : Enter Password
            login.ClickLogin()                                                          # Step 3 : Click on Login button
            actual_error_message = login.VerifyLoginUnsuccessfulMessage()               # Step 4 : Read Error Message
            expected_error_message = TestSuiteData.LoginUnsuccessfulErrorMessage
            self.assertEqual(actual_error_message, expected_error_message)              # Step 5: Verify Error Message
        else:
            self.fail("Browser is not on either Login or Logout Page")

    def test_04_Login_with_invalid_password(self):
        self.driver.refresh()

        if self.driver.current_url == TestSuiteData.LoginPageURL or self.driver.current_url == TestSuiteData.LogOutURL:
            login = LoginPage(self.driver)

            login.EnterUserName(TestSuiteData.test_04_User_Name)                        # Step 1 : Enter User Name
            login.EnterPassword(TestSuiteData.test_04_Password)                         # Step 2 : Enter Password
            login.ClickLogin()                                                          # Step 3 : Click on Login button
            actual_error_message = login.VerifyLoginUnsuccessfulMessage()               # Step 4 : Read Error Message
            expected_error_message = TestSuiteData.LoginUnsuccessfulErrorMessage
            self.assertEqual(actual_error_message, expected_error_message)              # Step 5: Verify Error Message
        else:
            self.fail("Browser is not on either Login or Logout Page")

    def test_05_Login_without_username(self):
        self.driver.refresh()

        if self.driver.current_url == TestSuiteData.LoginPageURL or self.driver.current_url == TestSuiteData.LogOutURL:
            login = LoginPage(self.driver)

            login.EnterUserName(TestSuiteData.test_05_User_Name)                        # Step 1 : Enter User Name
            login.EnterPassword(TestSuiteData.test_05_Password)                         # Step 2 : Enter Password
            login.ClickLogin()                                                          # Step 3 : Click on Login button
            actual_error_message = login.get_user_name_error_message()                  # Step 4 : Read Error Message
            expected_error_message = TestSuiteData.UserNameMandatoryMessageText
            self.assertEqual(actual_error_message, expected_error_message)              # Step 5: Verify Error Message
        else:
            self.fail("Browser is not on either Login or Logout Page")

    def test_06_Login_without_password(self):
        self.driver.refresh()

        if self.driver.current_url == TestSuiteData.LoginPageURL or self.driver.current_url == TestSuiteData.LogOutURL:
            login = LoginPage(self.driver)

            login.EnterUserName(TestSuiteData.test_06_User_Name)                        # Step 1 : Enter User Name
            login.EnterPassword(TestSuiteData.test_06_Password)                         # Step 2 : Enter Password
            login.ClickLogin()                                                          # Step 3 : Click on Login button
            actual_error_message = login.get_password_error_message()                   # Step 4 : Read Error Message
            expected_error_message = TestSuiteData.PasswordMandatoryMessageText
            self.assertEqual(actual_error_message, expected_error_message)              # Step 5: Verify Error Message
        else:
            self.fail("Browser is not on either Login or Logout Page")

    def test_07_verify_Reset_Password_UI_Elements(self):
        login = LoginPage(self.driver)
        login_po = LoginPageObjects(self.driver)

        actual_header_text = login.get_reset_password_header_text()                     # Step 1 : Verify Header text
        expected_header_text = TestSuiteData.ResetPasswordHeaderText
        self.assertEqual(actual_header_text, expected_header_text)
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Reset_Password_Header_xpath).is_displayed())

        actual_message_text = login.get_reset_password_message_text()                   # Step 2 : Verify message text
        expected_message_text = TestSuiteData.ResetPasswordMessageText
        self.assertEqual(actual_message_text, expected_message_text)
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Reset_Password_Message_xpath).is_displayed())

        actual_button_text = login.get_login_button_text()                              # Step 3 : Verify reset button
        expected_button_text = TestSuiteData.ResetButtonText
        self.assertEqual(actual_button_text, expected_button_text)
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Reset_Password_Button_xpath).is_displayed())
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Reset_Password_Button_xpath).is_enabled())

                                                                                        # Step 3 : Verify email textbox
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Reset_Password_Email_Textbox_xpath).is_displayed())
        self.assertTrue(self.driver.find_element_by_xpath(login_po.Reset_Password_Email_Textbox_xpath).is_enabled())

    def test_08_Reset_Password(self):
        self.driver.refresh()

        if self.driver.current_url == TestSuiteData.LoginPageURL or self.driver.current_url == TestSuiteData.LogOutURL:
            login = LoginPage(self.driver)

            login.click_on_reset_password_link()                                        # Step 1 : Click on rest link
            login.enter_email_for_reset_password()                                      # Step 2 : Enter Email ID
            login.click_on_reset_password_link()                                        # Step 3 : Click on reset button
            actual_header_text = login.get_reset_success_header_text()                  # Step 4 : Read header Message
            expected_header_text = TestSuiteData.ResetPasswordHeaderText
            self.assertEqual(actual_header_text, expected_header_text)                  # Step 5: Verify header Message
            actual_success_text = login.get_reset_success_message_text()                # Step 4 : Read header Message
            expected_success_text = TestSuiteData.ResetPasswordMessageText
            self.assertEqual(actual_success_text, expected_success_text)                # Step 5: Verify success Message
        else:
            self.fail("Browser is not on either Login or Logout Page")

    def test_09_login_with_keep_me_logged_in_option(self):
        self.driver.refresh()

        if self.driver.current_url == TestSuiteData.LoginPageURL or self.driver.current_url == TestSuiteData.LogOutURL:
            login = LoginPage(self.driver)

            login.EnterUserName(TestSuiteData.test_09_User_Name)                       # Step 1 : Enter User Name
            login.EnterPassword(TestSuiteData.test_09_Password)                        # Step 2 : Enter Password
            login.select_keep_me_logged_in()                                           # step 3 : select Keep me log in
            login.ClickLogin()                                                         # Step 4 : Click on Login button
            self.assertEqual(self.driver.current_url, TestSuiteData.DashboardURL)      # Step 5 : Verify Login
            actual_user_id = login.GetUserIDonHomeScreen()                             # Step 6 : Verify user ID
            expected_user_id = TestSuiteData.test_09_User_ID_Home_Screen
            self.assertEqual(expected_user_id, actual_user_id)
            login.ClickLogout()                                                        # Step 7 : Logout
            self.assertEqual(self.driver.current_url, TestSuiteData.LogOutURL)         # Step 8 : Verify Logout
        else:
            self.fail("Browser is not on either Login or Logout Page")

    def test_10_navigate_to_login_page_from_main_page(self):
        self.driver.get("https://demo.saloodo.com")
        login = LoginPage(self.driver)                                                 # Step 1 : Navigate to main page
        login.click_login_button_on_main_page()                                        # Step 2 : Click on login button
        self.assertEqual(self.driver.current_url, TestSuiteData.LoginPageURL)          # Step 3 : Verify navigated to login page









