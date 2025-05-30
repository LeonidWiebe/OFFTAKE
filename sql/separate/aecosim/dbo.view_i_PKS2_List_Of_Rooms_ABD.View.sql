SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_PKS2_List_Of_Rooms_ABD]
AS
SELECT        dbo.elements.simID, dbo.elements.elemID, dbo.elements.pwdocID, LEFT(dbo.i_Space.number, 7) AS [KKS отметки], dbo.i_Space.number AS KKS, dbo.i_Space.label AS [Name RU], dbo.i_Space.label2 AS [Name EN], 
                         CASE WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL1 ' THEN 'Эпоксидное покрытие' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL2 ' THEN 'Наливное эпоксидное покрытие' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
                         = 'FL3 ' THEN 'Дезактивируемое наливное эпоксидное покрытие' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL4 ' THEN 'Бетон со шлифованием' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
                         = 'FL5 ' THEN 'Облицовка нержавеющей сталью' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL6 ' THEN 'Керамическая плитка' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
                         = 'FL7 ' THEN 'Линолеум' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL8 ' THEN 'Керамический гранит' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
                         = 'FL9 ' THEN 'Панели фальшпола с антистатическим покрытием' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL10' THEN 'Антистатическое наливное эпоксидное покрытие' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
                         = 'FL11' THEN 'Антистатический линолеум' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL12' THEN 'Химически стойкое наливное эпоксидное покрытие' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
                         = 'FL13' THEN 'Химически стойкое дезактивируемое наливное эпоксидное покрытие' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
                         = 'FL14' THEN 'Кислотоупорная керамическая плитка' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL15' THEN 'Гидроизоляционное эпоксидное покрытие' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
						 = 'FL16' THEN 'Вододисперсионный состав для упрочнения поверхности бетона' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
						 = 'FL8,FL16' THEN 'Вододисперсионный состав для упрочнения поверхности бетона со стяжкой и керамический гранит со стяжкой'
						 WHEN LEFT(dbo.i_Space.TopCoatLayer, 4)  = 'FL17' THEN 'Износостойкое защитное покрытие на минеральной или цементно-полимерной основе' ELSE dbo.i_Space.TopCoatLayer END AS [Floor Interior Finish RU],
                          CASE WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL1 ' THEN 'Epoxy coating' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL2 ' THEN 'Self-leveling epoxy coating' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
                         = 'FL3 ' THEN 'Decontaminable self-leveling epoxy coating' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL4 ' THEN 'Concrete with smooth finish' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
                         = 'FL5 ' THEN 'Lining with stainless steel' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL6 ' THEN 'Ceramic tiles' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL7 ' THEN 'Linoleum' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4)
                          = 'FL8 ' THEN 'Ceramic granite' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL9 ' THEN 'Raised floor panels with antistatic coating' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
                         = 'FL10' THEN 'Antistatic self-leveling epoxy coating' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL11' THEN 'Antistatic linoleum' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) 
                         = 'FL12' THEN 'Chemical-resistant self-leveling epoxy coating' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL13' THEN 'Chemical-resistant decontaminable self-leveling epoxy coating' WHEN LEFT(dbo.i_Space.TopCoatLayer, 
                         4) = 'FL14' THEN 'Acid-resistant ceramic tiles' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4) = 'FL15' THEN 'Waterproofing epoxy coating' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4)
						 = 'FL16' THEN 'Water dispersed surface hardening compound for concrete' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4)
						 = 'FL17' THEN 'Wear-resistant mineral- or cement-polymer-based protective coating' WHEN LEFT(dbo.i_Space.TopCoatLayer, 4)
						 = 'FL8,FL16' THEN 'Water dispersed curing and sealing compound for concrete and ceramic granite' ELSE dbo.i_Space.TopCoatLayer END AS [Floor Interior Finish EN], 
                         dbo.getZero2(dbo.getTrueArea2(dbo.elements.simID, 0, 2)) AS [Floor Area], LEFT(dbo.i_Space.number, 5) AS [KKS здания]
FROM            dbo.elements INNER JOIN
                         dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
GO
