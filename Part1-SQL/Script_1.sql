use dbo;

-- BEFORE THE EXECUTION OF THE STORED PROCEDURE
-- Show Employees who already have the attribute 'Weight' but NOT with value 'Thin' and need to be updated
-- [Greg, Phil]
SELECT e.EMP_Name, a.ATTR_Name, a.ATTR_Value
FROM employee e
INNER JOIN employeeattribute ea ON ea.EMPATTR_EmployeeID = e.EMP_ID
INNER JOIN attribute a ON ea.EMPATTR_AttributeID = a.ATTR_ID
WHERE a.ATTR_Name = 'Weight' AND a.ATTR_Value != 'Thin'
ORDER BY e.EMP_Name;

-- Show Employees who already have the attribute 'Weight' with value 'Thin'
-- [Oleg]
SELECT e.EMP_Name, a.ATTR_Name, a.ATTR_Value
FROM employee e
INNER JOIN employeeattribute ea ON ea.EMPATTR_EmployeeID = e.EMP_ID
INNER JOIN attribute a ON ea.EMPATTR_AttributeID = a.ATTR_ID
WHERE a.ATTR_Name = 'Weight' and a.ATTR_Value='Thin'
ORDER BY e.EMP_Name;

DELIMITER //
CREATE PROCEDURE ADD_ATTRIBUTE_TO_ALL_EMPLOYEES (IN attributeName VARCHAR(50), IN attributeValue VARCHAR(50))
BEGIN
DECLARE FINISHED BOOLEAN DEFAULT 0; 
	DECLARE EMP_ID BINARY(16);
    DECLARE EMP_Name VARCHAR(100);
    DECLARE EMP_DateOfHire TIMESTAMP;
    DECLARE EMP_Supervisor BINARY(16);
    DECLARE EMP_CURSOR CURSOR FOR 
    SELECT * FROM employee;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET FINISHED = 1;
    OPEN EMP_CURSOR;
    START TRANSACTION;
    WHILE NOT FINISHED DO
		FETCH EMP_CURSOR INTO EMP_ID, EMP_Name, EMP_DateOfHire, EMP_Supervisor;
        
        IF (SELECT EXISTS (SELECT * FROM EmployeeAttribute 
					WHERE EMPATTR_EmployeeID = EMP_ID AND
						  EMPATTR_AttributeID IN (
								SELECT ATTR_ID 
								FROM Attribute 
								WHERE ATTR_Name = attributeName))) THEN
			UPDATE EmployeeAttribute
			SET EMPATTR_AttributeID = (SELECT ATTR_ID 
								FROM Attribute
								WHERE ATTR_Name = attributeName AND ATTR_Value = attributeValue)
			WHERE EMPATTR_EmployeeID = EMP_ID AND
				  EMPATTR_AttributeID IN (
								SELECT ATTR_ID 
								FROM Attribute 
								WHERE ATTR_Name = attributeName);
        ELSE
			INSERT INTO employeeattribute VALUES (
				EMP_ID, 
				(SELECT ATTR_ID 
                FROM Attribute
				WHERE ATTR_Name = attributeName AND ATTR_Value = attributeValue));
        END IF;
        
        END WHILE;
    CLOSE EMP_CURSOR;
    COMMIT;

END //
DELIMITER ;

-- EXECUTE THE STORED PROCEDURE
CALL ADD_ATTRIBUTE_TO_ALL_EMPLOYEES('Weight', 'Thin');

-- AFTER THE EXECUTION OF THE STORED PROCEDURE
-- Show Employees who already have the attribute 'Weight' but NOT with value 'Thin' 
-- [None] 
-- Both of the Employees [Greg, Phil] who had the attribute 'Weight' with a different value now are updated
SELECT e.EMP_Name, a.ATTR_Name, a.ATTR_Value
FROM employee e
INNER JOIN employeeattribute ea ON ea.EMPATTR_EmployeeID = e.EMP_ID
INNER JOIN attribute a ON ea.EMPATTR_AttributeID = a.ATTR_ID
WHERE a.ATTR_Name = 'Weight' AND a.ATTR_Value != 'Thin'
ORDER BY e.EMP_Name;

-- Show Employees who have the attribute 'Weight' with value 'Thin'
-- [ALL THE EMPLOYEES]
SELECT e.EMP_Name, a.ATTR_Name, a.ATTR_Value
FROM employee e
INNER JOIN employeeattribute ea ON ea.EMPATTR_EmployeeID = e.EMP_ID
INNER JOIN attribute a ON ea.EMPATTR_AttributeID = a.ATTR_ID
WHERE a.ATTR_Name = 'Weight' and a.ATTR_Value='Thin'
ORDER BY e.EMP_Name;