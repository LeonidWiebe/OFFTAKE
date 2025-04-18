SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[wwwwwwwwww_find_square_of_fire_comp]
AS
SELECT     

dbo.elements.simID, 
----S.simID as ssim,
----dbo.elements.elemID, 
----dbo.elements.pwdocID, 
----dbo.elements.elemguid, 
S.number,

dbo.getTrueArea2(S.simID, 0, 2) as SpaceSquare,

S.NumFireComp,

	case when [NumFireComp] is null then '-'
	else 
		case [NumFireComp] 
		 when 'Отсутствует/missing' then '-'
		 else STR(dbo.getTrueArea2(S.simID, 0, 2), 10, 1)
		end
	end Comp1square,

	S.NumFireComp2,

	case when [NumFireComp2] is null then '-'
	else 
		case [NumFireComp2] 
		 when 'Отсутствует/missing' then '-'
		 else STR(dbo.getTrueArea2(S.simID, 0, 2), 10, 1)
		end
	end Comp2square



FROM         dbo.elements 

INNER JOIN dbo.i_Space as S ON dbo.elements.simID = S.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id

GO
