USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_3_Student_LA]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_3_Student_LA]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM dbo.SF_Student
	WHERE
	SchoolForce__External_Id__c like 'LA_%' 
	-- truncate table Data_Services_DEV.dbo.Master_Student

	INSERT INTO Data_Services.dbo.SF_Student(SchoolForce__Student_Last_Name__c
	, SchoolForce__Student_First_Name__c
	, SchoolForce__Grade__c
	, SchoolForce__School__c
	, SchoolForce__Year__c
	, SchoolForce__Active__c
	, SchoolForce__Individual__c
	, [SchoolForce__External_Id__c]
	, [SchoolForce__Setup__c]
	, [Student_ID]
	, [LocalStudentID]
	, Date_Of_Birth
	, Sex
	, Ethnicity)
	
	SELECT
	a.Last_Name AS SchoolForce__Student_Last_Name__c
	,a.First_Name AS SchoolForce__Student_First_Name__c
	,a.Grade  AS SchoolForce__Grade__c
	,b.Account_ID AS SchoolForce__School__c
	,'2016' AS SchoolForce__Year__c
	,1 AS SchoolForce__Active__c
	,c.Id AS SchoolForce__Individual__c
	,a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID AS [SchoolForce__External_Id__c]
	,b.Setup_14_15 AS [SchoolForce__Setup__c]
	,a.Student_ID AS Student_ID
	,a.Student_ID AS LocalStudentID
	,a.Date_Of_Birth
	,CASE a.Sex WHEN 'M' THEN 'M'
			  ELSE 'F'
	 END 
	,a.Ethnicity
	
	FROM Data_Services.dbo.vw_LA_Student (nolock) a INNER JOIN 
	Data_Services.dbo.School_Lookup_16_17 (nolock) b ON 
		a.School_Name = b.Source_School_Name INNER JOIN 
	SDW_Stage_Prod_17.dbo.Contact (nolock) c ON 
		a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID = c.ID__c LEFT OUTER JOIN
	Data_Services.dbo.Master_Student (nolock) d ON 
		a.District + '_' + cast(cast(a.School_ID as integer) as varchar(10)) + '_' + a.Student_ID = d.[SchoolForce__External_Id__c]
	
	WHERE d.[SchoolForce__External_Id__c] is null

	
	UPDATE Data_Services.dbo.SF_Student SET Student_ID = [SchoolForce__External_Id__c]
		
	UPDATE Data_Services.dbo.SF_Student SET Date_Of_Birth = null where Date_Of_Birth = '1900-01-01 00:00:00.000'

END

GO
