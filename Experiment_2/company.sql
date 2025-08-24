-- Company Database Schema (Lab 2)
-- Author: Ashutosh Sahu 
-- Date:   19 August 2025

DROP DATABASE IF EXISTS CompanyDB;
CREATE DATABASE CompanyDB;
USE CompanyDB;

-- ======================
-- Department
-- ======================
CREATE TABLE Department (
  Dnumber INT PRIMARY KEY,
  Dname VARCHAR(50) NOT NULL UNIQUE,
  Mgr_ssn CHAR(9),
  Mgr_start_date DATE
);

-- ======================
-- Employee
-- ======================
CREATE TABLE Employee (
  SSN CHAR(9) PRIMARY KEY,
  Fname VARCHAR(30) NOT NULL,
  Lname VARCHAR(30) NOT NULL,
  Address VARCHAR(100),
  Salary DECIMAL(10,2),
  Sex CHAR(1) CHECK (Sex IN ('M','F')),
  Bdate DATE,
  Dno INT,
  Super_ssn CHAR(9),
  FOREIGN KEY (Dno) REFERENCES Department(Dnumber),
  FOREIGN KEY (Super_ssn) REFERENCES Employee(SSN)
);

-- Add Manager reference for Department
ALTER TABLE Department
  ADD CONSTRAINT fk_mgr FOREIGN KEY (Mgr_ssn) REFERENCES Employee(SSN);

-- ======================
-- Department Locations
-- ======================
CREATE TABLE Dept_Location (
  Dnumber INT,
  Location VARCHAR(50),
  PRIMARY KEY (Dnumber, Location),
  FOREIGN KEY (Dnumber) REFERENCES Department(Dnumber)
);

-- ======================
-- Project
-- ======================
CREATE TABLE Project (
  Pnumber INT PRIMARY KEY,
  Pname VARCHAR(50) NOT NULL UNIQUE,
  Plocation VARCHAR(50),
  Dnum INT NOT NULL,
  FOREIGN KEY (Dnum) REFERENCES Department(Dnumber)
);

-- ======================
-- Dependent
-- ======================
CREATE TABLE Dependent (
  Essn CHAR(9),
  Dependent_name VARCHAR(30),
  Sex CHAR(1) CHECK (Sex IN ('M','F')),
  Bdate DATE,
  Relationship VARCHAR(20),
  PRIMARY KEY (Essn, Dependent_name),
  FOREIGN KEY (Essn) REFERENCES Employee(SSN)
);

