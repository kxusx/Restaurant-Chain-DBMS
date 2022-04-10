import subprocess as sp
import pymysql
import pymysql.cursors
from tabulate import tabulate
import os
import time
from dotenv import load_dotenv
load_dotenv()

# import sqlalchemy as db
def updateEmployeeInfo():
    id = int(input("Employee id:"))
    email = input("Email:")
    salary = int(input("Salary:"))
    address = input("Address:")
    query = f"Update Employee SET Email='{email}', Salary={salary}, Address='{address}' WHERE id = {id}" 

    try:
        cur.execute(query)
        con.commit()

    except Exception as e:
        con.rollback()
        print(e)

def InsertEmployee():
    id = int(input("Employee id:"))
    name = input("name:")
    gender = (input("gender:"))
    Date_of_birth = input("DOB:")
    email = input("email:")
    salary = int(input("salary:"))
    latitude = int(input("Latitude : "))
    longitude = int(input("Longitude : "))
    address = input("Address:")
    designation = input("designation:")
    
    Age =10
    query2 = f"INSERT INTO DOB VALUES ('{Date_of_birth}', {Age})"
    cur.execute(query2)
    con.commit()
     
        
    
    query = f"INSERT INTO Employee VALUES ({id}, '{name}', '{gender}', '{Date_of_birth}', '{email}', {salary}, '{address}', '{designation}')"
    try:
        cur.execute(query)
        con.commit()
    except Exception as e:
        con.rollback()
        print(e)

    query3 = f"INSERT INTO Works_At Values ({id}, {latitude}, {longitude})"
    try:
        cur.execute(query3)
        con.commit()
    except Exception as e:
        con.rollback()
        print(e)
     
    if designation.lower() == "cashier":
        status = int(input("Status: "))
        query2 = f"INSERT INTO Employee_cashier VALUES ({id}, {status})"
        try:
            cur.execute(query2)
            con.commit()

        except Exception as e:
            con.rollback()
            print(e)
    elif designation.lower() == "manager":
        no_of_employees = int(input("No. of employees managaing: "))
        query2 = f"INSERT INTO Employee_manager VALUES ({id}, {no_of_employees})"
        try:
            cur.execute(query2)
            con.commit()

        except Exception as e:
            con.rollback()
            print(e)
    elif designation.lower() == "cook":
        dishes_known = input("Dishes known: ")
        query2 = f"INSERT INTO Employee_cook VALUES ({id}, '{dishes_known}')"
        try:
            cur.execute(query2)
            con.commit()

        except Exception as e:
            con.rollback()
            print(e)

def SpecialFood():
    foodname = input("Food name:")
    price = int(input("Price:"))
   
    query = f"INSERT INTO Food_Items VALUES  ('{foodname}', {price});"
    try:
        cur.execute(query)
        con.commit()

    except Exception as e:
        con.rollback()
        print(e)

def EmployeeLeave():
    del_id= int(input("Employee id: "))
   
    query = f"DELETE FROM Employee WHERE id = {del_id}"
   
    try:
        cur.execute(query)
        con.commit()

    except Exception as e:
        con.rollback()
        print(e)

def InsertLocations():
    latitude = int(input("Latitude : "))
    longitude = int(input("Longitude : "))
    address = input("Address : ")
    date_of_establishment = input("Date_of_establishment : ")
    tuple = (latitude, longitude, address,date_of_establishment)
    query = f"INSERT INTO Locations VALUES ({latitude}, {longitude}, '{address}', '{date_of_establishment}');"
    try:
        cur.execute(query)
        con.commit()
    except Exception as e:
        con.rollback()
        print(e)
###################################################

def updatefoodprice():
    foodname = input("Food name:")
    price = int(input("Price:"))
    query = f"Update Food_Items SET cost={price} WHERE name= '{foodname}'"

    try:
        cur.execute(query)
        con.commit()
    except Exception as e:
        con.rollback()
        print(e)

