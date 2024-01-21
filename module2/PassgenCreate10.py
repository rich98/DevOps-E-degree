import string
import random

def generate_password(length):
    all_characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(all_characters) for _ in range(length))
    return password

def generate_multiple_passwords(count, length):
    return [generate_password(length) for _ in range(count)]

# Generate 10 22-character passwords
passwords = generate_multiple_passwords(10, 22)
for password in passwords:
    print(password)
