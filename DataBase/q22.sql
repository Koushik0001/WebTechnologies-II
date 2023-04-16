CREATE TABLE accounts(
    username VARCHAR(25) PRIMARY KEY,
    passwd VARCHAR(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    email  VARCHAR(50) NOT NULL,
    phone VARCHAR(12) NOT NULL
);