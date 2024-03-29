# Passgen.py Password Genertator

Run the script at the copmmand line.

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

# PassgenCreate10_in_green.py Password Genertator

Run the script at the copmmand line. see pass_gen_10_green.png

In this code, generate_multiple_passwords is a new function that generates a specified number of passwords, each of a specified length. It uses a list comprehension to call generate_password the specified number of times, and returns a list of the generated passwords. Then, it prints each password in the list. You can adjust the number of passwords and their length as needed.

It also proves that the passwords are being created randomly

I have also submitted a example of passwords when set to produce 10 50 character passwords. A password from this list was tested online at https://www.security.org/how-secure-is-my-password/

# New graphical version passgen2b.pyw

This Python code generates random passwords and saves them to a text file. It uses the tkinter library to create a graphical user interface (GUI) with two input fields. One is for the desired password length, and the other is for the number of passwords to generate. When the user clicks the “Generate Passwords” button, the code generates the specified number of passwords and displays them in a message box. It also saves the passwords to a text file named “genpass2.txt” in the current working directory.

# passgen3words.zip

You will need to update line 6, the path ro the word file.

The theory of using three random words for passwords is a strategy recommended by the National Cyber Security Centre (NCSC) for creating strong, memorable passwords¹³. Here's why it works:
1. **Memorability**: Our brains are better at recalling information that forms a narrative or has contextual meaning². The 'Three Random Words' method aligns with this understanding by creating a password structure that is more natural for our brains to encode and retrieve².

2. **Visualization**: When users create passwords using the 'Three Random Words' strategy, they are more likely to visualize the words as images, forming a mental picture². This imagery makes the password more memorable².

3. **Cognitive Load**: Traditional strong passwords, with their complexity and lack of inherent meaning, place a high cognitive load on users². The 'Three Random Words' method reduces this load, making the passwords easier to remember².

4. **Security**: Passwords generated from three random words help users to create unique passwords that are strong enough for many purposes³. They are more effective than complex combinations because they are less predictable and harder for cybercriminals to guess¹³.

5. **Usability**: This method is also good for those who aren’t aware of password managers, or are reluctant to use them³.

For instance, a password like "SunsetDragonTeacup" evokes more vivid mental imagery than a random string like "Sd93!7&Z"². It's easier to remember and still provides a high level of security. However, it's important to note that this method may not be necessary or suitable for all organizations³.

Source: Conversation with Bing, 15/03/2024
(1) . https://bing.com/search?q=theory+of+3+random+words+for+passwords.
(2) NCSC Sticks by 'Three Random Words' Strategy for Passwords. https://www.infosecurity-magazine.com/news/ncsc-three-random-words-passwords/.
(3) The Psychology of Passwords: A Deep Dive into the NCSC's Three Random .... https://www.wrecltd.co.uk/blog/the-psychology-of-passwords-a-deep-dive-into-the-ncscs-three-random-words-strategy/.
(4) Passwords: why you should use three random word passphrases. https://blog.tecala.co.uk/passwords-why-you-should-use-three-random-word-passphrases/.
(5) Three random words - NCSC. https://www.ncsc.gov.uk/collection/top-tips-for-staying-secure-online/three-random-words.
(6) undefined. https://www.ncsc.gov.uk/pdfs/news/ncsc-lifts-lid-on-three-random-words-password-logic.pdf.
# Weight-con.py Weight Convertor

The code imports the os and sys modules. os provides a way to use operating system-dependent functionality, and sys provides access to some variables used or maintained by the Python interpreter.

**Funtions:**

These are conversion functions for weight units. For example, kg_lb converts kilograms to pounds, g_oz converts grams to ounces, and so on.

def g_oz(mass):
    return mass * 0.03527396

def lb_kg(mass):
    return mass * 0.453592

def oz_g(mass):
    return mass * 28.3495

**Mapping Menu Choices to Functions:**

