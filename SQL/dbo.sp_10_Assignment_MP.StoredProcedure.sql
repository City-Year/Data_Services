USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_10_Assignment_MP]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_10_Assignment_MP] @District varchar(255) = 'Standard'
AS
BEGIN

		delete from Data_Services.dbo.SF_Assignment_MP

--	insert into Data_Services.dbo.SF_Assignment_MP(Name, Assignment_Library__c, SchoolForce__Due_Date__c, SchoolForce__Picklist_Value__c, 
--	SchoolForce__Include_in_Final_Grade__c, 
--	SchoolForce__Name_in_Gradebook__c, 
--	SchoolForce__Possible_Points__c, 
--	SchoolForce__Time__c, 
--	SchoolForce__Section__c, 
--	SchoolForce__Weighting_Value__c)

	if @District = 'OCPS'
	BEGIN

	delete from Data_Services.dbo.SF_Assignment_MP

	select  
	'Reporting Period Course Grade' Name, 
	k.ID Assignment_Library__c,
	End_Date__c [SchoolForce__Due_Date__c],
	(select [Value] from [Data_Services].[dbo].[Settings] where [Name] = 'Assignment_MP.Picklist_Value') [SchoolForce__Picklist_Value__c], 
	1 [SchoolForce__Include_in_Final_Grade__c], 
	k.Marking_Period_2 [SchoolForce__Name_in_Gradebook__c],
	100 [SchoolForce__Possible_Points__c],
	j.ID [SchoolForce__Time__c], 
	f.SF_ID [SchoolForce__Section__c], 
	1 [SchoolForce__Weighting_Value__c]
	into #Temp
	from Data_Services.dbo.MP_Grades (nolock) a
	inner join Data_Services.dbo.Class_Processed (nolock) d on a.Class_Section_ID = d.Class_Section_ID and a.Student_ID = d.Student_ID
	inner join Data_Services.dbo.Master_Student (nolock) g on d.Student_ID = g.Student_ID and substring(a.Class_Section_ID, 1, 4) = g.School_ID
	inner join Data_Services.dbo.Master_Section (nolock) f on a.Class_Section_ID = f.Class_Section_ID and substring(a.Class_Section_ID, 1, 4) = f.Source_School_ID
	inner join Data_Services.dbo.School_Lookup (nolock) h on g.SchoolForce__Setup__C = h.Setup_14_15
	inner join SDW_Stage_Prod.dbo.Setup__c (nolock) i on h.Account_ID = i.[School__c]
	inner join SDW_Stage_Prod.dbo.Time_Element__c (nolock) j on i.[Term__c] = j.[Parent_Time_Element__c]
	inner join Data_Services.dbo.vw_Master_Assignment_Library_MP (nolock) k on a.Marking_Period = k.Marking_Period_3 and f.Section_Type = k.Section_Type_2
	where a.Marking_Period is not null 
	and year(Year_End__c) = 2016
	and REPLACE(j.Name__c,'Quarter ','RC') = a.Marking_Period 
	and f.SF_ID is not null 
	and a.DIstrict = @District
	-- 1,312
	
	insert into Data_Services.dbo.SF_Assignment_MP(Name, Assignment_Library__c, SchoolForce__Due_Date__c, SchoolForce__Picklist_Value__c, SchoolForce__Include_in_Final_Grade__c, SchoolForce__Name_in_Gradebook__c, SchoolForce__Possible_Points__c, SchoolForce__Time__c, SchoolForce__Section__c, SchoolForce__Weighting_Value__c)
	select distinct a.Name, a.Assignment_Library__c, a.SchoolForce__Due_Date__c, a.SchoolForce__Picklist_Value__c, a.SchoolForce__Include_in_Final_Grade__c, a.SchoolForce__Name_in_Gradebook__c, a.SchoolForce__Possible_Points__c, a.SchoolForce__Time__c, a.SchoolForce__Section__c, a.SchoolForce__Weighting_Value__c
	from #Temp (nolock) a
	left outer join Data_Services.dbo.Master_Assignment_MP (nolock) b on
	a.Name = b.Name 
	and a.Assignment_Library__c = b.Assignment_Library__c
	and a.SchoolForce__Due_Date__c = b.SchoolForce__Due_Date__c
	and a.SchoolForce__Picklist_Value__c = b.SchoolForce__Picklist_Value__c
	and a.SchoolForce__Include_in_Final_Grade__c = b.SchoolForce__Include_in_Final_Grade__c 
	and a.SchoolForce__Name_in_Gradebook__c = b.SchoolForce__Name_in_Gradebook__c
	and a.SchoolForce__Possible_Points__c = b.SchoolForce__Possible_Points__c
	and a.SchoolForce__Time__c = b.SchoolForce__Time__c
	and a.SchoolForce__Section__c = b.SchoolForce__Section__c
	and a.SchoolForce__Weighting_Value__c = b.SchoolForce__Weighting_Value__c
	where b.Name is null and b.Assignment_Library__c is null and b.SchoolForce__Due_Date__c is null and b.SchoolForce__Picklist_Value__c is null
	and b.SchoolForce__Include_in_Final_Grade__c is null and b.SchoolForce__Name_in_Gradebook__c is null and b.SchoolForce__Possible_Points__c is null 
	and b.SchoolForce__Time__c is null and b.SchoolForce__Section__c is null and b.SchoolForce__Weighting_Value__c is null

	update Data_Services.dbo.SF_Assignment_MP set [SchoolForce__External_Id__c] = 'OCPS_MP_' + cast(ID as varchar(10))
	END

