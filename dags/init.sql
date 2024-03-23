
CREATE TABLE IF NOT EXISTS customers (
  "cust_id" int PRIMARY KEY,
  "cust_firstname" varchar(50),
  "cust_lastname" varchar(50)
);
INSERT INTO "customers" ("cust_id", "cust_firstname", "cust_lastname") VALUES
(1, 'Chinonso', 'Okonkwo'),
(2, 'Fatoumata', 'Diallo'),
(3, 'Kwame', 'Osei'),
(4, 'Ngozi', 'Chukwu'),
(5, 'Musa', 'Abdullahi'),
(6, 'Aisha', 'Nkosi'),
(7, 'Amara', 'Okafor'),
(8, 'Adeola', 'Oladele'),
(9, 'Sekou', 'Diop'),
(10, 'Zainab', 'Suleiman');


CREATE TABLE IF NOT EXISTS item (
  "item_id" varchar(10) PRIMARY KEY,
  "sku" varchar(20) UNIQUE,
  "item_name" varchar(100),
  "item_cat" varchar(50),
  "item_size" varchar(20),
  "item_price" decimal(10,2)
);
INSERT INTO item (item_id, sku, item_name, item_cat, item_size, item_price)
VALUES ('P001', 'PIZZA01', 'Pepperoni Pizza', 'Pizza', 'Medium', 12.99),
       ('P002', 'PIZZA02', 'Veggie Pizza', 'Pizza', 'Medium', 10.99),
       ('P003', 'PIZZA03', 'Hawaiian Pizza', 'Pizza', 'Medium', 11.50),
       ('DRNK01', 'DRINK01', 'Soft Drink (Can)', 'Drinks', '330ml', 1.50),
       ('SIDE01', 'SIDE01', 'Garlic Bread', 'Sides', '', 3.00);

CREATE TABLE IF NOT EXISTS inventory (
  "inv_id" int PRIMARY KEY,
  "item_id" varchar(10),
  "quantity" int
);
-- Assuming you start with some stock
INSERT INTO inventory (inv_id, item_id, quantity)
VALUES (1, 'I001', 5000),  -- 5kg Flour
       (2, 'I002', 2000),  -- 2kg Mozzarella Cheese
       (3, 'I003', 3000),  -- 3L Tomato Sauce
       (4, 'I004', 1000),  -- 1kg Pepperoni
       (5, 'I005', 1500),  -- 1.5kg Italian Sausage
       (6, 'I006', 500),   -- 500 Green Peppers
       (7, 'I007', 400),   -- 400 Onions
       (8, 'I008', 750),   -- 750g Black Olives
       (9, 'I009', 800),   -- 800g Mushrooms
       (10, 'I010', 250);  -- 250g Basil Leaves

CREATE TABLE IF NOT EXISTS address (
  "add_id" int PRIMARY KEY,
  "delivery_address1" varchar(200),
  "delivery_address2" varchar(200),
  "delivery_city" varchar(50),
  "delivery_zipcode" varchar(20)
);
INSERT INTO address (add_id, delivery_address1, delivery_address2, delivery_city, delivery_zipcode)
VALUES (1, '12 Acacia Lane', 'Apartment B', 'Sun Valley', '01234'),
       (2, '45 Mango Street', '', 'Lagos', '98765'),
       (3, '7 Cheetah Road', '', 'Nairobi', '54321'),
       (4, '8 Baobab Boulevard', '', 'Cape Town', '23456'),
       (5, '1 Flamingo Way', '', 'Accra', '10987');

CREATE TABLE IF NOT EXISTS ingredient (
  "ing_id" varchar(10) PRIMARY KEY,
  "ing_name" varchar(200),
  "ing_weight" int,
  "ing_meas" varchar(20),
  "ing_price" decimal(5,2)
);
INSERT INTO ingredient (ing_id, ing_name, ing_weight, ing_meas, ing_price)
VALUES ('I001', 'Flour (All-Purpose)', 1000, 'Grams', 2.50),
       ('I002', 'Mozzarella Cheese', 500, 'Grams', 4.00),
       ('I003', 'Tomato Sauce', 750, 'Milliliters', 3.25),
       ('I004', 'Pepperoni', 250, 'Grams', 5.75),
       ('I005', 'Italian Sausage', 300, 'Grams', 6.25),
       ('I006', 'Green Pepper', 200, 'Each', 1.00),
       ('I007', 'Onion', 250, 'Each', 0.75),
       ('I008', 'Black Olives', 150, 'Grams', 2.25),
       ('I009', 'Mushrooms', 200, 'Grams', 1.50),
       ('I010', 'Basil Leaves', 50, 'Grams', 0.50);