A dictionary menu is created where keys are integers representing menu choices, and values are corresponding conversion functions or the string 'quit' for the exit option.
menu = {
    1: kg_lb,
    2: g_oz,
    3: lb_kg,
    4: oz_g,
    5: 'quit'
}

**Menu Loop:**

This creates an infinite loop for displaying the menu. It attempts to clear the console using 'cls' for Windows (os.name == 'nt') and 'clear' for other operating systems.

while True:
    os.system('cls' if os.name == 'nt' else 'clear')  # Clear the console
    print("1: kg to lb\n2: g to oz\n3: lb to kg\n4: oz to g\n5: Quit")

**User Input:**

The code attempts to get an integer input from the user representing their choice.

try:
    choice = int(input('Make your choice: '))

**Handling User Choice:**

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

**Handling Errors:**

Catches a ValueError exception if the user inputs something that cannot be converted to an integer, and prints an error message.

except ValueError:
    print("Invalid input!")

This code provides a simple interactive menu for converting weights between different units, running in a loop until the user chooses to quit. The os.system line is used to clear the console, and the code handles user input and displays conversion results.

# Calc.py Simple calculator 

This simple calculator program performs basic arithmetic operations (addition, subtraction, multiplication, and division) based on user input. The script is written in Python and includes functionality to clear the console screen for a more user-friendly interface.

**Clearing the Console:**
This part uses the os module to clear the console screen. It checks the operating system (os.name) and uses 'cls' for Windows and 'clear' for other operating systems.

import os
os.system('cls' if os.name == 'nt' else 'clear')  # Clear the console

**Arithmetic Functions:**
These are functions for performing basic arithmetic operations. The divide function includes a check to prevent division by zero.

Define a function to add two numbers
def add(x, y):
    return x + y

Define a function to subtract two numbers
def subtract(x, y):
    return x - y

Define a function to multiply two numbers
def multiply(x, y):
    return x * y

Define a function to divide two numbers, with a check for division by zero
def divide(x, y):
    if y != 0:
        return x / y
    else:
        return 'Error! Division by zero is not allowed.'

**Main Loop and User Interface:**
This section displays a menu for the user with options for arithmetic operations and an option to exit the program.

Main loop to keep the program running
while True:
    Display the menu for the user
    print("Select operation:")
    print("1. Add")
    print("2. Subtract")
    print("3. Multiply")
    print("4. Divide")
    print("5. Exit")

**User Input and Operation Execution:**

This part takes user input for the choice of operation and performs the selected operation based on the user's input. It also asks the user to press Enter before continuing.

Get user choice
    choice = input("Enter choice (1/2/3/4/5): ")

Check if the choice is a valid operation (1 to 4)
    if choice in ('1', '2', '3', '4'):
        num1 = float(input("Enter first number: "))
        num2 = float(input("Enter second number: "))

Perform the selected operation based on user input
        if choice == '1':
            print(num1, "+", num2, "=", add(num1, num2))
        elif choice == '2':
            print(num1, "-", num2, "=", subtract(num1, num2))
        elif choice == '3':
            print(num1, "*", num2, "=", multiply(num1, num2))
        elif choice == '4':
            print(num1, "/", num2, "=", divide(num1, num2))

Ask the user to press Enter before continuing
        input("Press Enter to continue...")

**Exiting the Program and handlie invalid input:**  

If the user chooses the exit option, the program prints a message and breaks out of the main loop, effectively ending the program.
If the user enters an invalid choice, the program informs the user that the input is invalid.

Check if the user wants to exit the program
    elif choice == '5':
        print("Exiting the program.")
        break
    else:
        print("Invalid Input")

**Clearing the Screen Again:**

After performing the operation or handling invalid input, the script clears the console screen before displaying the menu again.

os.system('cls' if os.name == 'nt' else 'clear')  # Clear the console

The script creates a simple console-based calculator with a user-friendly interface and the ability to clear the screen for better interaction.
