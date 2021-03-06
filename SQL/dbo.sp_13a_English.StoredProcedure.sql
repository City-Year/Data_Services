USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_13a_English]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_13a_English]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	insert into Data_Services.dbo.Master_Assessment_english(Student_ID, SchoolForce__Type__c, SchoolForce__Assessment_Name__c, Date_Administered__c, FSA_ELA_Score_c, Local_Benchmark__c, SchoolForce__External_Id__c, SF_ID, Assessment_Name, Source_Student_ID)
	select b.Student_ID, b.SchoolForce__Type__c, b.SchoolForce__Assessment_Name__c, b.Date_Administered__c, b.FSA_ela_Score_c, b.Local_Benchmark__c, b.SchoolForce__External_Id__c, a.ID SF_ID, 'ELA' Assessment_Name, c.Student_ID Source_Student_ID
	from SDW_Stage_Prod_17.dbo.Assesment__c (nolock) a
	inner join Data_Services.dbo.SF_Assessment_english (nolock) b on a.[External_Id__c] = b.[SchoolForce__External_Id__c]
	inner join Data_Services.dbo.Master_Student (nolock) c on b.Student_ID = c.SF_ID
	left outer join Data_Services.dbo.Master_Assessment_English (nolock) d on b.SchoolForce__External_Id__c = d.[SchoolForce__External_Id__c]
	where d.[SchoolForce__External_Id__c] is null

END



GO
