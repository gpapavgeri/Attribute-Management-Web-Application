use dbo;

DELIMITER //
CREATE PROCEDURE ADD_ATTRIBUTE_TO_SUPERVISORS (IN attributeName VARCHAR(50), IN attributeValue VARCHAR(50))
BEGIN
DECLARE FINISHED BOOLEAN DEFAULT 0; 
	DECLARE EMP_ID CHAR(38);
    DECLARE EMP_Name VARCHAR(100);
    DECLARE EMP_DateOfHire DATETIME;
    DECLARE EMP_Supervisor CHAR(38);
    DECLARE EMP_CURSOR CURSOR FOR 
    SELECT * FROM employee;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET FINISHED = 1; 
    OPEN EMP_CURSOR;
    START TRANSACTION;
    WHILE NOT FINISHED DO
		FETCH EMP_CURSOR INTO EMP_ID, EMP_Name, EMP_DateOfHire, EMP_Supervisor;
        
        IF (SELECT EXISTS (SELECT * FROM EmployeeAttribute 
						   WHERE (EMPATTR_EmployeeID IN (
									SELECT EMP_Supervisor IS NOT NULL
									FROM Employee) AND
								 EMPATTR_AttributeID IN (
									SELECT ATTR_ID 
									FROM Attribute 
									WHERE ATTR_Name = attributeName))
							)) THEN
			UPDATE EmployeeAttribute
			SET EMPATTR_AttributeID = (
					SELECT ATTR_ID FROM Attribute
					WHERE (ATTR_Name = attributeName AND ATTR_Value = attributeValue)
                    LIMIT 1)
			WHERE (EMPATTR_EmployeeID IN (
						SELECT EMP_Supervisor IS NOT NULL
						FROM Employee) AND
				   EMPATTR_AttributeID IN (
						SELECT ATTR_ID 
						FROM Attribute 
						WHERE ATTR_Name = attributeName));
            
        ELSEIF (SELECT EXISTS (SELECT EMP_ID FROM Employee 
								WHERE (EMP_ID IN (
									SELECT EMP_Supervisor IS NOT NULL
									FROM Employee))
								)) THEN
			INSERT INTO employeeattribute VALUES (
					EMP_ID, 
					(SELECT ATTR_ID FROM Attribute
					WHERE (ATTR_Name = attributeName AND ATTR_Value = attributeValue)
                    LIMIT 1));
        END IF;
        
        END WHILE;
    CLOSE EMP_CURSOR;
	COMMIT;
    
END //
DELIMITER ;

CALL ADD_ATTRIBUTE_TO_SUPERVISORS('Height', 'Short');
SELECT * FROM EmployeeAttribute
ORDER BY EMPATTR_EmployeeID;

