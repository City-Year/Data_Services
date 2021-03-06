USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_18a_NWEA]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_18a_NWEA]
AS
BEGIN

	insert into Data_Services.dbo.Master_Assessment_NWEA([Student_ID]
      ,[SchoolForce__Type__c]
      ,[SchoolForce__Assessment_Name__c]
      ,[Date_Administered__c]
      ,[TestDurationMinutes__c]
      ,[TestRITScore__c]
      ,[TestPercentile__c]
      ,[FallToFallProjectedGrowth__c]
      ,[FalltoFallObservedGrowth__c]
      ,[FallToFallConditionalGrowthIndex__c]
      ,[FallToFallConditionalGrowthPercentile__c]
      ,[FallToWinterProjectedGrowth__c]
      ,[FalltoWinterObservedGrowth__c]
      ,[FallToWinterConditionalGrowthIndex__c]
      ,[FallToWinterConditionalGrowthPercentile__c]
      ,[FallToSpringProjectedGrowth__c]
      ,[FalltoSpringObservedGrowth__c]
      ,[FallToSpringConditionalGrowthIndex__c]
      ,[FallToSpringConditionalGrowthPercentile__c]
      ,[WinterToWinterProjectedGrowth__c]
      ,[WinterToWinterObservedGrowth__c]
      ,[WinterToWinterConditionalGrowthIndex__c]
      ,[WinterToWinterConditionalGrowthPercentil__c]
      ,[WinterToSpringProjectedGrowth__c]
      ,[WinterToSpringObservedGrowth__c]
      ,[WinterToSpringConditionalGrowthIndex__c]
      ,[WinterToSpringConditionalGrowthPercentil__c]
      ,[SpringToSpringProjectedGrowth__c]
      ,[SpringToSpringObservedGrowth__c]
      ,[SpringToSpringConditionalGrowthIndex__c]
      ,[SpringToSpringConditionalGrowthPercentil__c]
      ,[Assessment_Name]
      ,[SchoolForce__External_Id__c]
      ,[Source_Student_ID]
      ,[SF_ID])
	
	select 
	   c.[Student_ID]
      ,b.[SchoolForce__Type__c]
      ,b.[SchoolForce__Assessment_Name__c]
      ,b.[Date_Administered__c]
      ,b.[TestDurationMinutes__c]
      ,b.[TestRITScore__c]
      ,b.[TestPercentile__c]
      ,b.[FallToFallProjectedGrowth__c]
      ,b.[FalltoFallObservedGrowth__c]
      ,b.[FallToFallConditionalGrowthIndex__c]
      ,b.[FallToFallConditionalGrowthPercentile__c]
      ,b.[FallToWinterProjectedGrowth__c]
      ,b.[FalltoWinterObservedGrowth__c]
      ,b.[FallToWinterConditionalGrowthIndex__c]
      ,b.[FallToWinterConditionalGrowthPercentile__c]
      ,b.[FallToSpringProjectedGrowth__c]
      ,b.[FalltoSpringObservedGrowth__c]
      ,b.[FallToSpringConditionalGrowthIndex__c]
      ,b.[FallToSpringConditionalGrowthPercentile__c]
      ,b.[WinterToWinterProjectedGrowth__c]
      ,b.[WinterToWinterObservedGrowth__c]
      ,b.[WinterToWinterConditionalGrowthIndex__c]
      ,b.[WinterToWinterConditionalGrowthPercentil__c]
      ,b.[WinterToSpringProjectedGrowth__c]
      ,b.[WinterToSpringObservedGrowth__c]
      ,b.[WinterToSpringConditionalGrowthIndex__c]
      ,b.[WinterToSpringConditionalGrowthPercentil__c]
      ,b.[SpringToSpringProjectedGrowth__c]
      ,b.[SpringToSpringObservedGrowth__c]
      ,b.[SpringToSpringConditionalGrowthIndex__c]
      ,b.[SpringToSpringConditionalGrowthPercentil__c]
      ,b.[Assessment_Name]
      ,b.[SchoolForce__External_Id__c]
      ,c.[Student_ID][Source_Student_ID]
      ,a.ID [SF_ID]
	from SDW_Stage_Prod.dbo.Assesment__c (nolock) a
	inner join Data_Services.dbo.SF_Assessment_NWEA (nolock) b on a.[External_Id__c] = b.[SchoolForce__External_Id__c]
	inner join Data_Services.dbo.Master_Student (nolock) c on b.Student_ID = c.SF_ID
	left outer join Data_Services.dbo.Master_Assessment_NWEA (nolock) d on a.External_Id__c = d.SchoolForce__External_Id__c
	where d.SchoolForce__External_Id__c is null
END


GO
