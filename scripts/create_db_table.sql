-- Create database
CREATE DATABASE coffee;

-- // Create core tables // --
-- Product table group
CREATE TABLE IF NOT EXISTS product_type (
    product_type_id int NOT NULL,
    product_type_description varchar(30),
    PRIMARY KEY (product_type_id)
);

CREATE TABLE IF NOT EXISTS product_category (
    product_category_id int NOT NULL,
    product_category_description varchar(30),
    PRIMARY KEY (product_category_id)
);

CREATE TABLE IF NOT EXISTS product (
    product_id int NOT NULL,
    product_type_id int,
    product_category_id int,
    product_name varchar(50),
    product_description varchar(100),
    price numeric,
    PRIMARY KEY (product_id),
    CONSTRAINT fk_product_type FOREIGN KEY (product_type_id) REFERENCES product_type(product_type_id),
    CONSTRAINT fk_product_category FOREIGN KEY (product_category_id) REFERENCES product_category(product_category_id)
);

 -- Customer table
CREATE TABLE IF NOT EXISTS customer (
    customer_id int NOT NULL,
    first_name varchar(50) NOT NULL,
    middle_name varchar(50),
    last_name varchar(50) NOT NULL,
    email varchar(100) NOT NULL,
    customer_since date,
    card_number int,
    date_of_birth date,
    gender char(1),
    PRIMARY KEY (customer_id),
    CONSTRAINT gender_check CHECK(gender = 'O' or gender = 'F' or gender = 'M')
);

-- Staff table group
CREATE TABLE IF NOT EXISTS staff_location (
    location_id int NOT NULL,
    location_description varchar(25),
    PRIMARY KEY (location_id)
);

CREATE TABLE IF NOT EXISTS staff_position (
    position_id int NOT NULL,
    position_description varchar(25),
    PRIMARY KEY (position_id)
);

CREATE TABLE IF NOT EXISTS staff (
    staff_id int NOT NULL,
    first_name varchar(50),
    middle_name varchar(50),
    last_name varchar(50),
    start_date date NOT NULL,
    location_id int NOT NULL,
    position_id int NOT NULL,
    PRIMARY KEY (staff_id),
    CONSTRAINT fk_staff_location FOREIGN KEY (location_id) REFERENCES staff_location(location_id),
    CONSTRAINT fk_staff_position FOREIGN KEY (position_id) REFERENCES staff_position(position_id)
);

-- Sales outlet group
CREATE TABLE IF NOT EXISTS outlet_type (
    outlet_type_id int NOT NULL,
    outlet_type_description varchar(20) NOT NULL,
    PRIMARY KEY (outlet_type_id)
);

CREATE TABLE IF NOT EXISTS outlet (
    outlet_id int NOT NULL,
    outlet_type_id int NOT NULL,
    street_address varchar(30),
    city varchar(25),
    postal_code int,
    phone_number int,
    manager_staff_id int NOT NULL,
    PRIMARY KEY (outlet_id),
    CONSTRAINT fk_outlet_type FOREIGN KEY (outlet_type_id) REFERENCES outlet_type(outlet_type_id),
    CONSTRAINT fk_manager FOREIGN KEY (manager_staff_id) REFERENCES staff(staff_id)
);

-- Sales transaction table group
CREATE TABLE IF NOT EXISTS sales_transaction (
    transaction_id int NOT NULL,
    outlet_id int,
    staff_id int,
    customer_id int,
    PRIMARY KEY (transaction_id),
    CONSTRAINT fk_outlet FOREIGN KEY (outlet_id) REFERENCES outlet(outlet_id),
    CONSTRAINT fk_staff FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE IF NOT EXISTS sales_detail (
    sales_detail_id int NOT NULL,
    transaction_id int NOT NULL,
    transaction_date date,
    transaction_time timestamp,
    product_id int NOT NULL,
    quantity int,
    PRIMARY KEY (sales_detail_id),
    CONSTRAINT fk_transaction FOREIGN KEY (transaction_id) REFERENCES sales_transaction(transaction_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES product(product_id)
);