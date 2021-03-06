USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_12_Algebra]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_12_Algebra] 
--@District varchar(255) = 'Standard'
AS
BEGIN

	delete from Data_Services.dbo.SF_Assessment_Algebra
	-- select count(*) from Assessments (nolock) where Assessment_Name in ('FSA-EOC ALGEBRA 1 (Year One)','BENCHMARKS FSA EOC ALGEBRA 1','EOC - ALGEBRA')

	select 
	b.SF_ID Student_ID, 
	(select [Value] from [Data_Services].[dbo].[Settings] where [Name] = 'Algebra.Type') SchoolForce__Type__c,
	'Florida State Assessment Algebra 1' SchoolForce__Assessment_Name__c,
	cast(a.Date as date) [Date_Administered__c],
	Scale_Score FSA_Algebra_Score_c,
	isnull(Profiency_Rating_Level, 'N/A') Local_Benchmark__c
	,b.District + '_' + cast(cast(b.School_ID as integer) as varchar(4)) + '_' + b.Student_ID + '_' [SchoolForce__External_Id__c]
	,a.Assessment_Name
	,a.Student_ID Source_Student_ID
	into #Algebra
	from Data_Services.dbo.Assessments (nolock) a
	inner join Data_Services.dbo.Master_Student (Nolock) b on a.Student_ID = b.Student_ID
	inner join SDW_Prod.dbo.DimDate(nolock) D on cast(A.Date as date) = D.Date
	where a.Assessment_Name in ('FSA-EOC ALGEBRA 1 (Year One)','BENCHMARKS FSA EOC ALGEBRA 1','EOC - ALGEBRA','BENCHMARKS FSA EOC ALGEBRA 1') 
	and Scale_Score is not null and convert(varchar(1), A.Date,1) >= '1-JAN-15'
--	and e.Source_Student_ID is null 
--	and e.Assessment_Name is null 
--	and cast(e.Date_Administered__c as date) is null 
--	and e.FSA_Algebra_Score_c is null 
--	and e.Local_Benchmark__c is null
	-- 54

	insert into Data_Services.dbo.SF_Assessment_Algebra(Student_ID, SchoolForce__Type__c, SchoolForce__Assessment_Name__c, Date_Administered__c, FSA_Algebra_Score_c, Local_Benchmark__c, [SchoolForce__External_Id__c], Assessment_Name, Source_Student_ID)
	select a.Student_ID, a.SchoolForce__Type__c, a.SchoolForce__Assessment_Name__c, a.[Date_Administered__c], a.FSA_Algebra_Score_c, a.Local_Benchmark__c, a.[SchoolForce__External_Id__c], a.Assessment_Name, a.Source_Student_ID
	from #Algebra (nolock) a 
	left outer join Data_Services.dbo.Master_Assessment_Algebra (nolock) e 
	on a.Student_ID = e.Student_ID and a.SchoolForce__Type__c = e.SchoolForce__Type__c and a.SchoolForce__Assessment_Name__c = e.SchoolForce__Assessment_Name__c and cast(a.Date_Administered__c as date) = cast(e.Date_Administered__c as date) 
	where e.Source_Student_ID is null 
	and e.Assessment_Name is null 
	and cast(e.Date_Administered__c as date) is null 
	and e.FSA_Algebra_Score_c is null 
	and e.Local_Benchmark__c is null

	update Data_Services.dbo.SF_Assessment_Algebra set [SchoolForce__External_Id__c] = [SchoolForce__External_Id__c] + cast(ID as varchar(5))

END


GO
