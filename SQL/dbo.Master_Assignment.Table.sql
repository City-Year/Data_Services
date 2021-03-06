USE [Data_Services]
GO
/****** Object:  Table [dbo].[Master_Assignment]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_Assignment](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](256) NULL,
	[Assignment_Library__c] [nvarchar](18) NOT NULL,
	[SchoolForce__Due_Date__c] [nvarchar](12) NULL,
	[SchoolForce__Picklist_Value__c] [nvarchar](18) NOT NULL,
	[SchoolForce__Include_in_Final_Grade__c] [int] NOT NULL,
	[SchoolForce__Name_in_Gradebook__c] [nvarchar](250) NULL,
	[SchoolForce__Possible_Points__c] [int] NOT NULL,
	[SchoolForce__Time__c] [nvarchar](18) NOT NULL,
	[SchoolForce__Section__c] [nvarchar](250) NULL,
	[SchoolForce__Weighting_Value__c] [int] NOT NULL,
	[SchoolForce__External_Id__c] [nvarchar](250) NULL,
	[SF_ID] [varchar](18) NOT NULL,
	[Local_Assignment_Type__c] [nvarchar](250) NULL
) ON [PRIMARY]

GO
