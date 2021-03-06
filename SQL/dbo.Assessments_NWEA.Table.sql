USE [Data_Services]
GO
/****** Object:  Table [dbo].[Assessments_NWEA]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assessments_NWEA](
	[TestStartDate__c] [varchar](255) NULL,
	[TestDurationMinutes__c] [varchar](255) NULL,
	[TestRITScore__c] [varchar](255) NULL,
	[TestPercentile__c] [varchar](255) NULL,
	[FallToFallProjectedGrowth__c] [varchar](255) NULL,
	[FalltoFallObservedGrowth__c] [varchar](255) NULL,
	[FallToFallConditionalGrowthIndex__c] [varchar](255) NULL,
	[FallToFallConditionalGrowthPercentile__c] [varchar](255) NULL,
	[FallToWinterProjectedGrowth__c] [varchar](255) NULL,
	[FalltoWinterObservedGrowth__c] [varchar](255) NULL,
	[FallToWinterConditionalGrowthIndex__c] [varchar](255) NULL,
	[FallToWinterConditionalGrowthPercentile__c] [varchar](255) NULL,
	[FallToSpringProjectedGrowth__c] [varchar](255) NULL,
	[FalltoSpringObservedGrowth__c] [varchar](255) NULL,
	[FallToSpringConditionalGrowthIndex__c] [varchar](255) NULL,
	[FallToSpringConditionalGrowthPercentile__c] [varchar](255) NULL,
	[WinterToWinterProjectedGrowth__c] [varchar](255) NULL,
	[WinterToWinterObservedGrowth__c] [varchar](255) NULL,
	[WinterToWinterConditionalGrowthIndex__c] [varchar](255) NULL,
	[WinterToWinterConditionalGrowthPercentil__c] [varchar](255) NULL,
	[WinterToSpringProjectedGrowth__c] [varchar](255) NULL,
	[WinterToSpringObservedGrowth__c] [varchar](255) NULL,
	[WinterToSpringConditionalGrowthIndex__c] [varchar](255) NULL,
	[WinterToSpringConditionalGrowthPercentil__c] [varchar](255) NULL,
	[SpringToSpringProjectedGrowth__c] [varchar](255) NULL,
	[SpringToSpringObservedGrowth__c] [varchar](255) NULL,
	[SpringToSpringConditionalGrowthIndex__c] [varchar](255) NULL,
	[SpringToSpringConditionalGrowthPercentil__c] [varchar](255) NULL,
	[RITtoReadingScore__c] [varchar](255) NULL,
	[Source_StudentID] [varchar](255) NULL,
	[Source_DistrictID] [varchar](255) NULL,
	[Rundate] [varchar](255) NULL,
	[TestName] [varchar](255) NULL
) ON [PRIMARY]

GO
