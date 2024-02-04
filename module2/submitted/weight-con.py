# -*- coding:utf-8 -*-
#!/usr/bin/python3

# Conversion functions
def kg_lb(mass):
    return mass * 2.20462

def g_oz(mass):
    return mass * 0.03527396

def lb_kg(mass):
    return mass * 0.453592

def oz_g(mass):
    return mass * 28.3495

# Mapping menu choices to functions
menu = {
    1: kg_lb,
    2: g_oz,
    3: lb_kg,
    4: oz_g
}

print("1: kg to lb\n2: g to oz\n3: lb to kg\n4: oz to g")
try:
    choice = int(input('Make your choice: '))
    if choice in menu:
        mass = float(input('Enter weight to convert: '))
        result = menu[choice](mass)
        print(result)
    else:
        print("Invalid choice!")
except ValueError:
    print("Invalid input!")
