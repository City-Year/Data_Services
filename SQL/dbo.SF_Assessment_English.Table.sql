USE [Data_Services]
GO
/****** Object:  Table [dbo].[SF_Assessment_English]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF_Assessment_English](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Student_ID] [varchar](18) NOT NULL,
	[SchoolForce__Type__c] [varchar](18) NOT NULL,
	[SchoolForce__Assessment_Name__c] [varchar](46) NOT NULL,
	[Date_Administered__c] [date] NULL,
	[FSA_ELA_Score_c] [varchar](256) NOT NULL,
	[Local_Benchmark__c] [varchar](256) NULL,
	[SchoolForce__External_Id__c] [varchar](256) NULL
) ON [PRIMARY]

GO
