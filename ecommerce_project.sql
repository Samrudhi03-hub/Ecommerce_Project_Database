CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    quantity INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_status ENUM('Pending', 'Completed', 'Failed'),
    payment_method VARCHAR(50),
    amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
INSERT INTO Users (name, email, phone, address) 
VALUES 
('John Doe', 'john@example.com', '9876543210', 'New York, USA'),
('Alice Smith', 'alice@example.com', '9234567890', 'California, USA');

INSERT INTO Products (product_name, price, stock) 
VALUES 
('Laptop', 75000.00, 10),
('Smartphone', 30000.00, 20);

INSERT INTO Orders (user_id, product_id, quantity) 
VALUES 
(1, 1, 1),  -- John ordered 1 Laptop
(2, 2, 2);  -- Alice ordered 2 Smartphones

INSERT INTO Payments (order_id, payment_status, payment_method, amount) 
VALUES 
(1, 'Completed', 'Credit Card', 75000.00),
(2, 'Pending', 'UPI', 60000.00);

SELECT Orders.order_id, Users.name, Products.product_name, Orders.quantity, Orders.order_date
FROM Orders
JOIN Users ON Orders.user_id = Users.user_id
JOIN Products ON Orders.product_id = Products.product_id;

SELECT Products.product_name, SUM(Orders.quantity) AS total_sold
FROM Orders
JOIN Products ON Orders.product_id = Products.product_id
GROUP BY Products.product_name;

SELECT Payments.payment_id, Users.name, Payments.amount, Payments.payment_status 
FROM Payments
JOIN Orders ON Payments.order_id = Orders.order_id
JOIN Users ON Orders.user_id = Users.user_id
WHERE Payments.payment_status = 'Pending';


