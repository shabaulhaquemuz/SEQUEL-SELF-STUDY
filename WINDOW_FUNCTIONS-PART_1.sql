CREATE DATABASE window_functions;
USE window_functions;
CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);
INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51);

-- Calculate average marks from the given data
SELECT AVG(marks) FROM window_functions.marks;

-- now using window function
-- calculating average marks for whole data
SELECT AVG(marks) OVER() FROM window_functions.marks; 

-- full data visible(whole row data, not just single column)
SELECT *, AVG(marks) OVER() FROM window_functions.marks;

-- calculating average marks according to the branches of students
SELECT *, AVG(marks) OVER(PARTITION BY branch) FROM window_functions.marks;

-- CREATING DIFFERENT COLUMNS FOR DIFFERENT AGGREGATE FUNCTIONS
SELECT *,
AVG(marks) OVER(),
MIN(marks) OVER(),
MAX(marks) OVER(),
MIN(marks) OVER(PARTITION BY branch),
MAX(marks) OVER(PARTITION BY branch),
AVG(marks) OVER(PARTITION BY branch)
FROM window_functions.marks ORDER BY student_id; -- order by is used sometimes because the result gets 
                                                 -- shuffled but the shuffling has nothing to do with 
                                                 -- the use of window functions, it is done automatically
                                                 -- by database engine sometimes, not always and it has 
                                                 -- no relevance
                                                 
-- Question:Find all the students who have marks higher than the average marks of their respective branch

SELECT *, AVG(marks) OVER(PARTITION BY branch) AS average_by_branch
FROM marks WHERE marks.marks > average_by_branch;
-- Your logic is correct, but the SQL will not run ❌
-- because you cannot use a window function alias (average_by_branch) in the WHERE clause.
-- Why?
-- Because WHERE executes before window functions are calculated.

-- RIGHT WAY TO DO IT: 
SELECT * FROM(SELECT *, AVG(marks) OVER(PARTITION BY branch) AS average_by_branch
FROM marks) t WHERE t.marks > average_by_branch;
 WHERE marks.marks > average_by_branch;