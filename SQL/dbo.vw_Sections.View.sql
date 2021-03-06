USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_Sections]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Sections]
AS
SELECT  [Name]
	  ,[Salesforce__External_ID__c]
      ,[SchoolForce__Active__c]
      ,[SchoolForce__All_Grades__c]
      ,[Schoolforce__Course__c]
      ,c.Course AS [SchoolForce__Period__c]
      ,[SchoolForce__Daily_Attendance__c]
      ,[SchoolForce__Is_Section__c]
      ,[Schoolforce__Reporting_Period__c]
      ,[Schoolforce__School__c]
      ,[Schoolforce__Time__c]
      ,[SchoolForce__Number_of_Reporting_Periods__c]
      ,a.RecordTypeID AS [SchoolForce__Record_Type__c]
      ,a.[SchoolForce__Color__c]
      ,a.[SchoolForce__Text_Color__c]
  FROM [Data_Services].[dbo].[vw_Sections_Math_ELA]  a INNER JOIN 
  dbo.School_Lookup  b ON 
	a.Schoolforce__School__c = b.Account_ID INNER JOIN
  dbo.vw_Courses c ON 
	a.Schoolforce__Course__c = c.Id 
GO
