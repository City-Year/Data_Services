USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_16_TBBT]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_16_TBBT] @District varchar(255) = 'Standard'
AS
BEGIN
IF @DISTRICT = 'SJ'
BEGIN

delete from   Data_Services.dbo.SF_Assessment_TBBT where [SchoolForce__External_Id__c] like 'SJ%'

	SELECT e.SF_ID Student_ID
		,(	select id as value
	from [sdw_stage_prod_17].[dbo].[Picklist_Value__c] 
	where name = 'Cumulative Time Based Behavior Tracker - BEHAVIOR') AS SchoolForce__Type__c
		, 'Time Based Behavior Tracker' AS SchoolForce__Assessment_Name__c
		, CAST(a.[Incident_Date] AS DATE) [Date_Administered__c]
		, SUM(CASE WHEN RTRIM(A.Consequence) IN ('B-COUNSELING AND DIRECTION','BB-NO CONTACT CONTRACT','C-VERBAL REPRIMAND','D-SPECIAL WORK ASSIGNMENT','E-WITHDRAWAL OF PRIVILEGES','I-BEHAVIOR PLAN/CONTRACT','K-ALT CLASSROOM ASSIGNMT','KK-ALT CLASSROOM ASSIGNMT','L-REF TO INTERVENTION PGM','LL-REF TO INTERVENTION PGM','M-CONFISCATION OF MATERIALS') THEN 1 ELSE 0 END) [Number_of_Office_Referrals__c]
		, SUM(CASE WHEN RTRIM(A.Consequence) IN ('G-DETENTION','HH-SATURDAY SCHOOL') THEN 1 ELSE 0 END) [Number_of_Detentions__c]
		, SUM(CASE WHEN RTRIM(A.Consequence) in ('SUS','IHS') THEN 1 ELSE 0 END) [Number_of_Suspensions__c]
		, e.District + '_' + CAST(CAST(e.School_ID AS INTEGER) AS VARCHAR(4)) + '_' + e.Student_ID + '_' + CAST(DATEPART(mm, CAST(a.[Incident_Date] AS DATE)) AS VARCHAR(2)) + '_' + CAST(DATEPART(dd, CAST(a.[Incident_Date] AS DATE)) AS VARCHAR(2)) + '_' + CAST(DATEPART(yyyy, CAST(a.[Incident_Date] AS DATE)) AS VARCHAR(4)) [SchoolForce__External_Id__c]
	INTO #TBBT1
	FROM Data_Services.dbo.Behavior (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Master_Student (NOLOCK) e ON 
		a.Student_ID = e.Student_ID and a.District = 'sj'
--commented out
--	left outer join Data_Services.dbo.Master_Assessment_TBBT (nolock) f on e.District + '_' + cast(cast(e.School_ID as integer) as varchar(4)) + '_' + e.Student_ID + '_' + cast(datepart(mm, cast(a.[Incident_Date] as date)) as varchar(2)) + '_' + cast(datepart(dd, cast(a.[Incident_Date] as date)) as varchar(2)) + '_' + cast(datepart(yyyy, cast(a.[Incident_Date] as date)) as varchar(4)) = f.SchoolForce__External_Id__c
--	where f.SchoolForce__External_Id__c is null
	GROUP BY e.SF_ID, CAST(a.[Incident_Date] AS DATE), e.District + '_' + CAST(CAST(e.School_ID AS INTEGER) AS VARCHAR(4)) + '_' + e.Student_ID + '_' + CAST(DATEPART(mm, CAST(a.[Incident_Date] AS DATE)) AS VARCHAR(2)) + '_' + CAST(DATEPART(dd, CAST(a.[Incident_Date] AS DATE)) AS VARCHAR(2)) + '_' + CAST(DATEPART(yyyy, CAST(a.[Incident_Date] AS DATE)) AS VARCHAR(4))


	INSERT INTO Data_Services.dbo.SF_Assessment_TBBT(Student_ID
		, SchoolForce__Type__c
		, SchoolForce__Assessment_Name__c
		, Date_Administered__c
		, Number_of_Office_Referrals__c
		, Number_of_Detentions__c
		, [Number_of_Suspensions__c]
		, SchoolForce__External_Id__c)
	SELECT a.Student_ID
	, a.SchoolForce__Type__c
	, a.SchoolForce__Assessment_Name__c
	, a.[Date_Administered__c]
	, a.[Number_of_Office_Referrals__c]
	, a.[Number_of_Detentions__c]
	, a.[Number_of_Suspensions__c]
	, a.[SchoolForce__External_Id__c]
	FROM #TBBT1 (NOLOCK) a LEFT OUTER JOIN 
	Data_Services.dbo.Master_Assessment_TBBT (NOLOCK) f ON 
		a.[SchoolForce__External_Id__c] = f.SchoolForce__External_Id__c
	WHERE f.SchoolForce__External_Id__c IS NULL

	INSERT INTO Data_Services.dbo.SF_Assessment_TBBT(Student_ID
	, SchoolForce__Type__c
	, SchoolForce__Assessment_Name__c
	, Date_Administered__c
	, Number_of_Office_Referrals__c
	, Number_of_Detentions__c
	, [Number_of_Suspensions__c]
	, SchoolForce__External_Id__c)
	
	SELECT a.Student_ID
		, a.SchoolForce__Type__c
		, a.SchoolForce__Assessment_Name__c
		, a.[Date_Administered__c]
		, a.[Number_of_Office_Referrals__c]
		, a.[Number_of_Detentions__c]
		, a.[Number_of_Suspensions__c]
		, a.[SchoolForce__External_Id__c]
	FROM #TBBT1 (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Master_Assessment_TBBT (NOLOCK) f ON 
		a.[SchoolForce__External_Id__c] = f.SchoolForce__External_Id__c
	WHERE a.[Number_of_Office_Referrals__c] <> f.[Number_of_Office_Referrals__c] OR 
		a.[Number_of_Detentions__c] <> f.[Number_of_Detentions__c] OR 
		a.[Number_of_Suspensions__c] <> f.[Number_of_Suspensions__c]

END
ELSE 
BEGIN

	truncate table Data_Services.dbo.SF_Assessment_TBBT

	select e.SF_ID Student_ID,
	(select [Value] from [Data_Services].[dbo].[Settings] where [Name] = 'TBBT.Type') as SchoolForce__Type__c,
	'Time Based Behavior Tracker' as SchoolForce__Assessment_Name__c,
	cast(a.[Incident_Date] as date) [Date_Administered__c],
	sum(case when rtrim(A.Consequence) in ('B-COUNSELING AND DIRECTION','BB-NO CONTACT CONTRACT','C-VERBAL REPRIMAND','D-SPECIAL WORK ASSIGNMENT','E-WITHDRAWAL OF PRIVILEGES','I-BEHAVIOR PLAN/CONTRACT','K-ALT CLASSROOM ASSIGNMT','KK-ALT CLASSROOM ASSIGNMT','L-REF TO INTERVENTION PGM','LL-REF TO INTERVENTION PGM','M-CONFISCATION OF MATERIALS') then 1 else 0 end) [Number_of_Office_Referrals__c],
	sum(case when rtrim(A.Consequence) in ('G-DETENTION','HH-SATURDAY SCHOOL') then 1 else 0 end) [Number_of_Detentions__c],
	sum(case when rtrim(A.Consequence) in ('P-IN-SCHOOL SUSPENSION','R-SUSPENSION FROM SCHOOL','S-SUS FROM SCHOOL(10 DAYS)') then 1 else 0 end) [Number_of_Suspensions__c], 
	e.District + '_' + cast(cast(e.School_ID as integer) as varchar(4)) + '_' + e.Student_ID + '_' + cast(datepart(mm, cast(a.[Incident_Date] as date)) as varchar(2)) + '_' + cast(datepart(dd, cast(a.[Incident_Date] as date)) as varchar(2)) + '_' + cast(datepart(yyyy, cast(a.[Incident_Date] as date)) as varchar(4)) [SchoolForce__External_Id__c]
	into #TBBT
	from Data_Services.dbo.Behavior (nolock) a
	inner join Data_Services.dbo.Master_Student (nolock) e on a.Student_ID = e.Student_ID
--	left outer join Data_Services.dbo.Master_Assessment_TBBT (nolock) f on e.District + '_' + cast(cast(e.School_ID as integer) as varchar(4)) + '_' + e.Student_ID + '_' + cast(datepart(mm, cast(a.[Incident_Date] as date)) as varchar(2)) + '_' + cast(datepart(dd, cast(a.[Incident_Date] as date)) as varchar(2)) + '_' + cast(datepart(yyyy, cast(a.[Incident_Date] as date)) as varchar(4)) = f.SchoolForce__External_Id__c
--	where f.SchoolForce__External_Id__c is null
	group by e.SF_ID, cast(a.[Incident_Date] as date), e.District + '_' + cast(cast(e.School_ID as integer) as varchar(4)) + '_' + e.Student_ID + '_' + cast(datepart(mm, cast(a.[Incident_Date] as date)) as varchar(2)) + '_' + cast(datepart(dd, cast(a.[Incident_Date] as date)) as varchar(2)) + '_' + cast(datepart(yyyy, cast(a.[Incident_Date] as date)) as varchar(4))

	insert into Data_Services.dbo.SF_Assessment_TBBT(Student_ID, SchoolForce__Type__c, SchoolForce__Assessment_Name__c, Date_Administered__c, Number_of_Office_Referrals__c, Number_of_Detentions__c, [Number_of_Suspensions__c], SchoolForce__External_Id__c)
	select a.Student_ID, a.SchoolForce__Type__c, a.SchoolForce__Assessment_Name__c, a.[Date_Administered__c], a.[Number_of_Office_Referrals__c], a.[Number_of_Detentions__c], a.[Number_of_Suspensions__c], a.[SchoolForce__External_Id__c]
	from #TBBT (nolock) a
	left outer join Data_Services.dbo.Master_Assessment_TBBT (nolock) f on a.[SchoolForce__External_Id__c] = f.SchoolForce__External_Id__c
	where f.SchoolForce__External_Id__c is null

	insert into Data_Services.dbo.SF_Assessment_TBBT(Student_ID, SchoolForce__Type__c, SchoolForce__Assessment_Name__c, Date_Administered__c, Number_of_Office_Referrals__c, Number_of_Detentions__c, [Number_of_Suspensions__c], SchoolForce__External_Id__c)
	select a.Student_ID, a.SchoolForce__Type__c, a.SchoolForce__Assessment_Name__c, a.[Date_Administered__c], a.[Number_of_Office_Referrals__c], a.[Number_of_Detentions__c], a.[Number_of_Suspensions__c], a.[SchoolForce__External_Id__c]
	from #TBBT (nolock) a
	inner join Data_Services.dbo.Master_Assessment_TBBT (nolock) f on a.[SchoolForce__External_Id__c] = f.SchoolForce__External_Id__c
	where a.[Number_of_Office_Referrals__c] <> f.[Number_of_Office_Referrals__c] or a.[Number_of_Detentions__c] <> f.[Number_of_Detentions__c] or a.[Number_of_Suspensions__c] <> f.[Number_of_Suspensions__c]
END

END


GO
