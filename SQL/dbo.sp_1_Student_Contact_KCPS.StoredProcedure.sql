USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_1_Student_Contact_KCPS]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date	 <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[sp_1_Student_Contact_KCPS]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

	Delete from Data_Services.dbo.SF_Contact_Student where substring(Student_ID,1,4) = 'KCPS' 
	--truncate table Data_Services.dbo.Master_Contact_Student


	--insert records from Student table and load into SF Contact Student table
	--SF Contact table records get loaded to cyschoolhouse
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
	SELECT 
	--(select [Value] from [Data_Services].[dbo].[Settings] where [Name] = 'Contact.Account_ID') AccountID 
	'0013600000QJeqzAAD' AccountID,
	--,(select [Value] from [Data_Services].[dbo].[Settings] where [Name] = 'Contact.Record_Type') RecordType
	-- 012550000008VdFAAU (OLD ID)
	'012360000007jgNAAQ' RecordType
	,a.District + '_' + cast(cast(a.School_ID as integer) as varchar(4)) + '_' + a.Student_ID Student_ID
	,Last_Name
	,First_Name
	,Date_Of_Birth
	,CASE Sex WHEN 'M' THEN 'Male'
			  ELSE 'Female'
	 END 
	,Ethnicity
	,Disability_Flag
	,CASE ELL_Flag WHEN 'Y' THEN '1' 
				   ELSE '0' 
	 END
	,Home_Language
	,Address_Line_1
	,City
	,State
	,Zip
	,Home_Phone
	,CASE WHEN Race LIKE '%Black%' THEN 'African American'
		  WHEN Race LIKE '%Afr%'   THEN 'African American'
	 ELSE Race
	 END
	FROM Data_Services.dbo.Student (nolock) a 
	left outer join SDW_Stage_Prod.dbo.Contact (nolock) b on a.District + '_' + cast(cast(a.School_ID as integer) as varchar(4)) + '_' + a.Student_ID = b.ID__c
	where b.ID__c is null and a.DIstrict = 'KCPS'
	
	END

	

GO
