create database Library;
use Library;

create table Branch(Branch_no int primary key, Manager_id int, Branch_address varchar(50), Contact_no int);
create table Employee(Emp_id int primary key, Emp_name varchar(30), Position varchar(20), Salary int);
create table Emp(Emp_id int primary key, Emp_name varchar(30), Position varchar(20), Salary int, br_id int);
create table Customer(Customer_id int primary key, Customer_name varchar(30), Customer_address varchar(50),Reg_date date);
create table Books(isbn int primary key, Book_title varchar(30), Category varchar(20), Rental_price float,
					Status varchar(5) default 'Yes', Author varchar(30), Publisher varchar(30));
create table Issue_Status(Issue_id int primary key, Issued_cust int, Issued_book_name varchar(30),
						Issue_date date, isbn_book int,
						foreign key(Issued_cust) references Customer(Customer_id),
						foreign key(isbn_book) references Books(isbn));
create table Return_Status(Return_id int primary key, Return_cust int, Return_book_name varchar(30), Return_date date,
							isbn_book2 int, foreign key(isbn_book2) references Books(isbn));

insert into Branch values(101,100,'Public Library,New Delhi',98765432),(102,101,'Mahatma Library,Gujrat',98211234),
(103,102,'GSI Library,Nagpur',90765432),(104,103,'Excel Library,Chennai',89796544),(105,104,'Public Library,Cochin',99878965);

insert into Employee values(100,'Antony','Manager',55000),(101,'Annie','Librarian',28000),(103,'Bob','IT support',20000),
		(104,'Edwin','Manager','40000'),(105,'Lilly','Librarian',18000),(106,'Tina','Manager',52000),(107,'Adam','Manager',45000),
        (108,'Geni','Manager',540000);

insert into Emp values(100,'Antony','Manager',20000,101),(101,'Annie','Librarian',18000,102),(103,'Bob','IT support',18000,103),
		(104,'Edwin','Manager','20000',101),(105,'Lilly','Librarian',18000,104),(106,'Tina','Manager',20000,101),(107,'Adam','Manager',20000,101),
        (108,'Geni','Manager',20000,101);

insert into customer values(100,'Aarya','New Delhi','2020-09-12'),(101,'Babu','Chennai','2021-01-03'),(103,'Ashwathi','Cochin','2020-02-03'),
		(104,'Denny','Gujrat','2022-08-14'),(105,'Clara','Cochin','2020-12-12'),(106,'Jojo','Nagpur','2021-08-03'),
        (107,'Freddy','Nagpur','2021-05-06'),(108,'Arun','Chennai','2022-10-03');

insert into books values(1,'Discovery of India', 'History', 25,default,'Jawaharlal Nehru', 'Rupa Publications'),
						(2,'Harry Potter','Fiction',30,default, 'JK Rowling','Bloomsberry'),
                        (3, 'Arabian Nights', 'Fiction',20,'No','Richard Burton','Roli Books'),
                        (4,'Principles of Science','Science', 25,default,'William Stanley','Bloomsberry'),
                        (5,'Three Mistakes in My life','Fiction',20,'No','Chetan Bhagat','Rupa Publications'),
                        (6,'The life of Elizabeth','History',30,default,'Allison Weir','Bloomsberry');

insert into issue_status values(1,100,'Arabian Nights','2023-06-06',3),(2,103,'Principles of Science','2023-06-04',4),
							   (3,104,'Harry Potter','2022-12-12',2),(4,104,'Three Mistakes in My life','2022-12-12',5),
                               (5,105,'The life of Elizabeth','2021-03-12',6),(6,105,'Arabian Nights','2021-03-12',3);
                               
insert into return_status values(1,104,'Harry Potter','2023-01-10',2),(2,105,'The life of Elizabeth','2021-04-12',6),
								(3,105,'Arabian Nights','2021-04-12',3);
                                
-- Queries --
  
-- Retrieves the book title, category, and rental price of all available books --
select Book_title,Category,Rental_price from books where Status='Yes';

-- Lists the employee names and their respective salaries in descending order of salary --
select Emp_name, Salary from employee order by Salary desc;

-- Retrieves the book titles and the corresponding customers who have issued those books --
select issue_status.Issued_book_name, customer.Customer_name 
from issue_status join customer
on issue_status.Issued_cust = customer.Customer_id;

-- Displays the total count of books in each category--
select category, count(isbn)  from books group by category;

-- Retrieves the employee names and their positions for the employees whose salaries are above Rs.50,000 --
select Emp_name, Position from employee where Salary>=50000;

-- Lists the customer names who registered before 2022-01-01 and have not issued any books yet --
select Customer_name from customer where Reg_date < '2022-01-01' and
 Customer_id not in(select Issued_cust from issue_status);
 
 -- Displays the branch numbers and the total count of employees in each branch --
 select branch.Branch_no, count(employee.Emp_name) 
 from branch join employee
 on branch.Manager_id = employee.Emp_id
 group by branch.Branch_no;
 
 select branch.Branch_no, count(emp.Emp_name) 
 from branch join emp
 on branch.Branch_no = emp.br_id
 group by branch.Branch_no;
 
 -- Displays the names of customers who have issued books in the month of June 2023 --
 select customer.Customer_name from 
 customer join issue_status
 on customer.Customer_id = issue_status.Issued_cust 
 where issue_status.Issue_date > '2023-06-01' and issue_status.Issue_date <= '2023-06-30';
 
 -- Retrieves book_title from book table containing history --
 select Book_title from books where  Book_title like '%India%';
 
 -- Retrieves the branch numbers along with the count of employees for branches having more than 5 employees --
 select br_id, count(Emp_id) from emp group by br_id having count(Emp_id)>=5;
 



        
        
