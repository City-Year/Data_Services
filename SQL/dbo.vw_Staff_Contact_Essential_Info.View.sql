USE [Data_Services]
GO
/****** Object:  View [dbo].[vw_Staff_Contact_Essential_Info]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[vw_Staff_Contact_Essential_Info]
AS
Select Distinct Salutation = ''
	,FirstName
	,LastName
	,TempEmail = Convert(varchar,A.DistStaffID) + '_' + Replace(Rand(A.DistStaffID),'.','Qz')
	,Contact_Staff_RecordType = '012E0000000UD8KIAW'
	,Contact_Individual_AccountID = '001E000000NQWE4IAP'
	,SchoolName = ''
 	,Mailing_Street = ''
	,Mailing_City = ''
	,Mailing_State = ''
	,Mailing_Postal = ''
	,Staff_Name_for_StaffRcd = ''
	,ORG_ID_for_StaffRcd = ''
	,Gender = ''   
FROM dbo.vw_Teacher_List A INNER JOIN
	Class AS B WITH (NOLOCK)
		ON A.Teacher = B.Math_Teacher_Name INNER JOIN 
	Student AS C WITH (NOLOCK) 
		ON B.student_ID = C.Student_ID



GO