CREATE TABLE IF NOT EXISTS recipe (
  "row_id" int PRIMARY KEY,
  "recipe_id" varchar(20),
  "ing_id" varchar(10),
  "quantity" int
);

INSERT INTO recipe (row_id, recipe_id, ing_id, quantity)
-- Recipe for PIZZA01 (Pepperoni Pizza)
VALUES (1, 'PIZZA01', 'I001', 200),  -- 200g Flour
       (2, 'PIZZA01', 'I002', 250),  -- 250g Mozzarella Cheese
       (3, 'PIZZA01', 'I003', 150),  -- 150ml Tomato Sauce
       (4, 'PIZZA01', 'I004', 150),  -- 150g Pepperoni
       (5, 'PIZZA01', 'I006', 1),    -- 1 Green Pepper
       (6, 'PIZZA01', 'I007', 1),    -- 1 Onion
       (7, 'PIZZA01', 'I010', 5),   -- 5g Basil Leaves

-- Recipe for PIZZA02 (Veggie Pizza)
      (8, 'PIZZA02', 'I001', 200),  -- 200g Flour
       (9, 'PIZZA02', 'I002', 250),  -- 250g Mozzarella Cheese
       (10, 'PIZZA02', 'I003', 150),  -- 150ml Tomato Sauce
       (11, 'PIZZA02', 'I006', 2),    -- 2 Green Peppers
       (12, 'PIZZA02', 'I007', 1),    -- 1 Onion
       (13, 'PIZZA02', 'I009', 150),  -- 150g Mushrooms
       (14, 'PIZZA02', 'I010', 5),   -- 5g Basil Leaves

-- Recipe for PIZZA03 (Hawaiian Pizza)
        (15, 'PIZZA03', 'I001', 200),  -- 200g Flour
       (16, 'PIZZA03', 'I002', 250),  -- 250g Mozzarella Cheese
       (17, 'PIZZA03', 'I003', 150),  -- 150ml Tomato Sauce
       (18,'PIZZA03', 'I004', 75),   -- 75g Pepperoni
       (19,'PIZZA03', 'I008', 100),  -- 100g Black Olives
       (20, 'PIZZA03', 'I009', 100),  -- 100g Mushrooms
       (21, 'PIZZA03', 'I010', 5);   -- 5g Basil Leaves

CREATE TABLE IF NOT EXISTS orders (
  "row_id" int PRIMARY KEY,
  "order_id" varchar(10),
  "created_at" timestamp UNIQUE,
  "item_id" varchar(10),
  "quantity" int,
  "cust_id" int,
  "delivery" boolean,
  "add_id" int
);

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_id, delivery, add_id)
VALUES (1,'ORD0001', '2024-03-22 12:00:00', 'P001', 1, 1, TRUE, 1),
       (2,'ORD0002', '2024-03-22 13:15:00', 'P002', 2, 2, FALSE, 4),
       (3,'ORD0003', '2024-03-22 14:30:00', 'P003', 1, 3, TRUE, 2),
       (4,'ORD0004', '2024-03-22 15:45:00', 'DRNK01', 2, 4, TRUE, 3),
       (5,'ORD0005', '2024-03-22 16:00:00', 'P001', 1, 5, FALSE, 1),
       (6,'ORD0006', '2024-03-22 17:15:00', 'SIDE01', 2, 1, TRUE, 4),
       (7,'ORD0007', '2024-03-22 18:30:00', 'P002', 1, 3, TRUE, 5),
       (8,'ORD0007', '2024-03-22 18:30:01', 'DRNK01', 1, 3, TRUE, 5),
       (9,'ORD0008', '2024-03-22 19:20:00', 'P003', 1, 2, FALSE, 3),
       (10,'ORD0008', '2024-03-22 19:00:00', 'SIDE01', 1, 2, FALSE, 1),
       (11,'ORD0009', '2024-03-23 10:15:00', 'P001', 2, 4, TRUE, 1),
       (12,'ORD0010', '2024-03-23 12:30:00', 'P002', 1, 3, TRUE, 5),
       (13,'ORD0010', '2024-03-23 11:33:00', 'DRNK01', 1, 3, TRUE, 5),
       (14,'ORD0010', '2024-03-23 11:30:00', 'SIDE01', 1, 3, TRUE, 5);


