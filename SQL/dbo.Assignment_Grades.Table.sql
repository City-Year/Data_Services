USE [Data_Services]
GO
/****** Object:  Table [dbo].[Assignment_Grades]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assignment_Grades](
	[Student_ID] [varchar](256) NULL,
	[Class_Section_ID] [varchar](256) NULL,
	[Marking_Period] [varchar](256) NULL,
	[Assignment_Type] [varchar](256) NULL,
	[Assignment_Name] [varchar](1000) NULL,
	[Grade_Value] [varchar](256) NULL,
	[Assignment_Weight] [varchar](256) NULL,
	[Applicable_State_Standard_Identifier] [varchar](256) NULL,
	[Applicable_State_Standard_Description] [varchar](256) NULL,
	[Date] [varchar](256) NULL,
	[District] [varchar](256) NULL,
	[RunDate] [varchar](256) NULL,
	[Course_ID] [varchar](256) NULL,
	[Teacher_ID] [varchar](256) NULL,
	[Period] [varchar](256) NULL
) ON [PRIMARY]

GO
