-- Create the database
CREATE DATABASE citywatch;
USE citywatch;

-- Create the user table
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the usergroup table with dependency on the user table
CREATE TABLE usergroup (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    usertype VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
);

-- Create the address table with dependency on the user table
CREATE TABLE address (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    state_name VARCHAR(100) NOT NULL,
    zipcode VARCHAR(10) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
);

-- Create the Categoryreport table
CREATE TABLE Categoryreport (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE
);

-- Create the department table
CREATE TABLE department (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE
);

-- Create the reports table with dependencies on user, Categoryreport, and department tables
CREATE TABLE reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    category_id INT,
    department_id INT NULL,
    longitude DECIMAL(10, 8) NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    priority INT NOT NULL,
    imageurl VARCHAR(255),
    description TEXT,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categoryreport(id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES department(id) ON DELETE SET NULL
);

-- Sample data for user
INSERT INTO user (name, email, password, phone_number) 
VALUES ('John Doe', 'john.doe@example.com', 'securepassword', '123-456-7890');

-- Sample data for usergroup with reference to a user
INSERT INTO usergroup (user_id, usertype) 
VALUES (1, 'Admin');

-- Sample data for address with reference to a user
INSERT INTO address (user_id, state_name, zipcode) 
VALUES (1, 'California', '90001');

-- Sample data for Categoryreport
INSERT INTO Categoryreport (title) 
VALUES ('Monthly Report'), ('Quarterly Analysis'), ('Annual Summary');

-- Sample data for department
INSERT INTO department (title) 
VALUES ('Human Resources'), ('Finance'), ('Engineering');

-- Sample data for reports with reference to user, Categoryreport, and department
INSERT INTO reports (user_id, category_id, department_id, longitude, latitude, priority, imageurl, description) 
VALUES (1, 1, 1, -118.2437, 34.0522, 1, 'https://example.com/image1.jpg', 'Description of the report 1.'),
       (1, 2, NULL, -122.4194, 37.7749, 2, 'https://example.com/image2.jpg', 'Description of the report 2.');
