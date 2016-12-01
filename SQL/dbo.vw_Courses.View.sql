USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_Courses]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_Courses]
AS
SELECT [Id]
      ,CASE WHEN [Name] = 'ELA/Literacy' THEN 'ELA' ELSE [Name] END AS Course 
FROM [SDW_Stage].[dbo].[SchoolForce__Course__c]


GO
