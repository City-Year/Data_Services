USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_17_RP_ADA]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_17_RP_ADA] @District varchar(255) = 'Standard'
AS
BEGIN

IF @district = 'SJ'
	BEGIN
	
DELETE FROM Data_Services.dbo.SF_Assessment_RP_ADA WHERE [SchoolForce__External_Id__c] LIKE 'sj%'

INSERT INTO Data_Services.dbo.SF_Assessment_RP_ADA ([Student_ID]
      ,[SchoolForce__Type__c]
      ,[SchoolForce__Assessment_Name__c]
      ,[Date_Administered__c]
      ,[Average_Daily_Attendance__c]
      ,[Time_Period__c]
      ,[SchoolForce__External_Id__c])	

SELECT e.SF_ID Student_ID
	   , (select id from sdw_Stage_prod_17.dbo.Picklist_Value__c where name =  'Reporting Period ADA Tracker - ATTENDANCE') AS SchoolForce__Type__c
		,'Reporting Period ADA Tracker - ATTENDANCE' AS SchoolForce__Assessment_Name__c
		, case  a.[Marking_Period] when 'Q1'
		THEN Cast('2016-10-27' AS DATE) 
		when 'Q2'
		THEN Cast('1/23/17' AS DATE)
		when 'Q3'
		THEN Cast('4/11/17' AS DATE)
		when 'Q4'
		THEN Cast('6/15/17' AS DATE)
		when 'T1'
		THEN Cast('11/18/16' AS DATE)
		when 'T2'
		THEN Cast('3/10/17' AS DATE)
		when 'T3'
		THEN Cast('6/15/17' AS DATE)
		when 'S1'
		THEN Cast('1/23/17' AS DATE)
		when 'S2'
		THEN Cast('6/15/17' AS DATE)ELSE NULL END AS  Date_Administered__c
		,((cast(a.ADA_Value as dec(5,2)))/100) Average_Daily_Attendance__c
		,a.[Marking_Period] Time_Period__c
		,a.District + '_' + CAST(CAST(e.School_ID AS INTEGER) AS VARCHAR(4)) + '_' + e.Student_ID + '_' + a.Marking_Period [SchoolForce__External_Id__c]

FROM Data_Services.dbo.Assessment_ADA (NOLOCK) a 
INNER JOIN Data_Services.dbo.Master_Student (NOLOCK) e ON a.Student_ID = e.Student_ID and a.District = 'sj'
INNER JOIN Data_Services.dbo.School_Lookup_16_17 (nolock) h ON e.SchoolForce__Setup__C = h.Setup_14_15 and e.School_ID = h.Source_School_ID
--INNER JOIN sdw_stage_prod_17.dbo.Setup__c (nolock) i ON h.Account_ID = i.[School__c] 
--INNER JOIN sdw_stage_prod_17.dbo.Time_Element__c (nolock) j ON 
--(i.[Term__c] = j.[Parent_Time_Element__c] AND a.Marking_Period = REPLACE(j.Name__c,'Quarter ','Q')) or
-- (i.[Term__c] = j.[Parent_Time_Element__c] AND a.Marking_Period = REPLACE(j.Name__c,'Trimester ','T')) or
-- (i.[Term__c] = j.[Parent_Time_Element__c] AND a.Marking_Period = REPLACE(j.Name__c,'Semester ','S'))
Where a.district = 'sj' 

update Data_Services.dbo.SF_Assessment_RP_ADA set Date_Administered__c = null where [SchoolForce__External_Id__c] like 'SJ%' and Date_Administered__c > GETDATE()

END

IF @district = 'OCPS'
	BEGIN
	
DELETE FROM Data_Services.dbo.SF_Assessment_RP_ADA WHERE [SchoolForce__External_Id__c] LIKE 'ocps%'


