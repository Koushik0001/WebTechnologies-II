CREATE TABLE states (
    stateID VARCHAR(10) NOT NULL,
    stateName VARCHAR(50) NOT NULL,
    PRIMARY KEY (stateID)
);
CREATE TABLE districts (
    districtID VARCHAR(10) NOT NULL,
    districtName VARCHAR(50) NOT NULL,
    stateID VARCHAR(10) NOT NULL,
    districtInfo VARCHAR(150),
    PRIMARY KEY (districtID),
    FOREIGN KEY (stateID) REFERENCES states(stateID)
);