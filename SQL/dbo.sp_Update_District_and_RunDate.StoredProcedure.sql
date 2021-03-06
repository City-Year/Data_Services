USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_District_and_RunDate]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Update_District_and_RunDate] @District varchar(256)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE Data_Services.dbo.Assessments set District = @District where District is null
	UPDATE Data_Services.dbo.Assessments set RunDate = getdate() where RunDate is null
	UPDATE Data_Services.dbo.Assignment_Grades set District = @District where District is null
	UPDATE Data_Services.dbo.Assignment_Grades set RunDate = getdate() where RunDate is null
	UPDATE Data_Services.dbo.Attendance set District = @District where District is null
	UPDATE Data_Services.dbo.Attendance set RunDate = getdate() where RunDate is null
	UPDATE Data_Services.dbo.Behavior set District = @District where District is null
	UPDATE Data_Services.dbo.Behavior set RunDate = getdate() where RunDate is null
	UPDATE Data_Services.dbo.Class set District = @District where District is null
	UPDATE Data_Services.dbo.Class set RunDate = getdate() where RunDate is null
	UPDATE Data_Services.dbo.MP_Grades set District = @District where District is null
	UPDATE Data_Services.dbo.MP_Grades set RunDate = getdate() where RunDate is null
	UPDATE Data_Services.dbo.Student set District = @District where District is null
	UPDATE Data_Services.dbo.Student set RunDate = getdate() where RunDate is null
END

GO
