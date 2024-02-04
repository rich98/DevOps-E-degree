Password Genertator

**Passgen.py**

This code defines a Python function to generate a random password of a specified length using a combination of letters (both uppercase and lowercase), digits, and punctuation characters. Here's a breakdown of the code:
The string module provides a collection of string constants, and the random module is used to generate random values.

import string

import random

The generate_password function takes a single parameter length, which represents the desired length of the generated password.
string.ascii_letters contains all the ASCII letters (both lowercase and uppercase).
string.digits contains all the digits (0-9).
string.punctuation contains all ASCII punctuation characters.
all_characters is a string concatenation of the three character sets mentioned above, creating a pool of characters from which the password will be generated.
random.choice(all_characters) is used inside a list comprehension to randomly select characters from the all_characters pool. This process is repeated length times.
password is constructed by joining the selected characters into a single string.
The generated password is then returned.


def generate_password(length):
    all_characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(all_characters) for _ in range(length))
    return password

The generated password is then printed to the console.

print(generate_password(22))
The script calls the generate_password function with an argument of 22 to generate a 22-character password.

The code provides a simple function for generating random passwords of a specified length using a combination of letters, digits, and punctuation characters. The generated password is then printed to the console in this specific case with a length of 22 characters.

**PassgenCreate10.py**

In this code, generate_multiple_passwords is a new function that generates a specified number of passwords, each of a specified length. It uses a list comprehension to call generate_password the specified number of times, and returns a list of the generated passwords. Then, it prints each password in the list. You can adjust the number of passwords and their length as needed.

It also proves that the passwords are being creted randomly

I have also submitted a example of passwords when set to produce 10 50 character passwords. A password from this list was tested online at https://www.security.org/how-secure-is-my-password/


**Weight Convertor**

The code imports the os and sys modules. os provides a way to use operating system-dependent functionality, and sys provides access to some variables used or maintained by the Python interpreter.

# Funtions:

These are conversion functions for weight units. For example, kg_lb converts kilograms to pounds, g_oz converts grams to ounces, and so on.

def g_oz(mass):
    return mass * 0.03527396

def lb_kg(mass):
    return mass * 0.453592

def oz_g(mass):
    return mass * 28.3495

# Mapping Menu Choices to Functions:

A dictionary menu is created where keys are integers representing menu choices, and values are corresponding conversion functions or the string 'quit' for the exit option.
menu = {
    1: kg_lb,
    2: g_oz,
    3: lb_kg,
    4: oz_g,
    5: 'quit'
}

# Menu Loop:

This creates an infinite loop for displaying the menu. It attempts to clear the console using 'cls' for Windows (os.name == 'nt') and 'clear' for other operating systems.

while True:
    os.system('cls' if os.name == 'nt' else 'clear')  # Clear the console
    print("1: kg to lb\n2: g to oz\n3: lb to kg\n4: oz to g\n5: Quit")

# User Input:

The code attempts to get an integer input from the user representing their choice.

try:
    choice = int(input('Make your choice: '))

# Handling User Choice:

Checks if the user's choice is a valid menu option. If the choice is 'quit' (5), it prints a goodbye message and breaks out of the loop.
If the choice is a valid conversion option, it prompts the user to enter a weight, performs the conversion using the selected function, and prints the result.

if choice in menu:
    if choice == 5:
        print("Goodbye!")
        break
    mass = float(input('Enter weight to convert: '))
    result = menu[choice](mass)
    print(result)
    input("Press Enter to continue...")
else:
    print("Invalid choice!")

# Handling Errors:

Catches a ValueError exception if the user inputs something that cannot be converted to an integer, and prints an error message.

except ValueError:
    print("Invalid input!")

This code provides a simple interactive menu for converting weights between different units, running in a loop until the user chooses to quit. The os.system line is used to clear the console, and the code handles user input and displays conversion results.
