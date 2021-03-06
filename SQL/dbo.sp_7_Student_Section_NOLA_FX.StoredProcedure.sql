USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_7_Student_Section_NOLA_FX]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_7_Student_Section_NOLA_FX]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM Data_Services.dbo.SF_Student_Section WHERE SchoolForce__Student__c IN (SELECT ID FROM SDW_STAGE.dbo.Student__c WHERE School__c like '0011a00000CbEq4AAF') 

	INSERT INTO Data_Services.dbo.SF_Student_Section(SchoolForce__Section__c
		, SchoolForce__Student__c
		, SchoolFore__Active__c)

SELECT c.SF_ID Section_ID
	 , b.SF_ID Student_ID
	, '1' Active
FROM Data_Services.dbo.Class_Processed (NOLOCK) a INNER JOIN 
Data_Services.dbo.Master_Student (NOLOCK) b ON 
		a.Student_ID = b.Student_ID INNER JOIN 
(SELECT DISTINCT SF_ID
	, FirstName, LastName
	, Class_Section_ID 
 FROM Data_Services_DEV.dbo.Master_Section (NOLOCK)) c ON
	a.Class_Section_ID = c.Class_Section_ID AND 
	a.Teacher_First_Name = c.FirstName AND 
	a.Teacher_Last_Name = c.LastName LEFT OUTER JOIN 
Data_Services_DEV.dbo.Master_Student_Section (NOLOCK) d ON 
		c.SF_ID = d.SchoolForce__Section__c AND 
		b.SF_ID = d.SchoolForce__Student__c
WHERE d.SchoolForce__Student__c is null AND 
	d.SchoolForce__Section__c is null AND 
	b.School_Name ='CLARK'

	 


END



GO