IF @District = 'KCPS'
	BEGIN

	DELETE FROM Data_Services.dbo.SF_Assignment_MP
	WHERE SchoolForce__External_Id__c like @District+'_MP_%' 

	Update [Data_Services].[dbo].[MP_Grades]
  Set Marking_Period = Replace(Marking_Period, 'Term-', 'Q')
  where district = 'kcps'

	SELECT distinct 'Reporting Period Course Grade' Name
		, k.ID Assignment_Library__c
		, End_Date__c [SchoolForce__Due_Date__c]
		,'a1h36000000yQ4CAAU' [SchoolForce__Picklist_Value__c]
		, 1 [SchoolForce__Include_in_Final_Grade__c]
		, k.Marking_Period_2 [SchoolForce__Name_in_Gradebook__c]
		, '0' [SchoolForce__Possible_Points__c]
		, j.ID [SchoolForce__Time__c]
		, f.SF_ID [SchoolForce__Section__c]
		, 1 [SchoolForce__Weighting_Value__c]
	INTO #Temp0
	FROM Data_Services.dbo.MP_Grades (nolock) a 
	INNER JOIN Data_Services.dbo.Class_Processed (nolock) d ON a.Class_Section_ID = d.Class_Section_ID and a.Student_ID = d.Student_ID 
	INNER JOIN Data_Services.dbo.Master_Student (nolock) g ON d.Student_ID = g.Student_ID 
	inner join Data_Services.dbo.Master_Section (nolock) f ON a.Class_Section_ID = f.Class_Section_ID 
	INNER JOIN Data_Services.dbo.School_Lookup_16_17 (nolock) h ON g.SchoolForce__Setup__C = h.Setup_14_15 
	INNER JOIN SDW_Stage_Prod_17.dbo.Setup__c (nolock) i ON h.Account_ID = i.[School__c] 
	INNER JOIN SDW_Stage_Prod_17.dbo.Time_Element__c (nolock) j ON i.[Term__c] = j.[Parent_Time_Element__c] 
	INNER JOIN Data_Services.dbo.vw_Master_Assignment_Library_MP_17 (nolock) k ON a.Marking_Period = k.Marking_Period_2 AND f.Section_Type = k.Section_Type_2
	WHERE a.Marking_Period IS NOT NULL AND year(Year_End__c) = 2017 AND REPLACE(j.Name__c,'Quarter ','Q') = a.Marking_Period AND f.SF_ID IS NOT NULL and a.district = 'kcps'

		
	INSERT INTO Data_Services.dbo.SF_Assignment_MP(Name
		, Assignment_Library__c
		, SchoolForce__Due_Date__c
		, SchoolForce__Picklist_Value__c
		, SchoolForce__Include_in_Final_Grade__c
		, SchoolForce__Name_in_Gradebook__c
		, SchoolForce__Possible_Points__c
		, SchoolForce__Time__c, SchoolForce__Section__c
		, SchoolForce__Weighting_Value__c)
	SELECT DISTINCT a.Name
		, a.Assignment_Library__c
		, a.SchoolForce__Due_Date__c
		, a.SchoolForce__Picklist_Value__c
		, a.SchoolForce__Include_in_Final_Grade__c
		, a.SchoolForce__Name_in_Gradebook__c
		, a.SchoolForce__Possible_Points__c
		, a.SchoolForce__Time__c
		, a.SchoolForce__Section__c
		, a.SchoolForce__Weighting_Value__c
	FROM #Temp0 (nolock) a 
	LEFT OUTER JOIN 
	Data_Services.dbo.Master_Assignment_MP (nolock) b ON
		a.Name = b.Name AND 
		a.Assignment_Library__c = b.Assignment_Library__c AND
		a.SchoolForce__Due_Date__c = b.SchoolForce__Due_Date__c AND
		a.SchoolForce__Picklist_Value__c = b.SchoolForce__Picklist_Value__c AND
		a.SchoolForce__Include_in_Final_Grade__c = b.SchoolForce__Include_in_Final_Grade__c AND
		a.SchoolForce__Name_in_Gradebook__c = b.SchoolForce__Name_in_Gradebook__c AND
		a.SchoolForce__Possible_Points__c = b.SchoolForce__Possible_Points__c AND
		a.SchoolForce__Time__c = b.SchoolForce__Time__c AND
		a.SchoolForce__Section__c = b.SchoolForce__Section__c AND
		a.SchoolForce__Weighting_Value__c = b.SchoolForce__Weighting_Value__c
	WHERE b.Name IS NULL AND 
		b.Assignment_Library__c IS NULL AND 
		b.SchoolForce__Due_Date__c IS NULL AND 
		b.SchoolForce__Picklist_Value__c IS NULL AND
		b.SchoolForce__Include_in_Final_Grade__c IS NULL AND 
		b.SchoolForce__Name_in_Gradebook__c IS NULL AND 
		b.SchoolForce__Possible_Points__c IS NULL AND
		b.SchoolForce__Time__c IS NULL AND
		b.SchoolForce__Section__c IS NULL AND b.SchoolForce__Weighting_Value__c IS NULL

	UPDATE Data_Services.dbo.SF_Assignment_MP SET [SchoolForce__External_Id__c] = @District+'_MP_' + cast(ID as varchar(10))
	WHERE [SchoolForce__Section__c] in (SELECT SF_ID FROM Master_Section WHERE SF_Section_External_ID like @District+'%')

	END
