Password Genertator

**Passgen.py**

It imports the string and random modules.
It defines a function generate_password(length) that generates a random password of a given length. Here’s what happens inside this function:
It creates a string all_characters that contains all ASCII letters (both lowercase and uppercase), digits, and punctuation symbols. This is done by concatenating string.ascii_letters, string.digits, and string.punctuation.

It then generates the password. This is done by choosing a random character from all_characters for the number of times specified by length. The random.choice() function is used to pick a random character, and this is done in a loop that runs length times. The chosen characters are joined together into a string using the join() method, and this string is the generated password.
Finally, it calls generate_password(22), which generates a 22-character password, and prints this password.
So, if you run this script, it will print out a randomly generated 12-character password. The password will contain a mix of lowercase letters, uppercase letters, digits, and punctuation symbols. Each run will likely produce a different password because of the randomness. This can be useful for creating strong, hard-to-guess passwords.
If you want to adjust the length of the password change the value in generate_password(22) longer of shorter

**PassgenCreate10.py**

In this code, generate_multiple_passwords is a new function that generates a specified number of passwords, each of a specified length. It uses a list comprehension to call generate_password the specified number of times, and returns a list of the generated passwords. Then, it prints each password in the list. You can adjust the number of passwords and their length as needed.

It also proves that the passwords are being creted randomly

I have also submitted a example of passwords when set to produce 10 50 character passwords. A password from this list was tested online at https://www.security.org/how-secure-is-my-password/


**Weight Convertor**

The code imports the os and sys modules. os provides a way to use operating system-dependent functionality, and sys provides access to some variables used or maintained by the Python interpreter.

Funtions:

These are conversion functions for weight units. For example, kg_lb converts kilograms to pounds, g_oz converts grams to ounces, and so on.

def g_oz(mass):
    return mass * 0.03527396

def lb_kg(mass):
    return mass * 0.453592

def oz_g(mass):
    return mass * 28.3495

Mapping Menu Choices to Functions:

A dictionary menu is created where keys are integers representing menu choices, and values are corresponding conversion functions or the string 'quit' for the exit option.
menu = {
    1: kg_lb,
    2: g_oz,
    3: lb_kg,
    4: oz_g,
    5: 'quit'
}

Menu Loop:

This creates an infinite loop for displaying the menu. It attempts to clear the console using 'cls' for Windows (os.name == 'nt') and 'clear' for other operating systems.

while True:
    os.system('cls' if os.name == 'nt' else 'clear')  # Clear the console
    print("1: kg to lb\n2: g to oz\n3: lb to kg\n4: oz to g\n5: Quit")

User Input:

The code attempts to get an integer input from the user representing their choice.

try:
    choice = int(input('Make your choice: '))

Handling User Choice:

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

Handling Errors:

Catches a ValueError exception if the user inputs something that cannot be converted to an integer, and prints an error message.


except ValueError:
    print("Invalid input!")

This code provides a simple interactive menu for converting weights between different units, running in a loop until the user chooses to quit. The os.system line is used to clear the console, and the code handles user input and displays conversion results.
