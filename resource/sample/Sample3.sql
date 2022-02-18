
DECLARE @TableVar table(
    [JobTitle] [nvarchar](50) NOT NULL,
  [BirthDate] [date] NOT NULL,
  [MaritalStatus] [nchar](1) NOT NULL,
  [Gender] [nchar](1) NOT NULL,
  [HireDate] [date] NOT NULL,
  [SalariedFlag] [dbo].[Flag] NOT NULL,
  [VacationHours] [smallint] NOT NULL,
  [SickLeaveHours] [smallint] NOT NULL
  )

-- Insert values into the table variable.
INSERT INTO @TableVar
    SELECT
   [JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SalariedFlag]
      ,[VacationHours]
      ,[SickLeaveHours]
    FROM [AdventureWorks2017].[HumanResources].[Employee]

-- View the table variable result set.
SELECT * FROM @TableVar;

--DROP PROCEDURE IF EXISTS net_filter_register;

--CREATE PROCEDURE net_filter_register(
--    IN _type ENUM("IP", "URL"),
--    IN _value VARCHAR(256))
--BEGIN
--    SET _type = UPPER(_type);
--    SET _value = LOWER(_value);
--    SET _value = TRIM(_value);

--    IF (NOT EXISTS(SELECT _value FROM net_filters WHERE (type = _type) AND (value = _value))) THEN
--        INSERT INTO net_filters(type, value)
--        VALUE (_type, _value);
--    END IF;
--END;

GO