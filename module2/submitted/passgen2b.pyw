import os
import string
import random
import tkinter as tk
from tkinter import messagebox

def generate_password(length):
    all_characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(all_characters) for i in range(length))
    return password

def show_passwords():
    password_length = int(entry_length.get())
    num_passwords = int(entry_num.get())
    passwords = [generate_password(password_length) for _ in range(num_passwords)]
    password_str = '\n'.join(passwords)  # Join passwords with '\n' to display them line by line
    messagebox.showinfo("Generated Passwords", password_str)

    # Write the passwords to a text file
    with open(os.path.join(os.getcwd(), 'genpass2.txt'), 'w') as f:
        f.write(password_str)

    # Write the passwords to a text file
    with open(os.path.join(os.getcwd(), 'genpass2.txt'), 'w') as f:
        for password in passwords:
            f.write(password + '\n')  # use '\n' instead of '\\n'

# Create the main window
root = tk.Tk()
root.title("Password Generator")

# Create a label and entry field for the password length
label_length = tk.Label(root, text="Enter the desired password length:")
label_length.pack()
entry_length = tk.Entry(root)
entry_length.pack()

# Create a label and entry field for the number of passwords
label_num = tk.Label(root, text="Enter the number of passwords to generate:")
label_num.pack()
entry_num = tk.Entry(root)
entry_num.pack()

# Create a button that will call the show_passwords function when clicked
button = tk.Button(root, text="Generate Passwords", command=show_passwords)
button.pack()

# Run the event loop
root.mainloop()
