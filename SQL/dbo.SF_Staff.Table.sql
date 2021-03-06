USE [Data_Services]
GO
/****** Object:  Table [dbo].[SF_Staff]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SF_Staff](
	[SchoolForce__First_Name_Staff__c] [varchar](256) NULL,
	[SchoolForce__Staff_Last_Name__c] [varchar](256) NULL,
	[SchoolForce__Organization__c] [varchar](256) NULL,
	[Source_School_ID] [varchar](250) NULL,
	[DistStaffID] [int] NULL,
	[SchoolForce__Active__c] [int] NULL,
	[SchoolForce__Individual__c] [varchar](256) NULL,
	[SchoolForce__External_Id__c] [varchar](256) NULL
) ON [PRIMARY]

GO