select a.std_nbr,a.marking_period,a.total_no_of_days,b.no_of_days_present ,cast((no_of_days_present/total_no_of_days) as dec(5,2)) ADA_VALUE ,a.school_id,'OCPS' District  
 into #Assessment_ADA from
  (select std_nbr, marking_period,count(attendance_value) as total_no_of_days,site_id as school_id
   from [Data_Services].[dbo].[Assessment_ORL_ADA] 
  group by std_nbr, marking_period,site_id ) a
  inner join
  (select std_nbr, marking_period,sum(cast(attendance_value as float))  as no_of_days_present ,site_id as school_id
  from [Data_Services].[dbo].[Assessment_ORL_ADA] where [Data_Services].[dbo].[Assessment_ORL_ADA].[ATTENDANCE_STATUS] IN ( 'CALCULATED PRESENT','TARDY TO CLASS UNEXCUSED')
  group by std_nbr, marking_period ,site_id ) b
  on (a.std_nbr = b.std_nbr and a.marking_period = b.marking_period and a.school_id = b.school_id)
order by a.std_nbr , a.marking_period 


INSERT INTO Data_Services.dbo.SF_Assessment_RP_ADA ([Student_ID]
      ,[SchoolForce__Type__c]
      ,[SchoolForce__Assessment_Name__c]
      ,[Date_Administered__c]
      ,[Average_Daily_Attendance__c]
      ,[Time_Period__c]
      ,[SchoolForce__External_Id__c])	

SELECT e.SF_ID Student_ID
	   , (select id from sdw_Stage_prod.dbo.Picklist_Value__c where name =  'Reporting Period ADA Tracker - ATTENDANCE') AS SchoolForce__Type__c
		,'Reporting Period ADA Tracker - ATTENDANCE' AS SchoolForce__Assessment_Name__c
		, Cast([End_Date__c] AS DATE) Date_Administered__c
		,a.ada_value Average_Daily_Attendance__c
		,'Q' + a.[Marking_Period] Time_Period__c
		,a.district + '_' + CAST(CAST(e.School_ID AS INTEGER) AS VARCHAR(4)) + '_' + e.Student_ID + '_' + a.Marking_Period [SchoolForce__External_Id__c]
		
FROM #Assessment_ADA (NOLOCK) a 
inner JOIN Data_Services.dbo.Master_Student (NOLOCK) e ON a.std_nbr = e.Student_ID and a.District = e.district and a.school_id = e.school_id 
INNER JOIN Data_Services.dbo.School_Lookup (nolock) h ON e.SchoolForce__Setup__C = h.Setup_14_15 and e.School_ID = h.Source_School_ID
INNER JOIN sdw_stage_prod.dbo.Setup__c (nolock) i ON h.Account_ID = i.[School__c] 
INNER JOIN sdw_stage_prod.dbo.Time_Element__c (nolock) j ON 
(i.[Term__c] = j.[Parent_Time_Element__c] AND 'Q' + a.Marking_Period = REPLACE(j.Name__c,'Quarter ','Q')) 
--or (i.[Term__c] = j.[Parent_Time_Element__c] AND a.Marking_Period = REPLACE(j.Name__c,'Trimester ','T')) or
 --(i.[Term__c] = j.[Parent_Time_Element__c] AND a.Marking_Period = REPLACE(j.Name__c,'Semester ','S'))
Where a.district = 'OCPS'
 
END
if @District = 'KCPS'
BEGIN

TRUNCATE TABLE Data_Services.dbo.SF_Assessment_RP_ADA
	
--SELECT e.SF_ID Student_ID
--		,(SELECT [Value]
--	      FROM [Data_Services_DEV].[dbo].[Settings]
--	      WHERE [Name] = 'TBAT.Type') AS SchoolForce__Type__c
--		,'Time Based Attendance Tracker' AS SchoolForce__Assessment_Name__c
--		,CAST(RTRIM(CAST(d.Month AS VARCHAR(5))) + '/1/' + CAST(d.Year AS VARCHAR(4)) AS DATE) [Date]
--		,SUM(CASE WHEN A.Attendance_Status in ('ABSENT EXCUSED','ABSENT UNEXCUSED', 'Excused Absence', 'Unexcused Absence') THEN 1 ELSE 0 END) Number_Of_Absences
--		,SUM(CASE WHEN A.Attendance_Status in ('ABSENT EXCUSED', 'Excused Absence') THEN 1 ELSE 0 END) Excused_Absences
--		,SUM(CASE WHEN A.Attendance_Status in ('TARDY TO CLASS UNEXCUSED', 'Tardy') THEN 1 ELSE 0 END) Number_of_Tardies
--		,SUM(CASE WHEN A.Attendance_Status in ('ABSENT UNEXCUSED', 'Unexcused Absence') THEN 1 ELSE 0 END) Number_Of_Unexcused_Absences
--		,5 AS Days_Enrolled__c
--		,e.District + '_' + cast(cast(e.School_ID AS INTEGER) as VARCHAR(4)) + '_' + e.Student_ID + '_' + CAST(d.YearMonth_Number AS VARCHAR(6)) [SchoolForce__External_Id__c]
	
