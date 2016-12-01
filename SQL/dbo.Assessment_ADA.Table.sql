USE [Data_Services]
GO
/****** Object:  Table [dbo].[Assessment_ADA]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assessment_ADA](
	[Student_ID] [varchar](256) NULL,
	[Marking_Period] [varchar](256) NULL,
	[Type] [varchar](256) NULL,
	[ADA_Value] [varchar](256) NULL,
	[District] [varchar](256) NULL,
	[RunDate] [varchar](256) NULL
) ON [PRIMARY]

GO
