USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_Missing_Student]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Missing_Student]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select distinct Student_ID, count(*) [Count]
	into #Student
	from
	(select Student_ID, substring(Class_Section_ID, 1, 4) School, count(*) Count
	from Data_Services.dbo.Class_Processed (nolock) a 
	group by Student_ID, substring(Class_Section_ID, 1, 4)
	) a
	group by Student_ID
	having count(*) > 1

	select Student_ID, substring(Class_Section_ID, 1, 4) School, count(*) Count
	into #SS
	from Data_Services.dbo.Class_Processed (nolock) a 
	group by Student_ID, substring(Class_Section_ID, 1, 4)

	select a.Student_ID, b.School School_ID 
	into #SS2
	from #Student a
	inner join #SS b on a.Student_ID = b.Student_ID
	order by a.Student_ID

	select a.* 
	into #Missing_SS
	from #SS2 a
	left outer join Student b on a.Student_ID = b.Student_ID and a.School_ID = b.School_ID
	where b.Student_ID is null and b.School_ID is null
	order by Student_ID

	select distinct School_ID, School_Name
	into #School 
	from Student

	select a.Student_ID, School_Year, First_Name, Last_Name, Grade, Date_Of_Birth, Sex, Ethnicity, Disability_Flag, ELL_Flag, Home_Language, Address_Line_1, Address_Line_2, City, State, Zip, Home_Phone, Race, District, RunDate
	into #Missing_Student_Info
	from Student (nolock) a
	inner join #Missing_SS (nolock) b on a.Student_ID = b.Student_ID

	insert into Data_Services.dbo.Student(Student_ID, School_ID, School_Name, School_Year, First_Name, Last_Name, Grade, Date_Of_Birth, Sex, Ethnicity, Disability_Flag, ELL_Flag, Home_Language, Address_Line_1, Address_Line_2, City, State, Zip, Home_Phone, Race, District, RunDate)
	select distinct a.Student_ID, a.School_ID, School_Name, School_Year, First_Name, Last_Name, Grade, Date_Of_Birth, Sex, Ethnicity, Disability_Flag, ELL_Flag, Home_Language, Address_Line_1, Address_Line_2, City, State, Zip, Home_Phone, Race, District, RunDate
	from #Missing_SS (nolock) a
	inner join #School (nolock) b on a.School_ID = b.School_ID
	inner join #Missing_Student_Info (nolock) c on a.Student_ID = c.Student_ID
	order by a.Student_ID, a.School_ID

END

GO
