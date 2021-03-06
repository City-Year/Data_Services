USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_School_Grades]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_School_Grades]
AS
SELECT
       School_Grades.School_ID,LEFT(School_Grades.Grade,LEN(School_Grades.Grade)-1) AS "Grades"
FROM
    (
        SELECT DISTINCT ST2.School_ID, 
            (
               SELECT DISTINCT CASE WHEN ST1.Grade <> '10' THEN REPLACE(ST1.Grade,0,'') ELSE ST1.Grade END + ';' AS [text()] 
               FROM dbo.Student ST1
               WHERE ST1.School_ID = ST2.School_ID
               FOR XML PATH ('')
            ) [Grade]
        FROM dbo.Student ST2  

    )[School_Grades]


GO
