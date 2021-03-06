USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_Index_Assignment_Grades_Drop]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Index_Assignment_Grades_Drop]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/****** Object:  Index [Student_ID]    Script Date: 11/23/2015 12:35:26 PM ******/
	DROP INDEX [Student_ID] ON [Data_Services].[dbo].[Assignment_Grades]

	/****** Object:  Index [Class_Section_ID]    Script Date: 11/23/2015 12:35:29 PM ******/
	DROP INDEX [Class_Section_ID] ON [Data_Services].[dbo].[Assignment_Grades]

	/****** Object:  Index [Assignment_Type]    Script Date: 11/23/2015 12:35:36 PM ******/
	DROP INDEX [Assignment_Type] ON [Data_Services].[dbo].[Assignment_Grades]

	/****** Object:  Index [Marking_Period]    Script Date: 11/23/2015 12:35:43 PM ******/
	DROP INDEX [Marking_Period] ON [Data_Services].[dbo].[Assignment_Grades]
	/****** Object:  Index [Assignment_Name]    Script Date: 11/23/2015 12:35:50 PM ******/
	DROP INDEX [Assignment_Name] ON [Data_Services].[dbo].[Assignment_Grades]

END

GO
