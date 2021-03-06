USE [Data_Services]
GO
/****** Object:  Table [dbo].[SF_Assessments_NWEA]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF_Assessments_NWEA](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Student_ID] [varchar](18) NOT NULL,
	[SchoolForce__Type__c] [varchar](18) NULL,
	[SchoolForce__Assessment_Name__c] [varchar](255) NOT NULL,
	[Date_Administered__c] [date] NULL,
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
	[Assessment_Name] [varchar](255) NULL,
	[SchoolForce__External_Id__c] [varchar](255) NULL,
	[Source_Student_ID] [varchar](255) NULL
) ON [PRIMARY]

GO
