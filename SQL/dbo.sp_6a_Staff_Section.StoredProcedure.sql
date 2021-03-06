USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_6a_Staff_Section]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_6a_Staff_Section]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO Data_Services.dbo.Master_Staff_Section(ID
		, SchoolForce__Staff__c
		, SchoolForce__Section__c
		, SchoolForce__External_Id__c
		)
	
	SELECT e.ID
		, a.SF_Staff_ID
		, a.SF_Section_ID
		, a.SchoolForce__External_Id__c

	FROM Data_Services.dbo.SF_Staff_Section (NOLOCK) a LEFT OUTER JOIN
	Data_Services.dbo.Master_Staff_Section (NOLOCK) d ON 
		a.SF_Staff_ID = d.SchoolForce__Staff__c AND 
		a.SF_Section_ID = d.SchoolForce__Section__c INNER JOIN 
	SDW_Stage_prod_17.dbo.Staff_Section__c (NOLOCK) e ON 
		a.SF_Staff_ID = e.Staff__c AND 
		a.SF_Section_ID = e.[Section__c] AND 
		a.SchoolForce__External_Id__c = e.External_Id__c

	WHERE d.SchoolForce__Staff__c IS NULL AND  
		d.SchoolForce__Section__c IS NULL AND 
		isnumeric(e.External_Id__c) = 1

END

GO