IF @District='SJ'
BEGIN

delete from Data_Services.dbo.SF_Assignment_MP
        where SchoolForce__External_Id__c like 'SJ_MP_%' 

	select  
	'Reporting Period Course Grade' Name, 
	k.ID Assignment_Library__c,
	End_Date__c [SchoolForce__Due_Date__c],
	(select ID from sdw_stage_prod_17.[dbo].Picklist_Value__c where [Name] = 'A+ to F') [SchoolForce__Picklist_Value__c], 
	1 [SchoolForce__Include_in_Final_Grade__c], 
	REPLACE(k.Marking_Period_2,'Trimester ','T') [SchoolForce__Name_in_Gradebook__c],
	100 [SchoolForce__Possible_Points__c],
	j.ID [SchoolForce__Time__c], 
	f.SF_ID [SchoolForce__Section__c], 
	1 [SchoolForce__Weighting_Value__c]
	into #Temp1
	from Data_Services.dbo.MP_Grades (nolock) a
	inner join Data_Services.dbo.Class_Processed (nolock) d on a.Class_Section_ID = d.Class_Section_ID and a.Student_ID = d.Student_ID and a.District = 'sj'
	inner join Data_Services.dbo.Master_Student (nolock) g on d.Student_ID = g.Student_ID --and substring(a.Class_Section_ID, 1, 4) = g.School_ID
	inner join Data_Services.dbo.Master_Section (nolock) f on a.Class_Section_ID = f.Class_Section_ID and f.source_school_id = g.school_id--and substring(a.Class_Section_ID, 1, 4) = f.Source_School_ID
	inner join Data_Services.dbo.School_Lookup_16_17 (nolock) h on g.SchoolForce__Setup__C = h.Setup_14_15 and h.Source_School_ID = g.School_ID
	inner join sdw_stage_prod_17.dbo.Setup__c (nolock) i on h.Account_ID = i.[School__c]
	inner join sdw_stage_prod_17.dbo.Time_Element__c (nolock) j on i.[Term__c] = j.[Parent_Time_Element__c]
	inner join Data_Services.dbo.vw_Master_Assignment_Library_MP_17 (nolock) k on
	 (a.Marking_Period = k.Marking_Period_3 and f.Section_Type = k.Section_Type_2) or 
	 (a.Marking_Period = k.Marking_Period_2 and f.Section_Type = k.Section_Type_2)
	where a.Marking_Period is not null 
	and year(Year_End__c) = 2017
	and (REPLACE(j.Name__c,'Trimester ','T') = a.Marking_Period OR REPLACE(j.Name__c,'Quarter ','Q') = a.Marking_Period or  REPLACE(j.Name__c,'Semester ','S') = a.Marking_Period)
	and f.SF_ID is not null  AND d.District = 'SJ'
	

