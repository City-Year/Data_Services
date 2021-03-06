USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_Sections_Math_ELA]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[vw_Sections_Math_ELA]
AS

SELECT DISTINCT Z.Id
			--External ID
			,Z.Salesforce__External_ID__c
			,Z.Name
			,Z.SchoolForce__Active__c 
			,Z.SchoolForce__All_Grades__c 
			,Z.Schoolforce__Course__c
			,Z.SchoolForce__Daily_Attendance__c
			,Z.SchoolForce__Is_Section__c
			,Z.Schoolforce__Reporting_Period__c
			,Z.Schoolforce__School__c
			,Z.Schoolforce__Time__c
			--Aggregate value
			,Y.SchoolForce__Number_of_Reporting_Periods__c
			--Period
			,Z.SchoolForce__Period__c
			--Record Type (Unpublished)
			,Z.RecordTypeID
			,Z.SchoolForce__Color__c
			,Z.SchoolForce__Text_Color__c
			
			 
FROM

(SELECT k.Id 
    ,Case WHEN Len(a.Class_Period_Name+' '+c.Teacher) > 80 THEN Left(a.Class_Period_Name+' '+c.Teacher,80) ELSE a.Class_Period_Name+' '+'_'+c.Teacher END AS Name
	,'1' SchoolForce__Active__c
	,d.School_Grades as SchoolForce__All_Grades__c
	,f.Id AS Schoolforce__Course__c
	,'0' SchoolForce__Daily_Attendance__c
	,'1' SchoolForce__Is_Section__c
	,e.SchoolForce__Reporting_Period__c
	,d.Account_ID AS SchoolForce__School__c
	,j.Id AS SchoolForce__Time__c
	,f.Course AS SchoolForce__Period__c
	,a.Class_Section_ID+'_'+Convert(varchar,d.Source_School_ID)+'_'+Convert(varchar,c.DistStaffID) AS Salesforce__External_ID__c
	,'012E0000000UD8jIAG' RecordTypeID
	,'#BEBEBE' [SchoolForce__Color__c]
	,'#2F4F4F' [SchoolForce__Text_Color__c]
--Setup field included to join/retrieve aggregate reporting period value
    ,d.Setup_14_15 as SchoolForce__Setup__c  
  FROM [Data_Services].[dbo].[vw_Cleaned_Class] a INNER JOIN 
  [Data_Services].[dbo].[Student] b ON 
	a.Student_ID = b.Student_ID INNER JOIN
  [Data_Services].[dbo].[vw_Teacher_List] c ON 
	a.Teacher_Name = c.Teacher INNER JOIN
  [Data_Services].[dbo].[School_Lookup] d ON 
	b.School_ID = d.Source_School_ID INNER JOIN
  [Data_Services].[dbo].[vw_LookUp_School_Reporting_Periods] e ON 
	d.Setup_14_15 = e.Schoolforce__setup__c INNER JOIN
  [Data_Services].[dbo].[vw_Courses] f ON 
	a.Section_Type = f.Course INNER JOIN
  [SDW_Stage].dbo.SchoolForce__Time_Element__c g ON
	e.Schoolforce__Reporting_Period__c = g.Id INNER JOIN
--Reporting Period  
  [SDW_Stage].dbo.SchoolForce__Time_Element__c h ON
	h.SchoolForce__Parent_Time_Element__c = g.Id INNER JOIN
--Term  
  [SDW_Stage].dbo.SchoolForce__Time_Element__c i ON
	g.SchoolForce__Parent_Time_Element__c = i.Id INNER JOIN
--School Year  
  [SDW_Stage].dbo.SchoolForce__Time_Element__c j ON
	i.SchoolForce__Parent_Time_Element__c = j.Id LEFT JOIN
--Get Section ID when available
  [SDW_Stage].[dbo].SchoolForce__Section__c k ON
	a.Class_Section_ID+'_'+Convert(varchar,d.Source_School_ID)+'_'+Convert(varchar,c.DistStaffID) = k.SchoolForce__External_Id__c
	

--Limit to first reporting period (per AS loading instructions)

WHERE e.Name in (SELECT TOP 1(Name) FROM [Data_Services].[dbo].[vw_LookUp_School_Reporting_Periods]))Z

--Attach aggregate value
INNER JOIN

(SELECT COUNT(Name) AS SchoolForce__Number_of_Reporting_Periods__c
	, Schoolforce__setup__c
FROM [Data_Services].[dbo].[vw_LookUp_School_Reporting_Periods]
GROUP BY SchoolForce__setup__c) Y ON
	Z.SchoolForce__setup__c = Y.SchoolForce__setup__c  











GO
