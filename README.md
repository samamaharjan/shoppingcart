# shoppingcart
Below are the components that are required to install the web application in the server. 
	Any Linux or Windows operating system.  
	MySQL server version 5.7.29 or 5.7.X
	Apache Tomcat server version 8.5.x.
	JDK version 1.8.x
  
Create database schema and tables using scdb.sql script available in the source code.
  
Create below db user in mysql database:
  CREATE USER 'ap_sc'@'%' IDENTIFIED BY 'Get@it01!';
  GRANT ALL ON *.* TO 'ap_sc'@'%' WITH GRANT OPTION;
  
Create war file from the source code and deploy in tomcat webapps directory.
