USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_2_Staff_Contact]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_2_Staff_Contact] @District varchar(255) = 'Standard'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if @District = 'OCPS'
	BEGIN
	insert into Data_Services.dbo.Class_Processed(Student_ID, Class_Section_ID, Class_Period_Name, Period, Teacher_Name, Teacher_First_Name, Teacher_Last_Name)
	select distinct a.Student_ID, a.Class_Section_ID, Period_Name, a.Period, a.Teacher_Name, substring(a.Teacher_Name, charindex(',', a.Teacher_Name) + 2, len(a.Teacher_Name) - charindex(',', a.Teacher_Name) - 1) First_Name,
	substring(a.Teacher_Name, 0, charindex(',', a.Teacher_Name)) Last_Name 
	from Data_Services.dbo.Class (nolock) a
	left outer join Data_Services.dbo.Class_Processed (nolock) b on 
	a.Student_ID = b.Student_ID and
	a.Class_Section_ID = b.Class_Section_ID and
	a.Period = b.Period and 
	a.Teacher_Name = b.Teacher_Name
	where b.Student_ID is null and b.Class_Section_ID is null and b.Period is null and b.Teacher_Name is null and a.District = 'OCPS'
	END

	if @District = 'KCPS'
	BEGIN

	insert into Data_Services.dbo.Class_Processed(Student_ID, 
	Class_Section_ID, 
	Class_Period_Name, 
	Period, Teacher_Name, 
	Teacher_First_Name, 
	Teacher_Last_Name,
	District)

	select distinct a.Student_ID, 
	a.Class_Section_ID, 
	Period_Name, 
	a.Period, 
	a.Teacher_Name, 
	LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) First_Name, 
	substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)) Last_Name,
	a.District
	from Data_Services.dbo.Class (nolock) a
	left outer join Data_Services.dbo.Class_Processed (nolock) b on 
	a.Student_ID = b.Student_ID and
	a.Class_Section_ID = b.Class_Section_ID and
	a.Period = b.Period and 
	a.Teacher_Name = b.Teacher_Name
	where b.Student_ID is null and b.Class_Section_ID is null and b.Period is null and b.Teacher_Name is null 
	AND  a.district = 'KCPS'
		
	END

	if @District = '1STLN'
	BEGIN
	INSERT INTO Data_Services.dbo.Class_Processed(
		  Student_ID
		, Class_Section_ID
		, Class_Period_Name
		, Period, Teacher_Name
		, Teacher_First_Name
		, Teacher_Last_Name
		, District
		)

	SELECT DISTINCT a.Student_ID
		, a.Class_Section_ID
		, a.Period_Name
		, a.Period
		, a.Teacher_Name
		, SUBSTRING(a.Teacher_Name, CHARINDEX(',', a.Teacher_Name) + 2, LEN(a.Teacher_Name) - CHARINDEX(',', a.Teacher_Name) - 1) First_Name
		, SUBSTRING(a.Teacher_Name, 0, CHARINDEX(',', a.Teacher_Name)) Last_Name
		, a.District 
	
	FROM Data_Services.dbo.Class (NOLOCK) a LEFT OUTER JOIN 
	Data_Services.dbo.Class_Processed (NOLOCK) b ON 
		a.Student_ID = b.Student_ID AND
		a.Class_Section_ID = b.Class_Section_ID AND
		a.Period = b.Period AND 
		a.Teacher_Name = b.Teacher_Name
	
	WHERE b.Student_ID IS NOT NULL 
		AND b.Class_Section_ID IS NOT NULL 
		AND b.Period IS NOT NULL 
		AND b.Teacher_Name IS NOT NULL 
		AND a.District = '1STLN'
	END
	
	IF @District = 'LRA'
	BEGIN
	INSERT INTO Data_Services.dbo.Class_Processed(
		  Student_ID
		, Class_Section_ID
		, Class_Period_Name
		, Period, Teacher_Name
		, Teacher_First_Name
		, Teacher_Last_Name
		, District
		)

	SELECT DISTINCT a.Student_ID
		, a.Class_Section_ID
		, a.Period_Name
		, a.Period
		, a.Teacher_Name
		, SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)) First_Name
		, SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX(' ', a.Teacher_Name)) Last_Name 
		, a.District
	
	FROM Data_Services.dbo.Class (NOLOCK) a LEFT OUTER JOIN 
	Data_Services.dbo.Class_Processed (NOLOCK) b ON 
		a.Student_ID = b.Student_ID AND
		a.Class_Section_ID = b.Class_Section_ID AND
		a.Period = b.Period AND 
		a.Teacher_Name = b.Teacher_Name
	
	WHERE b.Student_ID IS NULL 
		AND b.Class_Section_ID IS NULL 
		AND b.Period IS NULL 
		AND b.Teacher_Name IS NULL 
		AND a.District = 'LRA'
		
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%MATH%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Algebra%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Geometry%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%English%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Language%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Reading%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Debate%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Journalism%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%MATH%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Algebra%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Geometry%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%English%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Language%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Reading%' AND District = 'LRA'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Debate%' AND District = 'LRA'
	-- Addition CSD 11/15/16 for NOLA
		update Data_Services.dbo.Class_Processed set Section_Type = 'MATH' where Class_Period_Name like '%ALG%' AND District = 'LRA'
		update Data_Services.dbo.Class_Processed set Section_Type = 'MATH' where Class_Period_Name like '%GEOM%' AND District = 'LRA'
		update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%READ%' AND District = 'LRA'
		update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%ENG%' AND District = 'LRA'
		update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%READ%' AND District = 'LRA'
		update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%LIT%' AND District = 'LRA'
	-- END Addition CSD 11/15/16 for NOLA
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Journalism%' AND District = 'LRA'	
	END

	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%MATH%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Algebra%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Geometry%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%English%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Language%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Reading%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Debate%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Journalism%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%MATH%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Algebra%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Geometry%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%English%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Language%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Reading%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Debate%'
	-- Addition CSD 11/15/16 for NOLA
		update Data_Services.dbo.Class_Processed set Section_Type = 'MATH' where Class_Period_Name like '%ALG%'
		update Data_Services.dbo.Class_Processed set Section_Type = 'MATH' where Class_Period_Name like '%GEOM%'
		update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%READ%'
		update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%ENG%'
		update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%READ%'
		update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%LIT%'
	-- END Addition CSD 11/15/16 for NOLA
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Journalism%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Academic Assistance&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%ACT Prep&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Advanced Career Readiness&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%ADVISORY SEMINAR&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Advisory&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Algebra I&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Algebra I (K-8)&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Algebra I DL (K-8)&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Algebra II&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%American History%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%American History (K-8)&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Art&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Art I&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Band&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Beginning Band&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Biology&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Biology (K-8)&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Business English&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Business Math&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Chemistry&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Civics&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%choir&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Clothing & Textiles Occupations&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Computer&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Culinary%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Customer Service&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Debate&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Early Release&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%EARLY RELEASE (2 PERIODS)&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Education For Careers&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%ELA/Literacy 3&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%ELA/Literacy 4&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%ELA/Literacy 5&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%ELA/Literacy 6&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%ELA/Literacy 7&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%ELA/Literacy 8&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%ELA/Literacy Lab&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%ELA/Literacy SC&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%English I&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%English II&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%English III&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%English IV&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%ESL IV&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Food Services I&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Garden&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%General Elective&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Geometry&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Geography&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Health&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Health Education&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Homeroom&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Intermediate Band&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Intro. Health Care Information Systems&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Journey To Careers&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Kinder Elective&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Lunch' where Class_Period_Name like '%Lunch&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Math 1&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Math 2&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Math 3&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Math 4&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Math 5&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Math 6&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Math 7&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Math 8&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Math K&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Math Lab&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Math SC&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Multimedia Productions&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Music&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Nccer Carpentry I&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Nurse Assistant&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Office Assistant&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Orchestra&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%PE 1&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%PE 2&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%PE 3&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%PE 4&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%PE 5&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%PE 6&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%PE 7&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%PE 8&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%PE K&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Physical Education I&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Physical Education II&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Physics I&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Pre-Calculus&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%PREK &'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Reading 1&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Reading 2&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Reading K&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Reading SC&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Recess' where Class_Period_Name like '%Recess&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Science 1&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Science 2&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Science 3&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Science 4&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Science 5&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Science 6&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Science 7&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Science 8&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Science K&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Science SC&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Social Studies 1&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Social Studies 2&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Social Studies 3&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Social Studies 4&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Social Studies 5&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Social Studies 6&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Social Studies 7&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Social Studies 8&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Social Studies K&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Social Studies SC&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Social Studies%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Science%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Spanish&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Spanish I&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Spanish II&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Speech II&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Technical Writing&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Elective' where Class_Period_Name like '%Technology&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%US History&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%World Geography&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%World History&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Writing 1&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Writing 2&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Writing K&'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Writing SC&'

	TRUNCATE TABLE Data_Services.dbo.SF_Contact_Staff
	-- truncate table Data_Services.dbo.Master_Contact_Staff

