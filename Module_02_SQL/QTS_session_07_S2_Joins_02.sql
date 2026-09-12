USE breakfast_join_db;

CREATE TABLE departments (
    dept_id   INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;
 
INSERT INTO departments (dept_name) VALUES
    ('Engineering'),  -- dept_id 1
    ('Marketing'),    -- dept_id 2
    ('HR');           -- dept_id 3  (no employees)
 
CREATE TABLE employees (
    emp_id     INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(50) NOT NULL,
    dept_id    INT NULL,                 -- nullable, references departments
    manager_id INT NULL,                 -- nullable, references employees.emp_id
    CONSTRAINT FK_emp_dept
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT FK_emp_manager
        FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;
 
INSERT INTO employees (name, dept_id, manager_id) VALUES
    ('Asha',   1, NULL),  -- emp_id 1, Engineering, no manager (top level)
    ('Ravi',   1, 1),     -- emp_id 2, Engineering, manager = Asha
    ('Meera',  2, NULL),  -- emp_id 3, Marketing, no manager
    ('Sanjay', NULL, 3);  -- emp_id 4, NO department, manager = Meera
 
SELECT * FROM departments;
SELECT * FROM employees;

-- LEFT SEMI JOIN (EQUIVALENT)
SELECT e.emp_id, e.name
FROM employees e
WHERE EXISTS (
	SELECT 1 
	FROM departments d 
	WHERE d.dept_id = e.dept_id
);

-- LEFT ANTI JOIN (EQUIVALENT)
SELECT e.emp_id, e.name
FROM employees e
WHERE NOT EXISTS (
	SELECT 1 
	FROM departments d 
	WHERE d.dept_id = e.dept_id
);