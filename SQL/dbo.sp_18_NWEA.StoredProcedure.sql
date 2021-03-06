USE [Data_Services]
GO
/****** Object:  StoredProcedure [dbo].[sp_18_NWEA]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_18_NWEA]
AS
BEGIN

DELETE FROM Data_Services.dbo.SF_Assessments_NWEA
	-- select count(*) from Assessments (nolock) where Assessment_Name in ('FSA-EOC ALGEBRA 1 (Year One)','BENCHMARKS FSA EOC ALGEBRA 1','EOC - ALGEBRA')
SELECT B.SF_ID Student_ID
	-- Set a default assessment type to NULL as a test
	, '' SchoolForce__Type__c
	-- Date 
	, CAST(A.TestStartDate__c as date) [Date_Administered__c]
	-- put the assessment fields in
	, [TestDurationMinutes__c]
    , [TestRITScore__c]
    , [TestPercentile__c]
    , [FallToFallProjectedGrowth__c]
    , [FalltoFallObservedGrowth__c]
    , [FallToFallConditionalGrowthIndex__c]
    , [FallToFallConditionalGrowthPercentile__c]
    , [FallToWinterProjectedGrowth__c]
    , [FalltoWinterObservedGrowth__c]
    , [FallToWinterConditionalGrowthIndex__c]
    , [FallToWinterConditionalGrowthPercentile__c]
    , [FallToSpringProjectedGrowth__c]
    , [FalltoSpringObservedGrowth__c]
    , [FallToSpringConditionalGrowthIndex__c]
    , [FallToSpringConditionalGrowthPercentile__c]
    , [WinterToWinterProjectedGrowth__c]
    , [WinterToWinterObservedGrowth__c]
    , [WinterToWinterConditionalGrowthIndex__c]
    , [WinterToWinterConditionalGrowthPercentil__c]
    , [WinterToSpringProjectedGrowth__c]
    , [WinterToSpringObservedGrowth__c]
    , [WinterToSpringConditionalGrowthIndex__c]
    , [WinterToSpringConditionalGrowthPercentil__c]
    , [SpringToSpringProjectedGrowth__c]
    , [SpringToSpringObservedGrowth__c]
    , [SpringToSpringConditionalGrowthIndex__c]
    , [SpringToSpringConditionalGrowthPercentil__c]
	, B.District + '_' + CAST(CAST(B.School_ID AS INTEGER) AS VARCHAR(4)) + '_' + B.Student_ID + '_' [SchoolForce__External_Id__c]
	, TestName
	, A.TestName SchoolForce__Assessment_Name__c
	, Source_StudentID
INTO #Assessments_NWEA
FROM Data_Services.dbo.Assessments_NWEA (NOLOCK) A INNER JOIN 
Data_Services.dbo.Master_Student (NOLOCK) B ON 
	A.Source_StudentID = B.Student_ID INNER JOIN
SDW_PROD.dbo.DimDate(NOLOCK) D ON 
	CAST(A.TestStartDate__c AS DATE) = D.Date
WHERE a.TestName in (SELECT DISTINCT [TestName]
FROM [Data_Services].[dbo].[Assessments_NWEA])

INSERT INTO Data_Services.dbo.SF_Assessments_NWEA(Student_ID
	, SchoolForce__Type__c
	, SchoolForce__Assessment_Name__c
	, Date_Administered__c
-- START Assessment fields
	, [TestDurationMinutes__c]
    , [TestRITScore__c]
    , [TestPercentile__c]
    , [FallToFallProjectedGrowth__c]
    , [FalltoFallObservedGrowth__c]
    , [FallToFallConditionalGrowthIndex__c]
    , [FallToFallConditionalGrowthPercentile__c]
    , [FallToWinterProjectedGrowth__c]
    , [FalltoWinterObservedGrowth__c]
    , [FallToWinterConditionalGrowthIndex__c]
    , [FallToWinterConditionalGrowthPercentile__c]
    , [FallToSpringProjectedGrowth__c]
    , [FalltoSpringObservedGrowth__c]
    , [FallToSpringConditionalGrowthIndex__c]
    , [FallToSpringConditionalGrowthPercentile__c]
    , [WinterToWinterProjectedGrowth__c]
    , [WinterToWinterObservedGrowth__c]
    , [WinterToWinterConditionalGrowthIndex__c]
    , [WinterToWinterConditionalGrowthPercentil__c]
    , [WinterToSpringProjectedGrowth__c]
    , [WinterToSpringObservedGrowth__c]
    , [WinterToSpringConditionalGrowthIndex__c]
    , [WinterToSpringConditionalGrowthPercentil__c]
    , [SpringToSpringProjectedGrowth__c]
    , [SpringToSpringObservedGrowth__c]
    , [SpringToSpringConditionalGrowthIndex__c]
    , [SpringToSpringConditionalGrowthPercentil__c]
--END Ass3ssment Fields	
	, [Assessment_Name]
	, [SchoolForce__External_Id__c]
	, [Source_Student_ID])

SELECT A.Student_ID
	, A.SchoolForce__Type__c
	, A.SchoolForce__Assessment_Name__c
	, A.[Date_Administered__c]
	--Start Assessment fields
	, A.[TestDurationMinutes__c]
    , A.[TestRITScore__c]
    , A.[TestPercentile__c]
    , A.[FallToFallProjectedGrowth__c]
    , A.[FalltoFallObservedGrowth__c]
    , A.[FallToFallConditionalGrowthIndex__c]
    , A.[FallToFallConditionalGrowthPercentile__c]
    , A.[FallToWinterProjectedGrowth__c]
    , A.[FalltoWinterObservedGrowth__c]
    , A.[FallToWinterConditionalGrowthIndex__c]
    , A.[FallToWinterConditionalGrowthPercentile__c]
    , A.[FallToSpringProjectedGrowth__c]
    , A.[FalltoSpringObservedGrowth__c]
    , A.[FallToSpringConditionalGrowthIndex__c]
    , A.[FallToSpringConditionalGrowthPercentile__c]
    , A.[WinterToWinterProjectedGrowth__c]
    , A.[WinterToWinterObservedGrowth__c]
    , A.[WinterToWinterConditionalGrowthIndex__c]
    , A.[WinterToWinterConditionalGrowthPercentil__c]
    , A.[WinterToSpringProjectedGrowth__c]
    , A.[WinterToSpringObservedGrowth__c]
    , A.[WinterToSpringConditionalGrowthIndex__c]
    , A.[WinterToSpringConditionalGrowthPercentil__c]
    , A.[SpringToSpringProjectedGrowth__c]
    , A.[SpringToSpringObservedGrowth__c]
    , A.[SpringToSpringConditionalGrowthIndex__c]
    , A.[SpringToSpringConditionalGrowthPercentil__c]
    --End Assessment fields
	, A.[TestName]
	, A.[SchoolForce__External_Id__c]
	, A.Source_StudentID
FROM #Assessments_NWEA (NOLOCK) A LEFT OUTER JOIN
Data_Services.dbo.Master_Assessment_NWEA (NOLOCK) E ON 
	A.Student_ID = E.Student_ID AND 
	A.SchoolForce__Type__c = E.SchoolForce__Type__c AND 
	A.SchoolForce__Assessment_Name__c = E.SchoolForce__Assessment_Name__c AND 
	cast(A.Date_Administered__c as date) = cast(E.Date_Administered__c as date) 
WHERE E.Source_Student_ID IS NULL AND 
	E.Assessment_Name IS NULL AND 
	cast(e.Date_Administered__c as date) IS NULL AND
	E.[TestDurationMinutes__c] IS NULL AND
    E.[TestRITScore__c] IS NULL AND
    E.[TestPercentile__c] IS NULL AND
    E.[FallToFallProjectedGrowth__c] IS NULL AND
    E.[FalltoFallObservedGrowth__c] IS NULL AND
    E.[FallToFallConditionalGrowthIndex__c] IS NULL AND
    E.[FallToFallConditionalGrowthPercentile__c] IS NULL AND
    E.[FallToWinterProjectedGrowth__c] IS NULL AND
    E.[FalltoWinterObservedGrowth__c] IS NULL AND
    E.[FallToWinterConditionalGrowthIndex__c] IS NULL AND
    E.[FallToWinterConditionalGrowthPercentile__c] IS NULL AND
    E.[FallToSpringProjectedGrowth__c] IS NULL AND
    E.[FalltoSpringObservedGrowth__c] IS NULL AND
    E.[FallToSpringConditionalGrowthIndex__c] IS NULL AND
    E.[FallToSpringConditionalGrowthPercentile__c] IS NULL AND
    E.[WinterToWinterProjectedGrowth__c] IS NULL AND
    E.[WinterToWinterObservedGrowth__c] IS NULL AND
    E.[WinterToWinterConditionalGrowthIndex__c] IS NULL AND
    E.[WinterToWinterConditionalGrowthPercentil__c] IS NULL AND
    E.[WinterToSpringProjectedGrowth__c] IS NULL AND
    E.[WinterToSpringObservedGrowth__c] IS NULL AND
    E.[WinterToSpringConditionalGrowthIndex__c] IS NULL AND
    E.[WinterToSpringConditionalGrowthPercentil__c] IS NULL AND
    E.[SpringToSpringProjectedGrowth__c] IS NULL AND
    E.[SpringToSpringObservedGrowth__c] IS NULL AND
    E.[SpringToSpringConditionalGrowthIndex__c] IS NULL AND
    E.[SpringToSpringConditionalGrowthPercentil__c] IS NULL

UPDATE Data_Services.dbo.SF_Assessments_NWEA SET [SchoolForce__External_Id__c] = [SchoolForce__External_Id__c] + CAST(ID AS VARCHAR(5))

UPDATE
T1
SET
T1.SchoolForce__Type__c = T2.ID
FROM
Data_Services.dbo.SF_Assessments_NWEA T1 INNER JOIN
SDW_Stage_Prod.dbo.Picklist_Value__c T2 ON 
	T1.SchoolForce__Assessment_Name__c=T2.Name
END





GO
