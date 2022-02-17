CREATE TABLE [HumanResources].[EmployeeData](
  [FirstName] [dbo].[Name] NOT NULL,
  [MiddleName] [dbo].[Name] NULL,
  [LastName] [dbo].[Name] NOT NULL,
  [Suffix] [nvarchar](10) NULL,
  [JobTitle] [nvarchar](50) NOT NULL,
  [PhoneNumber] [dbo].[Phone] NULL,
  [PhoneNumberType] [dbo].[Name] NULL,
  [EmailAddress] [nvarchar](50) NULL,
  [City] [nvarchar](30) NOT NULL,
  [StateProvinceName] [dbo].[Name] NOT NULL,
  [PostalCode] [nvarchar](15) NOT NULL,
  [CountryRegionName] [dbo].[Name] NOT NULL
) ON [PRIMARY]
GO

INSERT INTO HumanResources.EmployeeData
SELECT p.[FirstName],
       p.[MiddleName],
       p.[LastName],
       p.[Suffix],
       e.[JobTitle],
       pp.[PhoneNumber],
       pnt.[Name] AS [PhoneNumberType],
       ea.[EmailAddress],
       a.[City],
       sp.[Name] AS [StateProvinceName],
       a.[PostalCode],
       cr.[Name] AS [CountryRegionName]
FROM [HumanResources].[Employee] e
     INNER JOIN [Person].[Person] p ON p.[BusinessEntityID] = e.[BusinessEntityID]
     INNER JOIN [Person].[BusinessEntityAddress] bea ON bea.[BusinessEntityID] = e.[BusinessEntityID]
     INNER JOIN [Person].[Address] a ON a.[AddressID] = bea.[AddressID]
     INNER JOIN [Person].[StateProvince] sp ON sp.[StateProvinceID] = a.[StateProvinceID]
     INNER JOIN [Person].[CountryRegion] cr ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
     LEFT OUTER JOIN [Person].[PersonPhone] pp ON pp.BusinessEntityID = p.[BusinessEntityID]
     LEFT OUTER JOIN [Person].[PhoneNumberType] pnt ON pp.[PhoneNumberTypeID] = pnt.[PhoneNumberTypeID]
     LEFT OUTER JOIN [Person].[EmailAddress] ea ON p.[BusinessEntityID] = ea.[BusinessEntityID];
GO

