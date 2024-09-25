CREATE TABLE business_constraints 
(  
    process_key INT GENERATED BY DEFAULT AS IDENTITY,  
    process_code INT NOT NULL,  
    business_type VARCHAR2(50) NOT NULL,  
    description VARCHAR2(50) NOT NULL,  
    applicable_from TIMESTAMP,  
    applicable_to TIMESTAMP, 
    create_timestamp TIMESTAMP,
    update_timestamp TIMESTAMP, 
    active_record_ind INT,  
    PRIMARY KEY(process_key) 
);

CREATE TABLE discounts 
(  
    discount_key INT GENERATED BY DEFAULT AS IDENTITY,  
    discount_code INT NOT NULL, 
    discount_value INT NOT NULL,   
    description VARCHAR2(50) NOT NULL,  
    applicable_from TIMESTAMP,  
    applicable_to TIMESTAMP, 
    create_timestamp TIMESTAMP,
    update_timestamp TIMESTAMP, 
    active_record_ind INT,  
    PRIMARY KEY(discount_key) 
);


CREATE TABLE customers_details  
(  
    customer_key INT GENERATED BY DEFAULT AS IDENTITY,  
    customer_id VARCHAR2(50) NOT NULL,  
    first_name VARCHAR2(50) NOT NULL,  
    last_name VARCHAR2(50) NOT NULL,  
    phone INT,  
    email VARCHAR2(50),  
    address_line1 VARCHAR2(50),  
    address_line2 VARCHAR2(50),  
    city VARCHAR2(50),  
    state VARCHAR2(50),  
    zipcode INT,  
    country VARCHAR(50),  
    age INT,  
    process_key INT,
    PRIMARY KEY(customer_key),  
    FOREIGN KEY (process_key) REFERENCES business_constraints (process_key)
);

CREATE TABLE payment_details(
    payment_key INT GENERATED BY DEFAULT AS IDENTITY,
    payment_id INT,
    card_number VARCHAR2(50),
    payment_type VARCHAR2(50),
    payment_merchant VARCHAR2(50),
    customer_key INT,
    PRIMARY KEY (payment_key),
    FOREIGN KEY (customer_key) REFERENCES customers_details (customer_key)
);

CREATE TABLE offices 
(  
    office_key INT GENERATED BY DEFAULT AS IDENTITY,  
    office_code VARCHAR2(50) NOT NULL,    
    city VARCHAR2(50),  
    phone INT,  
    address_line1 VARCHAR2(50),  
    address_line2 VARCHAR2(50),  
    create_date TIMESTAMP,
    update_date TIMESTAMP,
    active_record_ind INT,
    PRIMARY KEY (office_key)
) ;



CREATE TABLE employee_details  
(  
    employee_key INT GENERATED BY DEFAULT AS IDENTITY,  
    employee_id VARCHAR2(50) NOT NULL,  
    team VARCHAR2(50) NOT NULL,  
    employee_role VARCHAR2(50) NOT NULL,  
    first_name VARCHAR(50),  
    last_name VARCHAR2(50), 
    phone INT,
    email VARCHAR2(50), 
    address_line1 VARCHAR2(50),  
    address_line2 VARCHAR2(50),  
    city VARCHAR2(50),  
    state VARCHAR2(50),  
    zipcode INT,  
    country VARCHAR(50),  
    age INT,
    office_key INT,
    PRIMARY KEY (employee_key),
    FOREIGN KEY (office_key) REFERENCES offices (office_key)
) ;

CREATE TABLE vendor_details 
(  
    vendor_key INT GENERATED BY DEFAULT AS IDENTITY,  
    vendor_id VARCHAR2(50) NOT NULL,  
    vendor_category VARCHAR2(50) NOT NULL,  
    vendor_name VARCHAR2(50) NOT NULL,  
    share_percentage INT,  
    poc_name VARCHAR2(50), 
    poc_number INT, 
    bakcup_poc_number INT,  
    contract_start TIMESTAMP,  
    contract_end TIMESTAMP,
    process_key INT,
    active_record_ind INT,  
    PRIMARY KEY(vendor_key) ,
    FOREIGN KEY (process_key) REFERENCES business_constraints (process_key)
) ;

CREATE TABLE venue_details
(  
    venue_key INT GENERATED BY DEFAULT AS IDENTITY,  
    venue_id INT NOT NULL,  
    name VARCHAR2(50) NOT NULL,  
    address VARCHAR2(100) NOT NULL,  
    city VARCHAR2(50),  
    zipcode INT, 
    state VARCHAR2(50), 
    vendor_key INT,
    active_record_ind INT,  
    PRIMARY KEY(venue_key),
    FOREIGN KEY (vendor_key) REFERENCES vendor_details (vendor_key)
);

CREATE TABLE event_details  
(  
    event_key INT GENERATED BY DEFAULT AS IDENTITY,  
    event_id INT NOT NULL,  
    venue_key INT NOT NULL,  
    time_start TIMESTAMP NOT NULL,  
    time_end TIMESTAMP,
    booking_start TIMESTAMP,  
    booking_end TIMESTAMP,  
    event_name VARCHAR2(100),
    max_occupancy INT,  
    current_occupancy INT,  
    priority VARCHAR2(50),  
    description VARCHAR2(50), 
    ticket_price INT,
    process_key INT,
    event_type VARCHAR2(50),
    active_record_ind INT,  
    PRIMARY KEY(event_key),
    FOREIGN KEY (venue_key) REFERENCES venue_details (venue_key)
) ;

CREATE TABLE booking 
(  
    booking_key INT GENERATED BY DEFAULT AS IDENTITY,  
    booking_id VARCHAR2(50) NOT NULL,  
    booking_datetime TIMESTAMP NOT NULL,  
    boking_status VARCHAR2(50) NOT NULL,  
    comments VARCHAR2(50),  
    customer_key INT, 
    transaction_id INT,  
    payment_key INT,  
    payment_status VARCHAR2(50),  
    PRIMARY KEY(booking_key) ,
    FOREIGN KEY (payment_key) REFERENCES payment_details (payment_key),
    FOREIGN KEY (customer_key) REFERENCES customers_details (customer_key)
) ;


CREATE TABLE booking_details 
(  
    booking_key INT NOT NULL,  
    event_key INT NOT NULL,  
    no_of_tickets_booked INT NOT NULL,  
    booking_value INT NOT NULL,  
    payment_value FLOAT,   
    discount_key INT,  
    PRIMARY KEY(booking_key, event_key),
    FOREIGN KEY (event_key) REFERENCES event_details (event_key),
    FOREIGN KEY (discount_key) REFERENCES discounts (discount_key)
) ;