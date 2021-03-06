USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_Scheduled_Section]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_Scheduled_Section]
AS
SELECT 0 [IsDeleted]
      ,a.Schoolforce__School__c [SchoolForce__Account__c]
      ,b.Course [SchoolForce__Course_Name__c]
      ,a.[SchoolForce__Course__c]
      ,0 [SchoolForce__Daily_Attendance__c]
      ,f.Id+'-'+a.SchoolForce__Period__c+'-'+e.Id [SchoolForce__External_Id__c]
      ,1 [SchoolForce__Needs_Publish__c]
	  ,0 [SchoolForce__No_Meeting__c]
      ,a.SchoolForce__Period__c [SchoolForce__Period_Key__c]
      ,0 [SchoolForce__Record_Attendance__c]
      ,f.Id+'-'+a.SchoolForce__Period__c+'-'+e.Id [SchoolForce__Reference_Id__c]
      ,a.Schoolforce__Reporting_Period__c [SchoolForce__Reporting_Period__c] 
      ,f.Id [SchoolForce__Section_ReportingPeriod__c]
      ,a.Id [SchoolForce__Section__c]
      ,a.Schoolforce__Reporting_Period__c+'-'+a.SchoolForce__Period__c+'-'+e.Id [SchoolForce__Staff_Key__c]
      ,e.Id [SchoolForce__Staff__c]
FROM 
dbo.vw_Sections_Math_ELA a INNER JOIN
dbo.vw_Courses b ON
	a.Schoolforce__Course__c = b.Id INNER JOIN
SDW_Stage.dbo.SchoolForce__Section__c c ON
	a.Id = c.Id INNER JOIN
dbo.SF_Staff d ON 
	REVERSE(SUBSTRING(REVERSE(a.Salesforce__External_ID__c),1,Convert(int,CHARINDEX('_',REVERSE(a.Salesforce__External_ID__c))-1))) = d.DistStaffID INNER JOIN
SDW_Stage.dbo.SchoolForce__Staff__c e ON
	d.SchoolForce__Individual__c = e.SchoolForce__Individual__c AND a.Schoolforce__School__c = e.SchoolForce__Organization__c INNER JOIN
SDW_Stage.dbo.SchoolForce__Section_ReportingPeriod__c f ON
	a.Schoolforce__Reporting_Period__c = f.SchoolForce__Time__c AND a.Id = f.SchoolForce__Section__c



	




GO