CREATE TABLE IF NOT EXISTS staff (
  "staff_id" varchar(20) PRIMARY KEY,
  "first_name" varchar(50),
  "last_name" varchar(50),
  "position" varchar(100),
  "hourly_rate" decimal(5,2)
);
INSERT INTO staff (staff_id, first_name, last_name, position, hourly_rate)
VALUES ('STF001', 'Themba', 'Dlamini', 'Chef', 18.50),
       ('STF002', 'Nneka', 'Okafor', 'Waitress', 12.00),
       ('STF003', 'Musa', 'Kamara', 'Delivery Driver', 15.00),
       ('STF004', 'Zanele', 'Mbatha', 'Manager', 22.00),
       ('STF005', 'Kwesi', 'Arthur', 'Assistant Chef', 16.00);

CREATE TABLE IF NOT EXISTS shift (
  "shift_id" varchar(20) PRIMARY KEY,
  "day_of_week" varchar(10),
  "start_time" time,
  "end_time" time
);
INSERT INTO shift (shift_id, day_of_week, start_time, end_time)
VALUES ('SHFT01', 'Monday', '10:00:00', '18:00:00'),
       ('SHFT02', 'Tuesday', '11:00:00', '19:00:00'),
       ('SHFT03', 'Wednesday', '12:00:00', '20:00:00'),
       ('SHFT04', 'Thursday', '10:00:00', '18:00:00'),
       ('SHFT05', 'Friday', '10:00:00', '22:00:00'),
       ('SHFT06', 'Saturday', '11:00:00', '23:00:00'),
       ('SHFT07', 'Sunday', '12:00:00', '20:00:00');

CREATE TABLE IF NOT EXISTS rota (
  "row_id" int PRIMARY KEY,
  "rota_id" varchar(20),
  "date" timestamp,
  "shift_id" varchar(20),
  "staff_id" varchar(20)
);
INSERT INTO rota (row_id, rota_id, shift_id, staff_id)
VALUES
(1, 'ROT001', 'SHFT01', 'STF002'), -- Nneka Okafor (Waitress) on Monday
(2, 'ROT002', 'SHFT02', 'STF001'), -- Themba Dlamini (Chef) on Tuesday
(3, 'ROT003',  'SHFT03', 'STF005'), -- Kwesi Arthur (Assistant Chef) on Wednesday
(4, 'ROT004',  'SHFT04', 'STF004'), -- Zanele Mbatha (Manager) on Thursday
(5, 'ROT005', 'SHFT05', 'STF003'), -- Musa Kamara (Delivery Driver) on Friday
(6, 'ROT006',  'SHFT06', 'STF001'), -- Themba Dlamini (Chef) on Saturday
(7, 'ROT007',  'SHFT07', 'STF002'); -- Nneka Okafor (Waitress) on Sunday

ALTER TABLE "orders" ADD FOREIGN KEY ("cust_id") REFERENCES "customers" ("cust_id");

ALTER TABLE "orders" ADD FOREIGN KEY ("add_id") REFERENCES "address" ("add_id");

ALTER TABLE "orders" ADD FOREIGN KEY ("item_id") REFERENCES "item" ("item_id");

ALTER TABLE "recipe" ADD FOREIGN KEY ("ing_id") REFERENCES "ingredient" ("ing_id");

ALTER TABLE "recipe" ADD FOREIGN KEY ("recipe_id") REFERENCES "item" ("sku");

ALTER TABLE "inventory" ADD FOREIGN KEY ("item_id") REFERENCES "ingredient" ("ing_id");

ALTER TABLE "rota" ADD FOREIGN KEY ("shift_id") REFERENCES "shift" ("shift_id");

ALTER TABLE "rota" ADD FOREIGN KEY ("staff_id") REFERENCES "staff" ("staff_id");