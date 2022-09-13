
INSERT INTO [dbo].[TBL_MAS_ITEM_CATG]
           ([ID_ITEM_CATG]
		   ,[CATG_DESC]
           ,[ID_DISCOUNTCODEBUY]
           ,[ID_DISCOUNTCODESELL]
           ,[ID_SUPPLIER]
           ,[ID_MAKE]
           ,[DESCRIPTION]
           ,[INITIALCLASSCODE]
           ,[VATCODE]
           ,[ACCOUNTCODE]
           ,[FLG_ALLOWBO]
           ,[FLG_COUNTSTOCK]
           ,[FLG_ALLOWCLASS]
           ,[CREATED_BY]
           ,[DT_CREATED]
           ,[MODIFIED_BY]
           ,[DT_MODIFIED]
           ,[SUPP_CURRENTNO])
     VALUES
           (62
		   ,'01'
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,'Bilglassgruppen'
           ,NULL
           ,100
           ,'BG'
           ,1
           ,1
           ,0
           ,'22admin'
           ,GETDATE()
           ,NULL
           ,NULL
           ,'20012')
GO



