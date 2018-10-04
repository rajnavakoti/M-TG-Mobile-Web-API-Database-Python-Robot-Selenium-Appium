import openpyxl
from openpyxl import load_workbook


class test():

    def test_junk(self):
        print("Hello")
        # with open("Testing.json", 'r') as input_file:
        wb = load_workbook(filename='C:/Test/CBA.xls')
        sheet_ranges = wb['range names']
        print(sheet_ranges['A1'].value)


test().test_junk()