insert into Data_Services.dbo.SF_Assignment_MP(Name, Assignment_Library__c, SchoolForce__Due_Date__c, SchoolForce__Picklist_Value__c, SchoolForce__Include_in_Final_Grade__c, SchoolForce__Name_in_Gradebook__c, SchoolForce__Possible_Points__c, SchoolForce__Time__c, SchoolForce__Section__c, SchoolForce__Weighting_Value__c)
	select distinct a.Name, a.Assignment_Library__c, a.SchoolForce__Due_Date__c, a.SchoolForce__Picklist_Value__c, a.SchoolForce__Include_in_Final_Grade__c, a.SchoolForce__Name_in_Gradebook__c, a.SchoolForce__Possible_Points__c, a.SchoolForce__Time__c, a.SchoolForce__Section__c, a.SchoolForce__Weighting_Value__c
	from #Temp1 (nolock) a
	left outer join Data_Services.dbo.Master_Assignment_MP (nolock) b on
	a.Name = b.Name 
	and a.Assignment_Library__c = b.Assignment_Library__c
	and a.SchoolForce__Due_Date__c = b.SchoolForce__Due_Date__c
	and a.SchoolForce__Picklist_Value__c = b.SchoolForce__Picklist_Value__c
	and a.SchoolForce__Include_in_Final_Grade__c = b.SchoolForce__Include_in_Final_Grade__c 
	and a.SchoolForce__Name_in_Gradebook__c = b.SchoolForce__Name_in_Gradebook__c
	and a.SchoolForce__Possible_Points__c = b.SchoolForce__Possible_Points__c
	and a.SchoolForce__Time__c = b.SchoolForce__Time__c
	and a.SchoolForce__Section__c = b.SchoolForce__Section__c
	and a.SchoolForce__Weighting_Value__c = b.SchoolForce__Weighting_Value__c
	where b.Name is null and b.Assignment_Library__c is null and b.SchoolForce__Due_Date__c is null and b.SchoolForce__Picklist_Value__c is null
	and b.SchoolForce__Include_in_Final_Grade__c is null and b.SchoolForce__Name_in_Gradebook__c is null and b.SchoolForce__Possible_Points__c is null 
	and b.SchoolForce__Time__c is null and b.SchoolForce__Section__c is null and b.SchoolForce__Weighting_Value__c is null

	update Data_Services.dbo.SF_Assignment_MP set [SchoolForce__External_Id__c] = 'SJ_MP_' + cast(ID as varchar(10)) 
where [SchoolForce__Section__c] in (select SF_ID from Master_Section where SF_Section_External_ID like 'SJ%')


