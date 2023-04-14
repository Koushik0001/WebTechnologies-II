CREATE TABLE dtable (
    deptID VARCHAR(10) NOT NULL,
    deptName VARCHAR(50) NOT NULL,
    PRIMARY KEY (deptID)
);
CREATE TABLE stable (
    roll INT(4) NOT NULL,
    name VARCHAR(50) NOT NULL,
    deptID VARCHAR(10) NOT NULL,
    PRIMARY KEY (roll),
    FOREIGN KEY (deptID) REFERENCES dtable(deptID)
);

INSERT INTO dtable (deptID, deptName)
VALUES
	('IT', 'Information Technology'),
	('CSE', 'Computer Science Engineering'),
	('ME', 'Mechanical Engineering'),
    ('EE', 'Electrical Engineering');


INSERT INTO stable (roll, name, deptID)
VALUES
	('106', 'Harry Potter', 'IT'),
	('609', 'Hermione Granger', 'IT'),
	('136', 'Luna Lovegood', 'CSE'),
    ('149', 'Draco Malfoy', 'ME'),
    ('165', 'Ron Weasley', 'EE'),
    ('154', 'Newt Scamander','EE'),
    ('146', 'Fleur Delacour', 'CSE');
