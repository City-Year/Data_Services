USE [Data_Services]
GO
/****** Object:  Table [dbo].[Master_Section]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_Section](
	[SF_Section_External_ID] [varchar](358) NULL,
	[FirstName] [varchar](255) NULL,
	[LastName] [varchar](255) NULL,
	[School_Name] [varchar](256) NULL,
	[Class_Section_ID] [varchar](256) NULL,
	[Source_School_ID] [varchar](250) NULL,
	[SF_Staff_External_ID] [varchar](250) NULL,
	[Class_Period_Name] [varchar](256) NULL,
	[Section_Type] [varchar](256) NULL,
	[Period] [varchar](256) NULL,
	[SF_ID] [varchar](250) NULL
) ON [INDEX]

GO
