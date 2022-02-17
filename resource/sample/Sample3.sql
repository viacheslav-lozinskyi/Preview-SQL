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
GO

