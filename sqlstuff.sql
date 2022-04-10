DROP DATABASE IF  EXISTS RESTAURANT;
CREATE SCHEMA RESTAURANT;
USE RESTAURANT;


DROP TABLE IF EXISTS DOB;
CREATE TABLE DOB(
    DOB DATE,
    Age int,
    PRIMARY KEY (DOB)
);

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    id int NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Gender VARCHAR(255) NOT NULL,
    DOB DATE NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Salary int NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Designation VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (DOB) REFERENCES DOB(DOB)
    ON UPDATE CASCADE ON DELETE CASCADE
); 

DROP TABLE IF EXISTS Employee2;
CREATE TABLE Employee2 (
    Empid int NOT NULL,
    PhoneNumber int NOT NULL,
    PRIMARY KEY (PhoneNumber),
    CONSTRAINT Employee2_ibfk_1 FOREIGN KEY (Empid) REFERENCES Employee(id)
    ON UPDATE CASCADE ON DELETE CASCADE

);

DROP TABLE IF EXISTS Employee_cashier;
CREATE TABLE Employee_cashier (
    Empid int NOT NULL,
    status int NOT NULL,
    CONSTRAINT Employee_cashier_ibfk_1 FOREIGN KEY (Empid) REFERENCES Employee(id)
    ON UPDATE CASCADE ON DELETE CASCADE
    
);

DROP TABLE IF EXISTS Employee_manager;
CREATE TABLE Employee_manager (
    Empid int NOT NULL,
    No_of_Employees_managing int NOT NULL,
    CONSTRAINT Employee_manager_ibfk_1 FOREIGN KEY (Empid) REFERENCES Employee(id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Employee_cook;
CREATE TABLE Employee_cook (
    Empid int NOT NULL,
    dishes_known varchar(255) NOT NULL,
    CONSTRAINT Employee_cook_ibfk_1 FOREIGN KEY (Empid) REFERENCES Employee(id)
    ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS Food_Items;
CREATE TABLE Food_Items (
    name varchar(255) NOT NULL PRIMARY KEY,
    cost int NOT NULL
);

DROP TABLE IF EXISTS Family;
CREATE TABLE Family (
    name varchar(255) NOT NULL,
    Employee_id int NOT NULL,
    FOREIGN KEY (Employee_id) REFERENCES Employee(id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Franchise_Owners;
CREATE TABLE Franchise_Owners (
  id                                    int NOT NULL,
  name                                  varchar(255) NOT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Supplier;
CREATE TABLE Supplier(
  id                                    int NOT NULL,
  name                                  varchar(255) NOT NULL,
  No_of_Food_Items_Supplied             int NOT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Ingredients;
CREATE TABLE Ingredients(
    name                                varchar(255),
    expiry_date                         date,
    PRIMARY KEY (name)
);

DROP TABLE IF EXISTS Dates;
CREATE TABLE Dates(
    Date_of_Establishment               DATE,
    Years_Since_Establishment           DATE,
    PRIMARY KEY (Date_of_Establishment)
);

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
    location varchar(255) NOT NULL,
    time DATETIME  NOT NULL,
    Bill_total int NOT NULL,
    CONSTRAINT id PRIMARY KEY (location,time)
    
);

DROP TABLE IF EXISTS Delivery_Agent;
CREATE TABLE Delivery_Agent (
    name varchar(255) NOT NULL PRIMARY KEY,
    agency varchar(255) NOT NULL
);

DROP TABLE IF EXISTS Locations;
CREATE TABLE Locations (
    Latitude int NOT NULL,
    Longitude int NOT NULL,
    Address varchar(255) NOT NULL,
    Date_of_Establishment DATE NOT NULL,
    CONSTRAINT Coordinates PRIMARY KEY (Latitude, Longitude)
    
);

DROP TABLE IF EXISTS Works_At;
CREATE TABLE Works_At (
    employee_id int NOT NULL,
    Latitude int NOT NULL,
    Longitude int NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employee(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Latitude, Longitude) REFERENCES Locations(Latitude, Longitude)
    ON UPDATE CASCADE ON DELETE CASCADE
  
);


DROP TABLE IF EXISTS Supply_Chain;
CREATE TABLE Supply_Chain (
  FranchiseOwnerID  int NOT NULL,
  SupplierID        int NOT NULL,
  Latitude          int NOT NULL,
  Longitude         int NOT NULL,
  IngredientsName   varchar(255) NOT NULL,
  FOREIGN KEY (FranchiseOwnerID)        REFERENCES Franchise_Owners(id) 
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (SupplierID)              REFERENCES Supplier(id) 
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (Latitude, Longitude) REFERENCES Locations(Latitude, Longitude) 
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (IngredientsName)         REFERENCES Ingredients(name)
  ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Delivery;
CREATE TABLE Delivery (
    Agent_name varchar(255) NOT NULL,
    Latitude int NOT NULL,
    Longitude int NOT NULL,
    FOREIGN KEY (Agent_name) REFERENCES Delivery_Agent(name) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Latitude, Longitude) REFERENCES Locations(Latitude, Longitude)
    ON UPDATE CASCADE ON DELETE CASCADE
);




DROP TABLE IF EXISTS Dates;
CREATE TABLE Dates(
    Date_of_Establishment               DATE,
    Years_Since_Establishment           DATE,
    PRIMARY KEY (Date_of_Establishment)
);

DROP TABLE IF EXISTS Prepares;
CREATE TABLE Prepares(
    CookId                              int,
    IngredientName                      varchar(255),
    FoodName                            varchar(255),
    FOREIGN KEY (CookId)                REFERENCES Employee_cook(Empid) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (IngredientName)        REFERENCES Ingredients(name) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FoodName)              REFERENCES Food_Items(name)
    ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Manages;
CREATE TABLE Manages(
    Empid int,
    ManagerId int,
    FOREIGN KEY (ManagerId)             REFERENCES Employee_manager(Empid)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Empid)                 REFERENCES Employee(id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    CustomerLocation varchar(255) NOT NULL,
    CustomerTime DATETIME NOT NULL,
    fname varchar(255) NOT NULL,
    FOREIGN KEY (fname) REFERENCES Food_Items(name) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (CustomerLocation,CustomerTime) REFERENCES Customer(location,time)
    ON UPDATE CASCADE ON DELETE CASCADE

);

