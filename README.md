# S-Squared Enterprises Personnel System
Employee management system ( interview assesment )
## Technologies
Flutter, Firebase Realtime Database, Firebase Hosting
## Functionality
* Instantly view all employees who report to a selected manager.
* Add new employees, with one or more roles.
* Gives the option to auto generate an Employee ID
* Edit the following employee’s properties(done by clicking on the employee row)
  * First Name
  * Last Name
  * Roles( cannot remove a Director role in order to preserve hierarchy )
  
 The application consists of two components. A front-end interface built with the Flutter framework, and a dummy back-end in the form of the Firebase Realtime Database. 
## Postmortem
  Although I am pretty satisfied with how the management system turned out, there are a few things I would change given more ample time. The first being the development of a proper RESTful API using NodeJS and Express. In addition, given the limitations of Firebase’s Realtime Database, I would opt to use Mongoose or SQL Database. These changes would allow a more clear separation of functionality between the two components as well provide more scalability. As it stands now, the front-end contains logic for filtering data. I would also like to expand the functionality of the application by adding employee deletion, and the ability to change an employee’s manager.