if @District = 'OCPS'
	BEGIN

	-- SF_Contact_Staff
	INSERT INTO Data_Services.dbo.SF_Contact_Staff (RecordType
		,Salutation
		,Last_Name
		,First_Name 
		,Email
		,Mailing_Street
		,Mailing_City
		,Mailing_State
		,Mailing_Zip
		,Gender
		,Contact_Indv_Account_ID
		,OrgID, AccountID)
	select distinct 
	(select [Value] from [Data_Services].[dbo].[Settings] where [Name] = 'Contact.Record_Type') RecordType,
	-- 012550000008VdFAAU (OLD ID)
	'' Salutation, 
	substring(Teacher_Name, 0, charindex(',', Teacher_Name)) Last_Name, 
	substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) First_Name,
	replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') SchoolForce__ID__c,
	'' [Mailing_Street],
	'' [Mailing_City],
	'' [Mailing_State],
	'' [Mailing_Postal],
	'' [Gender],
	(select [Value] from [Data_Services].[dbo].[Settings] where [Name] = 'Contact.Account_ID') [Contact_Individual_AccountID],
	'' OrgID,
	(select [Value] from [Data_Services].[dbo].[Settings] where [Name] = 'Contact.Account_ID') AccountID
	from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID
	left outer join SDW_Stage_Prod.dbo.Contact (nolock) c on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = c.ID__c
	where c.ID__c is null
	END
		
