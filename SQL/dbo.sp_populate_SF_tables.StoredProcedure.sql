USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_populate_SF_tables]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_populate_SF_tables]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- Refresh School_Lookup

TRUNCATE TABLE School_Lookup
--Reload SF account look up information
INSERT INTO [Data_Services].[dbo].[School_Lookup] ([School_Name]
      ,[Account_ID]
      ,[School_Grades]
      ,[County]
      ,[Source_School_Name]
      ,[Source_School_ID])
      
SELECT DISTINCT B.Name AS SchoolName
		,B.ID AS AccountID
		,C.Grades
		,County = 'OCPS'
	   ,A.[School_Name] AS Source_School_Name
	   ,A.[School_ID] AS Source_School_ID
  FROM [Data_Services].[dbo].[Student] A INNER JOIN
  SDW_Stage.dbo.Account B ON A.School_Name+' School' = B.Name INNER JOIN
  vw_School_Grades C ON A.School_ID = C.School_ID 

-- [Update Setup_14_15 on School_Lookup]
UPDATE [dbo].[School_Lookup] SET [Setup_14_15] = SU.Setup_14_15
FROM [dbo].[School_Lookup] A inner join
(SELECT Account_ID
      ,b.id as [Setup_14_15]
  FROM [Data_Services].[dbo].[School_Lookup] a inner join 
  sdw_stage.dbo.SchoolForce__Setup__c b ON 
	a.Account_ID = b.SchoolForce__School__c 
	WHERE b.SchoolForce__Year__c = 'a1VE0000002R2GDMA0')SU ON
	a.Account_ID = SU.Account_ID

-- [Clear table for loading student contact records]

TRUNCATE TABLE Data_Services.dbo.SF_Contact_Student

-- [Pull and structure data from the student table and insert into SF_Contact_Student for loading student contacts into SchoolForce]

INSERT INTO Data_Services.dbo.SF_Contact_Student(AccountID
		,RecordType
		,Student_ID
		,Last_Name
		,First_Name
		,Date_Of_Birth
		,Sex
		,Ethnicity
		,Disability_Flag
		,ELL_Flag
		,Home_Language
		,Address_Line_1
		,City
		,State
		,Zip
		,Home_Phone
		,Race)
SELECT '001E000000NQWE4IAP' AccountID
	  ,'012E0000000UD8LIAW' RecordType
	  ,Student_ID
	  ,Last_Name
	  ,First_Name
	  ,Date_Of_Birth
	  ,CASE Sex WHEN 'M' 
		THEN 'Male'
		ELSE 'Female'
		END 
	  ,Ethnicity
	  ,Disability_Flag
	  ,CASE ELL_Flag WHEN 'Y'
		THEN '1' 
		ELSE '0' 
		END
	 ,Home_Language
	 ,Address_Line_1
	 ,City
	 ,State
	 ,Zip
	 ,Home_Phone
	 ,CASE WHEN Race LIKE '%Black%' 
			THEN 'African American'
		   WHEN Race LIKE '%Afr%' 
			THEN 'African American'
		   ELSE Race
		   END
FROM Data_Services.dbo.Student (nolock)

-- [Clear table for loading staff contact records]

TRUNCATE TABLE Data_Services.dbo.SF_Contact_Staff

-- [Pull and structure data from the student table and insert into SF_Contact_Student for loading student contacts into SchoolForce]

INSERT INTO Data_Services.dbo.SF_Contact_Staff (RecordType
	,Salutation
	,Last_Name
	,First_Name 
	,Email
	,Mailing_Street
	,Mailing_City
	,Mailing_State
	,Mailing_Zip
	,Gender
	,Contact_Indv_Account_ID
	,OrgID)
SELECT [Contact_Staff_RecordType]
	,[Salutation]
    ,[LastName]
    ,[FirstName]
    ,[TempEmail]
    ,[Mailing_Street]
    ,[Mailing_City]
    ,[Mailing_State]
    ,[Mailing_Postal]
    ,[Gender]
    ,[Contact_Individual_AccountID]
    ,[ORG_ID_for_StaffRcd]
FROM vw_Staff_Contact_Essential_Info

-- [Clear table for loading Schedule Template records]

TRUNCATE TABLE dbo.SF_Schedule_Template

-- [Pull and structure data from Schedule Template view and insert into SF_Schedule_Template for loading Schedule Templates into SchoolForce]

INSERT INTO dbo.SF_Schedule_Template  (IsDeleted
, Name
, SchoolForce__Color__c
, SchoolForce__End_Time_Text__c
, SchoolForce__End_Time__c
, SchoolForce__External_Id__c
, SchoolForce__Has_Class__c
, SchoolForce__Is_Master__c
, SchoolForce__Reference_Id__c
, SchoolForce__Reporting_Period__c
, SchoolForce__Setup__c
, SchoolForce__Start_Time_Text__c
, SchoolForce__Start_Time__c
, SchoolForce__Number_of_Periods__c)

SELECT IsDeleted
, Name
, SchoolForce__Color__c
, SchoolForce__End_Time_Text__c
, SchoolForce__End_Time__c
, SchoolForce__External_Id__c
, SchoolForce__Has_Class__c
, SchoolForce__Is_Master__c
, SchoolForce__Reference_Id__c
, SchoolForce__Reporting_Period__c
, SchoolForce__Setup__c
, SchoolForce__Start_Time_Text__c
, SchoolForce__Start_Time__c
, SchoolForce__Number_of_Periods__c

FROM
dbo.vw_Final_Schedule_templates

END






GO
