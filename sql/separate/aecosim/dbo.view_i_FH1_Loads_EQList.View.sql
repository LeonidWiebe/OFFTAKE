SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_FH1_Loads_EQList]
AS
SELECT   
		e.simID, 
		e.elemID, 
		e.pwdocID, 
		s.number,
		leq.*
	
	/*
	CASE
		When parts.dbo.part.typeID IS NULL Then '<-- нет в каталоге'
		Else parts.dbo.dictionary.dicEng + ' / ' + parts.dbo.dictionary.dicRus 
	END AS 'Type',
	*/
		
		
		
		--parts.dbo.part.deleted
FROM  dbo.elements e


LEFT OUTER JOIN dbo.i_Space s ON s.simID = e.simID   
LEFT OUTER JOIN civil.dbo.EQ_in_Rooms eq ON eq.Room_KKS = s.number
LEFT OUTER JOIN civil.dbo.Loads_Equipment leq ON leq.EQ_KKS = eq.EQ_KKS

where leq.EQ_KKS is not null




GO