If @District = 'KCPS'
BEGIN
	INSERT INTO Data_Services.dbo.SF_Contact_Staff (RecordType
	,Salutation
	,Last_Name
	,First_Name 
	,Email
	,Mailing_Street
	,Mailing_City
	,Mailing_State
	,Mailing_Zip
	,Gender
	,Contact_Indv_Account_ID
	,OrgID
	,AccountID)
	select distinct 
	(select [ID] from [sdw_stage_prod_17].[dbo].RecordType where [Name] = 'staff') RecordType
	--(select [Value] from [Data_Services].[dbo].[Settings] where [Name] = 'Contact.Record_Type') RecordType
	,'' Salutation, 
	substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)) Last_Name,
	LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) First_Name,
	replace(a.District + '_' + School_ID + '_' + LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) + '_' + substring(a.Teacher_Name, charindex(' ', 
						 a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)), ' ', '_') SchoolForce__ID__c,
	'' [Mailing_Street],
	'' [Mailing_City],
	'' [Mailing_State],
	'' [Mailing_Postal],
	'' [Gender],
	'0013600000QJeqzAAD' [Contact_Individual_AccountID],
	'' OrgID,
	'0013600000QJeqzAAD' AccountID  
	from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID
	left outer join sdw_stage_prod_17.dbo.Contact (nolock) c on replace(a.District + '_' + School_ID + '_' + LEFT(a.Teacher_Name, charindex(' ', a.Teacher_Name)- 1) + '_' + substring(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)), ' ', '_') = c.ID__c
	where a.District = 'KCPS' and b.district = 'kcps'
	--c.ID__c is null
	--AND 
END


If @District = '1STLN'
BEGIN
INSERT INTO Data_Services.dbo.SF_Contact_Staff (RecordType
	,Salutation
	,Last_Name
	,First_Name 
	,Email
	,Mailing_Street
	,Mailing_City
	,Mailing_State
	,Mailing_Zip
	,Gender
	,Contact_Indv_Account_ID
	,OrgID
	,AccountID)
