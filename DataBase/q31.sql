CREATE TABLE marks (
    marksID INT NOT NULL AUTO_INCREMENT,
    roll INT(4) NOT NULL,
    semester ENUM('sem_1','sem_2') NOT NULL,
    subject VARCHAR(50) NOT NULL,
    marks INT NOT NULL,
    PRIMARY KEY (marksID),
    FOREIGN KEY (roll) REFERENCES stable(roll)
);
INSERT INTO marks (roll, semester, subject, marks) VALUES('106', 'sem_1', 'WT1', '95');
INSERT INTO marks (roll, semester, subject, marks) VALUES('136', 'sem_1', 'WT1', '85');
INSERT INTO marks (roll, semester, subject, marks) VALUES('146', 'sem_1', 'WT1', '82');
INSERT INTO marks (roll, semester, subject, marks) VALUES('149', 'sem_1', 'WT1', '75');
INSERT INTO marks (roll, semester, subject, marks) VALUES('154', 'sem_1', 'WT1', '91');
INSERT INTO marks (roll, semester, subject, marks) VALUES('165', 'sem_1', 'WT1', '93');
INSERT INTO marks (roll, semester, subject, marks) VALUES('609', 'sem_1', 'WT1', '70');

INSERT INTO marks (roll, semester, subject, marks) VALUES('106', 'sem_1', 'DBMS', '93');
INSERT INTO marks (roll, semester, subject, marks) VALUES('136', 'sem_1', 'DBMS', '91');
INSERT INTO marks (roll, semester, subject, marks) VALUES('146', 'sem_1', 'DBMS', '90');
INSERT INTO marks (roll, semester, subject, marks) VALUES('149', 'sem_1', 'DBMS', '84');
INSERT INTO marks (roll, semester, subject, marks) VALUES('154', 'sem_1', 'DBMS', '79');
INSERT INTO marks (roll, semester, subject, marks) VALUES('165', 'sem_1', 'DBMS', '92');
INSERT INTO marks (roll, semester, subject, marks) VALUES('609', 'sem_1', 'DBMS', '76');

INSERT INTO marks (roll, semester, subject, marks) VALUES('106', 'sem_2', 'WT2', '94');
INSERT INTO marks (roll, semester, subject, marks) VALUES('136', 'sem_2', 'WT2', '81');
INSERT INTO marks (roll, semester, subject, marks) VALUES('146', 'sem_2', 'WT2', '95');
INSERT INTO marks (roll, semester, subject, marks) VALUES('149', 'sem_2', 'WT2', '90');
INSERT INTO marks (roll, semester, subject, marks) VALUES('154', 'sem_2', 'WT2', '87');
INSERT INTO marks (roll, semester, subject, marks) VALUES('165', 'sem_2', 'WT2', '90');
INSERT INTO marks (roll, semester, subject, marks) VALUES('609', 'sem_2', 'WT2', '89');

INSERT INTO marks (roll, semester, subject, marks) VALUES('106', 'sem_2', 'OOS', '90');
INSERT INTO marks (roll, semester, subject, marks) VALUES('136', 'sem_2', 'OOS', '77');
INSERT INTO marks (roll, semester, subject, marks) VALUES('146', 'sem_2', 'OOS', '88');
INSERT INTO marks (roll, semester, subject, marks) VALUES('149', 'sem_2', 'OOS', '92');
INSERT INTO marks (roll, semester, subject, marks) VALUES('154', 'sem_2', 'OOS', '87');
INSERT INTO marks (roll, semester, subject, marks) VALUES('165', 'sem_2', 'OOS', '80');
INSERT INTO marks (roll, semester, subject, marks) VALUES('609', 'sem_2', 'OOS', '90');