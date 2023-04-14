SELECT name, roll ,deptName from 
    ( SELECT s.roll, s.name, d.deptName, s.deptID FROM 
        stable as s INNER JOIN dtable as d ON s.deptID=d.deptID) as t 
WHERE t.name like CONCAT( '%',?,'%')
