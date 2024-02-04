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

# ANSI escape sequence for green color
green_color = '\033[92m'
# ANSI escape sequence to reset color
reset_color = '\033[0m'

for password in passwords:
    print(f"{green_color}{password}{reset_color}")
