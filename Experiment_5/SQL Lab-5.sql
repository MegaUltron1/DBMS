create database Suppliers;

use Suppliers;

create table Supplier (
scode int primary key,
sname varchar(50),
scity varchar(50),
turnover int
);

create table Part (
pcode int primary key,
weigh int,
color varchar(20),
cost int,
sellingprice int
);

create table Supplier_Part (
scode int,
pcode int,
qty int, 
primary key (scode, pcode),
foreign key(scode) references Supplier(scode),
foreign key(pcode) references Part(pcode)
);

INSERT INTO Supplier (scode, sname, scity, turnover) VALUES
(101, 'Alpha Supplies', 'Bombay', 50),
(102, 'Beta Traders', 'Delhi', 80),
(103, 'Gamma Distributors', 'Bombay', NULL),
(104, 'Delta Corp', 'Chennai', 120),
(105, 'Epsilon Ltd', 'Pune', 200);

INSERT INTO Part (pcode, weigh, color, cost, sellingprice) VALUES
(1, 20, 'Red', 20, 25),
(2, 30, 'Blue', 30, 45),
(3, 35, 'Green', 40, 55),
(4, 40, 'Yellow', 25, 35),
(5, 50, 'Black', 60, 75);

INSERT INTO Supplier_Part (scode, pcode, qty) VALUES
(101, 2, 100),   
(102, 1, 50),
(102, 3, 30),
(103, 2, 70),    
(104, 4, 20),
(105, 5, 60);

-- Get the supplier number and part number in ascending order of supplier number 
select scode, pcode from Supplier_Part order by scode, pcode asc;

-- Get the details of supplier who operate from Bombay with turnover 50. 
select * from Supplier where scity = "Bombay" and turnover = 50; 

-- Get the total number of supplier
select sum(qty) from Supplier_Part;
-
-- Get the part number weighing between 25 and 35.
select pcode from Part where weigh between 25 and 35;

-- Get the supplier number whose turnover is null.
select scode from Supplier where turnover is null; 

-- Get the part number that cost 20, 30 or 40 rupees
select pcode from Part where cost = 20 or cost = 30 or cost = 40;