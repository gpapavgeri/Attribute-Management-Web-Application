use dbo;

DELIMITER //
CREATE PROCEDURE ADD_ATTRIBUTE_TO_ALL_EMPLOYEES (IN attributeName VARCHAR(50), IN attributeValue VARCHAR(50))
BEGIN
DECLARE FINISHED BOOLEAN DEFAULT 0; -- ΔΙΝΟΥΜΕ DEFAULT ΤΙΜΗ 0 ΔΗΛΑΔΗ FALSE
	DECLARE EMP_ID CHAR(38);
    DECLARE EMP_Name VARCHAR(100);
    DECLARE EMP_DateOfHire DATETIME;
    DECLARE EMP_Supervisor CHAR(38);
    DECLARE EMP_CURSOR CURSOR FOR 
    SELECT * FROM employee;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET FINISHED = 1; -- TO 1 EINAI TRUE OTAN ΔΕΝ ΕΧΕΙ ΑΛΛΗ ΤΙΜΗ
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
			SET EMPATTR_AttributeID = (SELECT ATTR_ID FROM Attribute
					WHERE ATTR_Name = attributeName AND ATTR_Value = attributeValue)
			WHERE EMPATTR_EmployeeID = EMP_ID AND
                            EMPATTR_AttributeID IN (
								SELECT ATTR_ID 
								FROM Attribute 
								WHERE ATTR_Name = attributeName);
            
        ELSE
			INSERT INTO employeeattribute VALUES (
				EMP_ID, 
				(SELECT ATTR_ID FROM Attribute
				WHERE ATTR_Name = attributeName AND ATTR_Value = attributeValue));
		
        END IF;
        
        END WHILE;
    CLOSE EMP_CURSOR;
    COMMIT;

END //
DELIMITER ;

CALL ADD_ATTRIBUTE_TO_ALL_EMPLOYEES('Weight', 'Thin');
SELECT * FROM EmployeeAttribute
ORDER BY EMPATTR_EmployeeID;