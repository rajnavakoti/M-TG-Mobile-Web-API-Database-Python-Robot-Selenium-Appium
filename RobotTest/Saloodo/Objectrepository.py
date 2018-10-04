
### Login Page ###

class LoginPageObjects(object):

    def __init__(self, driver):
        self.driver = driver

    User_Name_name = "_email"
    Password_name = "_password"
    Login_button_Main_Page_xpath = "//*[@id=\"gheader\"]/div[1]/div[3]/a[1]"
    Login_button_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[2]/form[1]/button[1]"
    User_ID_Home_Screen_xpath = "//*[@id=\"gheader\"]/div[1]/div[3]/div[3]/div[2]/div[1]"
    LogOut_Button_Xpath = "//*[@id=\"gheader\"]/div[1]/div[3]/div[5]/a[1]"
    Login_Error_Message_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[2]/p[1]"
    Login_Header_Text_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[1]/h1[1]"
    Login_Check_Box_Text_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[2]/form[1]/div[3]/div[1]/label[1]"
    Login_Reset_Password_Link_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[2]/form[1]/div[3]/div[2]"
    User_Name_Mandatory_Message_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[2]/form[1]/div[1]/em[1]"
    Password_Mandatory_Message_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[2]/form[1]/div[2]/em[1]"
    Reset_Password_link_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[2]/form[1]/div[3]/div[2]"
    Reset_Password_Header_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[1]/h1[1]"
    Reset_Password_Message_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[2]/div[1]/p[1]"
    Reset_Password_Email_Textbox_xpath = "//*[@id=\"r-13evq4w1f\"]"
    Reset_Password_Button_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[2]/div[1]/form[1]/button[1]"
    Reset_Password_Error_Message_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[2]/div[1]/form[1]/div[1]/em[1]"
    Reset_Password_Success_Header_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[2]/div[1]/h2[1]"
    Rest_Password_Success_Message_xpath = "//*[@id=\"account\"]/div[1]/div[1]/div[1]/div[2]/div[2]/div[1]/p[1]"