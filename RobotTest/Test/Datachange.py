import json
from collections import OrderedDict




def test_junk():
       print("Hello")
       #with open("Testing.json", 'r') as input_file:
       #input_data = input_file.read()
       jsonfile = open('Testing', "r")  # Open the JSON file for reading
       data = json.load(jsonfile, object_pairs_hook=OrderedDict)
       jsonfile.close()
       tmp = data["included"][0]["attributes"]["given-name"]
       data["included"][0]["attributes"]["given-name"] = "Test Name4"
       jsonfile = open("Testing", "w+")
       jsonfile.write(json.dumps(data))
       jsonfile.close()
        # data = json.load(jsonfile.mode() , encoding=UnicodeTranslateError, object_pairs_hook=OrderedDict)
        # data = json.load(jsonfile)  # Read the JSON into the buffer
        # print(tmp)
       tata = json.dumps(data)
       print(tata)
       jsonfile.close()  # Close the JSON file
       return tmp









