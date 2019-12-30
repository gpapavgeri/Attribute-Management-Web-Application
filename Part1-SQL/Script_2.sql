use dbo;

-- BEFORE THE EXECUTION OF THE STORED PROCEDURE
-- Show All the Supervisors
-- [Greg, Oleg] 
SELECT EMP_Name
FROM employee
WHERE EMP_ID IN (
SELECT DISTINCT EMP_Supervisor
FROM employee
WHERE EMP_Supervisor IS NOT NULL);

-- Show Supervisors who already have the attribute 'Height' but NOT with value 'Short' and need to be updated
-- [Greg]
SELECT e.EMP_Name, a.ATTR_Name, a.ATTR_Value
FROM employee e
INNER JOIN employeeattribute ea ON ea.EMPATTR_EmployeeID = e.EMP_ID
INNER JOIN attribute a ON ea.EMPATTR_AttributeID = a.ATTR_ID
WHERE a.ATTR_Name = 'Height' AND a.ATTR_Value != 'Short' AND e.EMP_ID IN (
	SELECT DISTINCT EMP_Supervisor
	FROM employee
	WHERE EMP_Supervisor IS NOT NULL)
ORDER BY e.EMP_Name;

-- Show Supervisors who already have the attribute 'Height' with value 'Short'
-- [Oleg]
SELECT e.EMP_Name, a.ATTR_Name, a.ATTR_Value
FROM employee e
INNER JOIN employeeattribute ea ON ea.EMPATTR_EmployeeID = e.EMP_ID
INNER JOIN attribute a ON ea.EMPATTR_AttributeID = a.ATTR_ID
WHERE a.ATTR_Name = 'Height' AND a.ATTR_Value = 'Short' AND e.EMP_ID IN (
	SELECT DISTINCT EMP_Supervisor
	FROM employee
	WHERE EMP_Supervisor IS NOT NULL)
ORDER BY e.EMP_Name;

DELIMITER //
CREATE PROCEDURE ADD_ATTRIBUTE_TO_SUPERVISORS (IN attributeName VARCHAR(50), IN attributeValue VARCHAR(50))
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
					WHERE (EMPATTR_EmployeeID IN (
								SELECT DISTINCT EMP_Supervisor
								FROM employee
								WHERE EMP_Supervisor IS NOT NULL) AND
							EMPATTR_AttributeID IN (
								SELECT ATTR_ID 
								FROM Attribute 
								WHERE ATTR_Name = attributeName))
					)) THEN
			UPDATE EmployeeAttribute
			SET EMPATTR_AttributeID = (
					SELECT ATTR_ID 
                    FROM Attribute
					WHERE (ATTR_Name = attributeName AND ATTR_Value = attributeValue)
                    LIMIT 1)
			WHERE (EMPATTR_EmployeeID IN (
						SELECT DISTINCT EMP_Supervisor
						FROM employee
						WHERE EMP_Supervisor IS NOT NULL) AND
				   EMPATTR_AttributeID IN (
						SELECT ATTR_ID 
						FROM Attribute 
						WHERE ATTR_Name = attributeName));
            
        ELSEIF (SELECT EXISTS (SELECT EMP_ID FROM Employee 
						WHERE (EMP_ID IN (
							SELECT DISTINCT EMP_Supervisor
							FROM employee
							WHERE EMP_Supervisor IS NOT NULL))
						)) THEN
			INSERT INTO employeeattribute VALUES (
					EMP_ID, 
					(SELECT ATTR_ID 
                    FROM Attribute
					WHERE (ATTR_Name = attributeName AND ATTR_Value = attributeValue)
                    LIMIT 1));
        END IF;
        
        END WHILE;
    CLOSE EMP_CURSOR;
	COMMIT;
    
END //
DELIMITER ;

-- EXECUTE THE STORED PROCEDURE
CALL ADD_ATTRIBUTE_TO_SUPERVISORS('Height', 'Short');

-- AFTER THE EXECUTION OF THE STORED PROCEDURE
-- Show Supervisors who already have the attribute 'Height' but NOT with value 'Short' 
-- [None]
-- The supervisor [Greg] who had the attribute 'Height' with a different value now is updated
SELECT e.EMP_Name, a.ATTR_Name, a.ATTR_Value
FROM employee e
INNER JOIN employeeattribute ea ON ea.EMPATTR_EmployeeID = e.EMP_ID
INNER JOIN attribute a ON ea.EMPATTR_AttributeID = a.ATTR_ID
WHERE a.ATTR_Name = 'Height' AND a.ATTR_Value != 'Short' AND e.EMP_ID IN (
	SELECT DISTINCT EMP_Supervisor
	FROM employee
	WHERE EMP_Supervisor IS NOT NULL)
ORDER BY e.EMP_Name;

-- Show Supervisors who have the attribute 'Height' with value 'Short'
-- [Greg, Oleg / All the Supervisors]
SELECT e.EMP_Name, a.ATTR_Name, a.ATTR_Value
FROM employee e
INNER JOIN employeeattribute ea ON ea.EMPATTR_EmployeeID = e.EMP_ID
INNER JOIN attribute a ON ea.EMPATTR_AttributeID = a.ATTR_ID
WHERE a.ATTR_Name = 'Height' AND a.ATTR_Value = 'Short' AND e.EMP_ID IN (
	SELECT DISTINCT EMP_Supervisor
	FROM employee
	WHERE EMP_Supervisor IS NOT NULL)
ORDER BY e.EMP_Name;

