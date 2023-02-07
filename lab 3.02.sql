DROP SCHEMA IF EXISTS airline;
CREATE SCHEMA airline;
USE airline;

DROP TABLE IF EXISTS customer;

CREATE TABLE customer (
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(60),
    status ENUM('None', 'Silver', 'Gold'),
    mileage INT,
    PRIMARY KEY (id)
);

DESCRIBE customer; -- con esto visualizamos la tabla

DROP TABLE IF EXISTS aricraft;

CREATE TABLE aircraft (
	model VARCHAR(60),
    seats INT,
	PRIMARY KEY (model)
);

DROP TABLE IF EXISTS flight_info;

CREATE TABLE flight_info (
	flight_number VARCHAR(5),
    mileage INT,
    PRIMARY KEY (flight_number)
);

DROP TABLE IF EXISTS flight;

CREATE TABLE flight (
	id INT NOT NULL AUTO_INCREMENT,
	customer_id INT NOT NULL,
    aircraft_model VARCHAR(60),
    flight_info_number VARCHAR(5),
    PRIMARY KEY (id),
	FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (aircraft_model) REFERENCES aircraft(model),
    FOREIGN KEY (flight_info_number) REFERENCES flight_info(flight_number)
);
-- FOREIGN KEY , clave FORANEA QUE ENLAZA TABLAS con las claver primarias .ALTER


INSERT INTO customer (name, status, mileage) VALUES
('Agustine Riviera', 'Silver', 115235),
('Alaina Sepulvida', 'None', 6008),
('Tom Jones', 'Gold', 205767),
('Sam Rio', 'None', 2653),
('Jessica James', 'Silver', 127656),
('Ana Janco', 'Silver', 136773),
('Jennifer Cortez', 'Gold', 300582),
('Christian Janco', 'Silver', 14642);

INSERT INTO aircraft (model, seats) VALUES
('Boeing747', 400),
('AirbusA330', 236),
('Boeing777', 264);

INSERT INTO flight_info (flight_number, mileage) VALUES
('DL143', 135),
('DL122', 4370),
('DL53', 2078),
('DL222', 1765),
('DL37', 531);

INSERT INTO flight (customer_id, aircraft_model, flight_info_number) VALUES
(1,'Boeing747','DL143'),
(1,'AirbusA330','DL122'),
(2,'AirbusA330','DL122'),
(3,'AirbusA330','DL122'),
(3,'Boeing777','DL53'),
(4,'Boeing747','DL143'),
(3,'Boeing777','DL222'),
(5,'Boeing747','DL143'),
(6,'Boeing777','DL222'),
(7,'Boeing777','DL222'),
(5,'AirbusA330','DL122'),
(4,'Boeing747','DL37'),
(8,'Boeing777','DL222');

-- 3
SELECT COUNT(*) FROM flight;

-- 4 
SELECT AVG(mileage) FROM flight_info;

-- 5 
SELECT AVG(seats) FROM aircraft;

-- 6 
SELECT status, AVG(mileage) FROM customer GROUP BY status;

-- 7
SELECT status, MAX(mileage) FROM customer GROUP BY status;

-- 8
SELECT COUNT(aircraft_model) FROM flight WHERE aircraft_model LIKE '%Boeing%';

-- 9
SELECT * FROM flight_info WHERE mileage BETWEEN 300 AND 2000;

-- 10
SELECT status, AVG(mileage) 
FROM customer 
INNER JOIN flight 
ON customer.id = flight.customer_id 
GROUP BY customer.status;

-- 11
SELECT aircraft_model, COUNT(aircraft_model) AS aircraft_recurrence
FROM flight AS f 
JOIN customer AS c ON f.customer_id = c.id
WHERE c.status = 'Gold' 
GROUP BY aircraft_model
ORDER BY aircraft_recurrence DESC
LIMIT 1;
