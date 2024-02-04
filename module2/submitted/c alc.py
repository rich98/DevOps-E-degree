#import os
import os
os.system('cls' if os.name == 'nt' else 'clear')  # Clear the console
# Define a function to add two numbers
def add(x, y):
    return x + y

# Define a function to subtract two numbers
def subtract(x, y):
    return x - y

# Define a function to multiply two numbers
def multiply(x, y):
    return x * y

# Define a function to divide two numbers, with a check for division by zero
def divide(x, y):
    if y != 0:
        return x / y
    else:
        return 'Error! Division by zero is not allowed.'

# Main loop to keep the program running
while True:
    # Display the menu for the user
    print("Select operation:")
    print("1. Add")
    print("2. Subtract")
    print("3. Multiply")
    print("4. Divide")
    print("5. Exit")

    # Get user choice
    choice = input("Enter choice (1/2/3/4/5): ")

    # Check if the choice is a valid operation (1 to 4)
    if choice in ('1', '2', '3', '4'):
        num1 = float(input("Enter first number: "))
        num2 = float(input("Enter second number: "))

        # Perform the selected operation based on user input
        if choice == '1':
            print(num1, "+", num2, "=", add(num1, num2))
        elif choice == '2':
            print(num1, "-", num2, "=", subtract(num1, num2))
        elif choice == '3':
            print(num1, "*", num2, "=", multiply(num1, num2))
        elif choice == '4':
            print(num1, "/", num2, "=", divide(num1, num2))

        # Ask the user to press Enter before continuing
        input("Press Enter to continue...")
        
    # Check if the user wants to exit the program
    elif choice == '5':
        print("Exiting the program.")
        break

    # Handle invalid input
    else:
        print("Invalid Input")

    # Clear the screen before displaying the menu again
    os.system('cls' if os.name == 'nt' else 'clear')  # Clear the console