--INTO #TBAT
	
--FROM Data_Services_DEV.dbo.[Attendance] (NOLOCK) A INNER JOIN 
--	SDW_Prod.dbo.DimDate(nolock) D ON 
--		CAST(A.Date AS DATE) = D.Date INNER JOIN 
--	Data_Services_DEV.dbo.Master_Student (NOLOCK) e ON 
--		a.Student_ID = e.Student_ID
--GROUP BY e.SF_ID, CAST(RTRIM(CAST(d.Month AS VARCHAR(5))) + '/1/' + CAST(d.Year AS VARCHAR(4)) AS DATE), A.Student_ID, e.District + '_' + CAST(CAST(e.School_ID AS INTEGER) AS VARCHAR(4)) + '_' + e.Student_ID+ '_' + CAST(d.YearMonth_Number AS VARCHAR(6))


INSERT INTO Data_Services.dbo.SF_Assessment_RP_ADA ([Student_ID]
      ,[SchoolForce__Type__c]
      ,[SchoolForce__Assessment_Name__c]
      ,[Date_Administered__c]
      ,[Average_Daily_Attendance__c]
      ,[Time_Period__c]
      ,[SchoolForce__External_Id__c])

SELECT e.SF_ID Student_ID
	   ,(SELECT [Value]
	    FROM [Data_Services].[dbo].[Settings]
		WHERE [Name] = 'ADA.Type') AS SchoolForce__Type__c
		,'Reporting Period ADA Tracker - ATTENDANCE' AS SchoolForce__Assessment_Name__c
		--, case 
		--when a.marking_period = 'Q1' then '2015-10-09'
		--when a.marking_period = 'Q2' then '2015-12-18'
		--when a.marking_period = 'Q3' then '2016-03-09'
		--when a.marking_period = 'Q4' then '2015-05-17'
		--when a.marking_period = 'S1' then '2015-12-18'
		--else '2015-05-17'
		--end 
		,End_Date__c Date_Administered__c
		,((cast(a.ADA_Value as dec(5,2)))/100) Average_Daily_Attendance__c
		--,a.[ADA_Value] Average_Daily_Attendance__c
		,a.[Marking_Period] Time_Period__c
		,a.District + '_' + CAST(CAST(e.School_ID AS INTEGER) AS VARCHAR(4)) + '_' + e.Student_ID + '_' + a.Marking_Period [SchoolForce__External_Id__c]

FROM Data_Services.dbo.Assessment_ADA (NOLOCK) a 
INNER JOIN Data_Services.dbo.Master_Student (NOLOCK) e ON a.Student_ID = e.Student_ID
INNER JOIN Data_Services.dbo.School_Lookup (nolock) h ON e.SchoolForce__Setup__C = h.Setup_14_15 
INNER JOIN SDW_Stage_Prod.dbo.Setup__c (nolock) i ON h.Account_ID = i.[School__c] 
INNER JOIN SDW_Stage_Prod.dbo.Time_Element__c (nolock) j ON i.[Term__c] = j.[Parent_Time_Element__c] 
--	SDW_Prod.dbo.DimDate(nolock) D ON 
--		CAST(A.Date AS DATE) = D.Date INNER JOIN 
--	Data_Services_DEV.dbo.Master_Student (NOLOCK) e ON 
--		a.Student_ID = e.Student_ID
--GROUP BY e.SF_ID, CAST(RTRIM(CAST(d.Month AS VARCHAR(5))) + '/1/' + CAST(d.Year AS VARCHAR(4)) AS DATE), A.Student_ID, e.District + '_' + CAST(CAST(e.School_ID AS INTEGER) AS VARCHAR(4)) + '_' + e.Student_ID+ '_' + CAST(d.YearMonth_Number AS VARCHAR(6))
Where a.district = 'kcps' and (a.Marking_Period != 'S1' and a.Marking_Period != 'S2')

END

END







GO