END
IF @District = 'LRA'
	BEGIN
	DELETE FROM Data_Services.dbo.SF_Assignment_MP
	WHERE SchoolForce__External_Id__c like @District+'_MP_%'
	
	SELECT  'Reporting Period Course Grade' Name
		, k.ID Assignment_Library__c
		, End_Date__c [SchoolForce__Due_Date__c]
		, (select ID from sdw_stage_prod_17.[dbo].Picklist_Value__c where [Name] = 'A+ to F') [SchoolForce__Picklist_Value__c] 
		, 1 [SchoolForce__Include_in_Final_Grade__c]
		, k.Marking_Period_2 [SchoolForce__Name_in_Gradebook__c]
		, 100 [SchoolForce__Possible_Points__c]
		, j.ID [SchoolForce__Time__c]
		, f.SF_ID [SchoolForce__Section__c]
		, 1 [SchoolForce__Weighting_Value__c]
	INTO #Temp2
	FROM Data_Services.dbo.MP_Grades (nolock) a INNER JOIN 
	Data_Services.dbo.Class_Processed (nolock) d ON 
		a.Class_Section_ID = d.Class_Section_ID and a.Student_ID = d.Student_ID INNER JOIN 
	Data_Services.dbo.Master_Student (nolock) g ON 
		d.Student_ID = g.Student_ID inner join --and substring(a.Class_Section_ID, 1, 4) = g.School_ID  
	Data_Services.dbo.Master_Section (nolock) f ON 
		a.Class_Section_ID = f.Class_Section_ID INNER JOIN --and substring(a.Class_Section_ID, 1, 4) = f.Source_School_ID
	Data_Services.dbo.School_Lookup_16_17 (nolock) h ON 
		g.SchoolForce__Setup__C = h.Setup_14_15 INNER JOIN 
	SDW_STAGE_PROD_17.dbo.Setup__c (nolock) i ON 
		h.Account_ID = i.[School__c] INNER JOIN
	SDW_STAGE_PROD_17.dbo.Time_Element__c (nolock) j ON 
		i.[Term__c] = j.[Parent_Time_Element__c] INNER JOIN
	Data_Services.dbo.vw_Master_Assignment_Library_MP_17 (nolock) k ON 
		a.Marking_Period = k.Marking_Period_3 AND 
		f.Section_Type = k.Section_Type_2 INNER JOIN 
	SDW_STAGE_PROD_17.dbo.Student__c l ON g.SF_ID = l.ID 
	WHERE  a.Marking_Period IS NOT NULL AND 
		year(Year_End__c) = 2017 AND 
		(REPLACE(j.Name__c,'Quarter ','') = a.Marking_Period) AND 
		f.SF_ID IS NOT NULL AND 
		a.District = @District

	INSERT INTO Data_Services.dbo.SF_Assignment_MP(Name
		, Assignment_Library__c
		, SchoolForce__Due_Date__c
		, SchoolForce__Picklist_Value__c
		, SchoolForce__Include_in_Final_Grade__c
		, SchoolForce__Name_in_Gradebook__c
		, SchoolForce__Possible_Points__c
		, SchoolForce__Time__c, SchoolForce__Section__c
		, SchoolForce__Weighting_Value__c)
	
	SELECT DISTINCT a.Name
		, a.Assignment_Library__c
		, a.SchoolForce__Due_Date__c
		, a.SchoolForce__Picklist_Value__c
		, a.SchoolForce__Include_in_Final_Grade__c
		, a.SchoolForce__Name_in_Gradebook__c
		, a.SchoolForce__Possible_Points__c
		, a.SchoolForce__Time__c
		, a.SchoolForce__Section__c
		, a.SchoolForce__Weighting_Value__c
	FROM #Temp2 (nolock) a LEFT OUTER JOIN 
	Data_Services.dbo.Master_Assignment_MP (nolock) b ON
		a.Name = b.Name AND 
		a.Assignment_Library__c = b.Assignment_Library__c AND
		a.SchoolForce__Due_Date__c = b.SchoolForce__Due_Date__c AND
		a.SchoolForce__Picklist_Value__c = b.SchoolForce__Picklist_Value__c AND
		a.SchoolForce__Include_in_Final_Grade__c = b.SchoolForce__Include_in_Final_Grade__c AND
		a.SchoolForce__Name_in_Gradebook__c = b.SchoolForce__Name_in_Gradebook__c AND
		a.SchoolForce__Possible_Points__c = b.SchoolForce__Possible_Points__c AND
		a.SchoolForce__Time__c = b.SchoolForce__Time__c AND
		a.SchoolForce__Section__c = b.SchoolForce__Section__c AND
		a.SchoolForce__Weighting_Value__c = b.SchoolForce__Weighting_Value__c
	WHERE b.Name IS NULL AND 
		b.Assignment_Library__c IS NULL AND 
		b.SchoolForce__Due_Date__c IS NULL AND 
		b.SchoolForce__Picklist_Value__c IS NULL AND
		b.SchoolForce__Include_in_Final_Grade__c IS NULL AND 
		b.SchoolForce__Name_in_Gradebook__c IS NULL AND 
		b.SchoolForce__Possible_Points__c IS NULL AND
		b.SchoolForce__Time__c IS NULL AND
		b.SchoolForce__Section__c IS NULL AND b.SchoolForce__Weighting_Value__c IS NULL

	UPDATE Data_Services.dbo.SF_Assignment_MP SET [SchoolForce__External_Id__c] = @District+'_MP_' + cast(ID as varchar(10)) 
	WHERE [SchoolForce__Section__c] in (SELECT SF_ID FROM Master_Section WHERE SF_Section_External_ID like @District+'%')
END
END


GO
