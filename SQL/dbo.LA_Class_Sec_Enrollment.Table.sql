USE [Data_Services]
GO
/****** Object:  Table [dbo].[LA_Class_Sec_Enrollment]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LA_Class_Sec_Enrollment](
	[Student_ID] [varchar](256) NULL,
	[School_ID] [varchar](256) NULL,
	[School_Name] [varchar](256) NULL,
	[Student_Name] [varchar](256) NULL,
	[Foster_Status] [varchar](256) NULL,
	[Teacher_Name] [varchar](256) NULL,
	[Course] [varchar](256) NULL,
	[Period] [varchar](256) NULL,
	[Grade] [varchar](250) NULL,
	[Gender] [varchar](250) NULL,
	[Ethn] [varchar](250) NULL,
	[SpEd] [varchar](250) NULL,
	[ELL_Flag] [varchar](250) NULL
) ON [PRIMARY]

GO