def updateSupplierdetails():
    SupplierId = int(input("Supplier Id:"))
    number = int(input("New number of Food Items supplied:"))
    query = f"Update Supplier SET No_of_Food_Items_Supplied={number} WHERE id={SupplierId}" 

    try:
        cur.execute(query)
        con.commit()
    except Exception as e:
        con.rollback()
        print(e)

def EmployeeLocation():
    latitude = int(input("Latitude : ")) 
    longitude = int(input("Longitude : "))
    query = f"SELECT * FROM Employee WHERE id IN (SELECT employee_id FROM Works_At WHERE Latitude = {latitude} AND Longitude = {longitude})"
    try:
        cur.execute(query)
        result =cur.fetchall()
        print(tabulate(result, headers="keys", tablefmt='psql'))
        con.commit()
    except Exception as e:
        con.rollback()
        print(e)

def SalaryAbove():
    salary = int(input("Above Salary : "))

    
    query = f"SELECT * FROM Employee WHERE Salary>{salary}"
    try:
        cur.execute(query)
        result =cur.fetchall()
        print(tabulate(result, headers="keys", tablefmt='psql'))
        con.commit()
    except Exception as e:
        con.rollback()
        print(e)

def NoOFEmployeesAtEachLocation():
    query = f"SELECT Latitude,Longitude, COUNT(*) FROM Works_At GROUP BY Latitude,Longitude"
    try:
        cur.execute(query)
        result =cur.fetchall()
        print(tabulate(result, headers="keys", tablefmt='psql'))
        con.commit()
    except Exception as e:
        con.rollback()
        print(e)

def EmployeeInformationBasedonName():
    name = input("Enter Name")
    query = f"SELECT * FROM Employee WHERE Name = '{name}'"
    try:
        cur.execute(query)
        result =cur.fetchall()
        print(tabulate(result, headers="keys", tablefmt='psql'))
        con.commit()
    except Exception as e:
        con.rollback()
        print(e)


def dispatch(ch):
    if ch == 1:
        InsertEmployee()
    elif ch == 2:
        updateEmployeeInfo()
    elif ch == 3:
        InsertLocations()
    elif ch == 4:
        SpecialFood()
    elif ch ==5:
        EmployeeLeave()
    elif ch == 6:
        updateSupplierdetails()
    elif ch ==7:
        updatefoodprice()
    elif ch ==8:
        EmployeeLocation()
    elif ch ==9:
        SalaryAbove()
    elif ch ==10:
        NoOFEmployeesAtEachLocation()
    elif ch ==11:
        EmployeeInformationBasedonName()

while True:
    tmp = sp.call('clear', shell=True)

    try:
        con = pymysql.connect(host = "localhost",user = "root",password = "Underdogs2020101116@",database = "RESTAURANT",cursorclass = pymysql.cursors.DictCursor)
        tmp = sp.call('clear', shell=True)
        if (con.open):
            print("Successfully Connected to the Database")
        else:
            print("Failed to connect")

        tmp = input("Enter any key to CONTINUE > ")
        with con.cursor() as cur:
            
            while(1):
                tmp = sp.call('clear', shell=True)
                # Here taking example of Employee Mini-world
                print("1. Insert Employee")  # Hire an Employee
                print("2. Update Employee")  # Fire an Employee
                print("3. Insert Location")  # Promote Employee
                print("4. Insert Food")  # Employee Statistics
                print("5. Delete Employee")
                print("6. Update Supply Details")
                print("7. Update Food Details ")
                print("8. Employee Locations ")
                print("9. Salary Above ")
                print("10. No of employees at each location ")
                print("11. Employee INfo Based on ")
                print("20. Logout")
                ch = int(input("Enter choice> "))
                tmp = sp.call('clear', shell=True)
                if ch == 20:
                    exit()
                else:
                    dispatch(ch)
                    tmp = input("Enter any key to CONTINUE>")
               
    except Exception as e:
        tmp = sp.call('clear', shell=True)
        print("Connection Refused: Either username or password is incorrect or you don't have the permissions to access the database")
        tmp = input("Enter any key to Retry or type 'q' to exit: ")
        if tmp == "q":
            break


    
