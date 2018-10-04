import random
import string





class UtilityKeywords(object):

    def generate_family_name(self):
        """ Generates random family name """
        return ''.join(random.choice(string.ascii_uppercase) for _ in range(1)) + ''.join(random.choice(string.ascii_lowercase) for _ in range(7))