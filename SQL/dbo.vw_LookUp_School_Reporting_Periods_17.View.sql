USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_LookUp_School_Reporting_Periods_17]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_LookUp_School_Reporting_Periods_17]
AS
SELECT     d.Id AS Reporting_Period__c, d.Name__c AS Name, a.School_Name, a.Account_ID, a.School_Grades, a.County, a.Source_School_Name, a.Source_School_ID, 
                      a.Setup_14_15 AS setup__c
FROM         dbo.School_Lookup AS a INNER JOIN
                      SDW_Stage_Prod.dbo.Setup__c AS b ON a.Setup_14_15 = b.Id INNER JOIN
                      SDW_Stage_Prod.dbo.Time_Element__c AS d ON b.Term__c = d.Parent_Time_Element__c
WHERE     (NOT (d.Name__c LIKE '%Prior%'))


GO