SELECT DISTINCT (SELECT [ID] FROM [SDW_Stage_PROD_17].[dbo].RecordType WHERE [Name] = 'staff') RecordType
	, '' Salutation
	, SUBSTRING(a.Teacher_Name, 0, CHARINDEX(',', a.Teacher_Name)) Last_Name
	, SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX('_', a.Teacher_Name)) First_Name
	, REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(a.Teacher_Name, 0, CHARINDEX(',', a.Teacher_Name)) + '_' + SUBSTRING(a.Teacher_Name, charindex(' ', a.Teacher_Name) + 1, len(a.Teacher_Name) - charindex('_', a.Teacher_Name)), ' ', '_') SchoolForce__ID__c
	, '' [Mailing_Street]
	, '' [Mailing_City]
	, '' [Mailing_State]
	, '' [Mailing_Postal]
	, '' [Gender]
	, (SELECT [ID] FROM [sdw_stage_prod_17].[dbo].Account WHERE [Name] = 'Individuals') [Contact_Individual_AccountID]
	, '' OrgID
	, (SELECT [ID] FROM [sdw_stage_prod_17].[dbo].Account WHERE [Name] = 'Individuals') AccountID
	FROM Data_Services.dbo.Class (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Student (NOLOCK) b ON 
		a.Student_ID = b.Student_ID LEFT OUTER JOIN 
	SDW_Stage_PROD_17.dbo.Contact (NOLOCK) c ON 
		
		Replace(a.District + '_' + School_ID + '_' + SUBSTRING(a.Teacher_Name, 0, CHARINDEX(',', a.Teacher_Name)) + '_' + SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX('_', a.Teacher_Name)),' ','_') = c.ID__c
		--REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX('_', a.Teacher_Name)), ' ', '_') + '_' + SUBSTRING(a.Teacher_Name, 0, CHARINDEX(',', a.Teacher_Name)) = c.ID__c
	WHERE c.ID__c IS NULL AND 
	a.District = '1STLN' AND 
	b.District = '1STLN'
END


If @District = 'LRA'
BEGIN
INSERT INTO Data_Services.dbo.SF_Contact_Staff (RecordType
	,Salutation
	,Last_Name
	,First_Name 
	,Email
	,Mailing_Street
	,Mailing_City
	,Mailing_State
	,Mailing_Zip
	,Gender
	,Contact_Indv_Account_ID
	,OrgID
	,AccountID)
SELECT DISTINCT (SELECT [ID] FROM [SDW_Stage_PROD_17].[dbo].RecordType WHERE [Name] = 'staff') RecordType
	, '' Salutation
	, SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX(' ', a.Teacher_Name)) Last_Name 
	, SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)) First_Name
	, REPLACE(a.District + '_' + School_ID + '_' + SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX(' ', a.Teacher_Name)) + '_' + SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)), ' ', '_') SchoolForce__ID__c
	, '' [Mailing_Street]
	, '' [Mailing_City]
	, '' [Mailing_State]
	, '' [Mailing_Postal]
	, '' [Gender]
	, (SELECT [ID] FROM [sdw_stage_prod_17].[dbo].Account WHERE [Name] = 'Individuals') [Contact_Individual_AccountID]
	, '' OrgID
	, (SELECT [ID] FROM [sdw_stage_prod_17].[dbo].Account WHERE [Name] = 'Individuals') AccountID
	FROM Data_Services.dbo.Class (NOLOCK) a INNER JOIN 
	Data_Services.dbo.Student (NOLOCK) b ON 
		a.Student_ID = b.Student_ID LEFT OUTER JOIN 
	SDW_Stage_PROD_17.dbo.Contact (NOLOCK) c ON 
		Replace(a.District + '_' + School_ID + '_' + SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name) + 1, LEN(a.Teacher_Name) - CHARINDEX(' ', a.Teacher_Name)) + '_' + SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)),' ','_') = c.ID__c
	WHERE c.ID__c IS   NULL AND 
	a.District = 'LRA' AND 
	b.District = 'LRA'
END


