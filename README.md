# CRUD-EmployeeAttribute

## Description

The desired functionality of the project is about managing the employees and their attributes. 
Through the application one must be able to view, create, modify, and delete employees. 
For each employee, one must be able to view, add, modify and delete employee attributes. 
 
Both these views must be visible from the same “page”. 
At the top one would see the list of all employees. 
Selecting one employee, under the employee listing view one would be able to edit the selected employee details (name, date of hire, supervisor). 
For the selected employee, one would be also able to see a listing of all employee’s attributes and from there to add, view, and modify those, under the same approach as for the employee. 
Selecting one attribute, a view with the attribute details is presented and from there the name and value can be edited.
 
All styling should be through CSS files in the browser.  
 
The functionality of the application shall be also available via JSON REST web services. 

The project consists of two parts:

Part 1 - SQL
Prepare for SQL programming: 
	- Create a new Database on the database platform of choice. Name it as you prefer. 
	- Comprehend and modify/execute the schema scripts to create the tables and constraints depending on the database platform selected. 
	- Comprehend and modify/execute the data scripts to populate the database with initial data. 
Author the following SQL Scripts on the platform of choice: 
	- Create a script that will add an attribute of type 'Weight' and with a value set to 'Thin' to all employees. If an employee already has a 'Weight' attribute, update that attribute, otherwise create a new one. 
	- Create a script that will add an attribute of type 'Height' and with a value set to 'Short' to all employees that are supervisors of anybody else. If an employee already has a 'Height' attribute, update that attribute, otherwise create a new one. 
	- Initialization scripts are provided in T-SQL dialect. 
	
Part 2 -Web Application
The web application is to be implemented via the MVC framework relevant to the technology selected for the implementation of the application. The restrictions of the implementation are as follows:  
 
- The application must use the MVC framework and should operate mainly via ajax callbacks for performing user actions. 
- The front end must be entirely based on HTML/JS/CSS and jQuery / jQueryUI, employing AJAX callbacks  

* Developed with IntelliJ 2018
* Tested with Google Chrome and Mozilla Firefox

## Languages, Frameworks and Libraries:
###### Back End
- Java
- Spring Boot
- JPA/Hibernate
- JavaServer Pages(JSP)
###### Front End
- HTML/CSS/JavaScript
- JQuery
- Bootstrap CSS
- Font Awesome
###### Database
- MySql