IF @District = 'SJ'
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;
	insert into Data_Services.dbo.Class_Processed(Student_ID, Class_Section_ID, Class_Period_Name, Period, Teacher_Name, Teacher_First_Name, Teacher_Last_Name,District)
	select distinct a.Student_ID, a.Class_Section_ID, Period_Name, a.Period, a.Teacher_Name, substring(a.Teacher_Name, charindex(',', a.Teacher_Name) + 2, len(a.Teacher_Name) - charindex(',', a.Teacher_Name) - 1) First_Name,
	substring(a.Teacher_Name, 0, charindex(',', a.Teacher_Name)) Last_Name ,a.district
	from Data_Services.dbo.Class (nolock) a
	left outer join Data_Services.dbo.Class_Processed (nolock) b on 
	a.Student_ID = b.Student_ID and
	a.Class_Section_ID = b.Class_Section_ID and
	isnull(a.Period,'') = isnull(b.Period,'') and 
	a.Teacher_Name = b.Teacher_Name  
	where b.Student_ID is null and b.Class_Section_ID is null and b.Period is null and b.Teacher_Name is null
	and a.district= 'sj'

	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%MATH%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Algebra%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Geometry%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%English%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Language%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Lang Arts%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Reading%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Debate%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Journalism%'
	


	delete from  Data_Services.dbo.SF_Contact_Staff where email like 'sj%'
	-- truncate table Data_Services.dbo.Master_Contact_Staff

	-- SF_Contact_Staff
	INSERT INTO Data_Services.dbo.SF_Contact_Staff (RecordType
		,Salutation
		,Last_Name
		,First_Name 
		,Email
		,Mailing_Street
		,Mailing_City
		,Mailing_State
		,Mailing_Zip
		,Gender
		,Contact_Indv_Account_ID
		,OrgID, AccountID)
	select distinct 
	'012360000007jgMAAQ' RecordType,
	-- 012550000008VdFAAU (OLD ID)
	'' Salutation, 
	substring(Teacher_Name, 0, charindex(',', Teacher_Name)) Last_Name, 
	substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) First_Name,
	replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') SchoolForce__ID__c,
	'' [Mailing_Street],
	'' [Mailing_City],
	'' [Mailing_State],
	'' [Mailing_Postal],
	'' [Gender],
	'0013600000QJeqz' [Contact_Individual_AccountID],
	'' OrgID,
	'0013600000QJeqz' AccountID
	from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID
	left outer join sdw_stage_prod_17.dbo.Contact (nolock) c on replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = c.ID__c
	where c.ID__c is null
	and a.District = 'sj'and b.District = 'sj'
	
END
IF @District = 'MKE'
BEGIN


	update Data_Services.dbo.Class set  teacher_name = 'TBD' where teacher_name = '' and District = 'mke'


insert into Data_Services.dbo.Class_Processed(Student_ID, Class_Section_ID, Class_Period_Name, Period, Teacher_Name, Teacher_First_Name, Teacher_Last_Name,District)
	select distinct a.Student_ID, a.Class_Section_ID, Period_Name, a.Period, a.Teacher_Name, 
	LTRIM(RTRIM(SUBSTRING(a.Teacher_Name, 0, CHARINDEX(' ', a.Teacher_Name)))) As FirstName,
	LTRIM(RTRIM(SUBSTRING(a.Teacher_Name, CHARINDEX(' ', a.Teacher_Name)+1, 8000)))As LastName
	 ,a.district
	from Data_Services.dbo.Class (nolock) a
	left outer join Data_Services.dbo.Class_Processed (nolock) b on 
	a.Student_ID = b.Student_ID and
	a.Class_Section_ID = b.Class_Section_ID and
	isnull(a.Period,'') = isnull(b.Period,'') and 
	a.Teacher_Name = b.Teacher_Name  
	where b.Student_ID is null and b.Class_Section_ID is null and b.Period is null and b.Teacher_Name is null
	and a.district= 'mke'

	
	update Data_Services.dbo.Class set  teacher_name = 'TBD' where teacher_name = '' and District = 'mke'
	
	update Class_Processed set Teacher_Last_Name = Teacher_First_Name where Teacher_Last_Name = '' and District = 'mke'

	update Class_Processed set Teacher_Last_Name = 'TBD' where Teacher_Last_Name = '' AND  Teacher_First_Name = '' and District = 'mke'
	
	update Class set teacher_name = 'Kwiatkowski Kwiatkowski' where Teacher_Name = 'Kwiatkowski' and District = 'mke'

	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%MATH%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Algebra%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Geometry%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%English%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Language%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Lang Arts%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Reading%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Debate%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Journalism%'
	

	delete from  Data_Services.dbo.SF_Contact_Staff where email like 'mke%'
	-- truncate table Data_Services.dbo.Master_Contact_Staff

	-- SF_Contact_Staff
	INSERT INTO Data_Services.dbo.SF_Contact_Staff (RecordType
		,Salutation
		,Last_Name
		,First_Name 
		,Email
		,Mailing_Street
		,Mailing_City
		,Mailing_State
		,Mailing_Zip
		,Gender
		,Contact_Indv_Account_ID
		,OrgID, AccountID)
	select distinct 
	'012360000007jgMAAQ' RecordType,
	-- 012550000008VdFAAU (OLD ID)
	'' Salutation, 
	LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000))) Last_Name, 
	LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))) First_Name,
	replace(a.District + '_' + School_ID + '_' +LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000)))  + '_' + LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))), ' ', '_') SchoolForce__ID__c,
	'' [Mailing_Street],
	'' [Mailing_City],
	'' [Mailing_State],
	'' [Mailing_Postal],
	'' [Gender],
	'0013600000QJeqz' [Contact_Individual_AccountID],
	'' OrgID,
	'0013600000QJeqz' AccountID
		from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID and a.district = 'MKE'
	left outer join sdw_stage_prod_17.dbo.Contact (nolock) c on replace(a.District + '_' + School_ID + '_' +LTRIM(RTRIM(SUBSTRING(Teacher_Name, CHARINDEX(' ', Teacher_Name)+1, 8000)))  + '_' + LTRIM(RTRIM(SUBSTRING(Teacher_Name, 0, CHARINDEX(' ', Teacher_Name)))), ' ', '_') = c.ID__c
	where c.ID__c is null
	and a.District = 'mke'and b.District = 'mke'


	END
IF @District = 'CLM'
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;
	insert into Data_Services.dbo.Class_Processed(Student_ID, Class_Section_ID, Class_Period_Name, Period, Teacher_Name, Teacher_First_Name, Teacher_Last_Name,District)
	select distinct a.Student_ID, a.Class_Section_ID, Period_Name, a.Period, a.Teacher_Name, substring(a.Teacher_Name, charindex(',', a.Teacher_Name) + 2, len(a.Teacher_Name) - charindex(',', a.Teacher_Name) - 1) First_Name,
	substring(a.Teacher_Name, 0, charindex(',', a.Teacher_Name)) Last_Name ,a.district
	from Data_Services.dbo.Class (nolock) a
	left outer join Data_Services.dbo.Class_Processed (nolock) b on 
	a.Student_ID = b.Student_ID and
	a.Class_Section_ID = b.Class_Section_ID and
	isnull(a.Period,'') = isnull(b.Period,'') and 
	a.Teacher_Name = b.Teacher_Name  
	where b.Student_ID is null and b.Class_Section_ID is null and b.Period is null and b.Teacher_Name is null
	and a.district= 'CLM'

	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%MATH%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Algebra%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'Math' where Class_Period_Name like '%Geometry%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%English%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Language%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Lang Arts%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Reading%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Debate%'
	update Data_Services.dbo.Class_Processed set Section_Type = 'ELA/Literacy' where Class_Period_Name like '%Journalism%'
	


	delete from  Data_Services.dbo.SF_Contact_Staff where email like 'CLM%'
	-- truncate table Data_Services.dbo.Master_Contact_Staff

	-- SF_Contact_Staff
	INSERT INTO Data_Services.dbo.SF_Contact_Staff (RecordType
		,Salutation
		,Last_Name
		,First_Name 
		,Email
		,Mailing_Street
		,Mailing_City
		,Mailing_State
		,Mailing_Zip
		,Gender
		,Contact_Indv_Account_ID
		,OrgID, AccountID)
	select distinct 
	'012360000007jgMAAQ' RecordType,
	-- 012550000008VdFAAU (OLD ID)
	'' Salutation, 
	substring(Teacher_Name, 0, charindex(',', Teacher_Name)) Last_Name, 
	substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) First_Name,
	replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') SchoolForce__ID__c,
	'' [Mailing_Street],
	'' [Mailing_City],
	'' [Mailing_State],
	'' [Mailing_Postal],
	'' [Gender],
	'0013600000QJeqz' [Contact_Individual_AccountID],
	'' OrgID,
	'0013600000QJeqz' AccountID
	from Data_Services.dbo.Class (nolock) a
	inner join Data_Services.dbo.Student (nolock) b on a.Student_ID = b.Student_ID and a.district = 'CLM'
	left outer join sdw_stage_prod_17.dbo.Contact (nolock) c on  c.id__c like '%CLM%' and replace(a.District + '_' + School_ID + '_' + substring(Teacher_Name, charindex(',', Teacher_Name) + 2, len(Teacher_Name) - charindex(',', Teacher_Name) - 1) + '_' + substring(Teacher_Name, 0, charindex(',', Teacher_Name)), ' ', '_') = c.ID__c
	where c.ID__c is null
	and a.District = 'CLM'and b.District = 'CLM'
	
END

END



GO
