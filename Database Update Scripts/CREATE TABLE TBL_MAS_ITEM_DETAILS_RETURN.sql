IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TBL_MAS_ITEM_DETAILS_RETURN]') AND type in (N'U'))
ALTER TABLE [dbo].[TBL_MAS_ITEM_DETAILS_RETURN] DROP CONSTRAINT IF EXISTS [FK_TBL_MAS_ITEM_DETAILS_RETURN]
GO
/****** Object:  Table [dbo].[TBL_MAS_ITEM_DETAILS_RETURN]    Script Date: 11-03-2022 15:18:06 ******/
DROP TABLE IF EXISTS [dbo].[TBL_MAS_ITEM_DETAILS_RETURN]
GO
/****** Object:  Table [dbo].[TBL_MAS_ITEM_DETAILS_RETURN]    Script Date: 11-03-2022 15:18:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_MAS_ITEM_DETAILS_RETURN](
	[ID_ITEM_DETAILS_RETURN] [int] IDENTITY(1,1) NOT NULL,
	[ID_RETURN_NUM] [int] NOT NULL,
	[ID_ITEM] [varchar](50) NULL,
	[ITEM_DESC] [varchar](100) NULL,
	[QTY_RETURNED] [int] NULL,
	[SALE_PRICE] [decimal](13, 2) NULL,
	[COST_PRICE] [decimal](13, 2) NULL,
	[SUPPLIER_NO] [varchar](50) NULL,
	[ID_WO_PREFIX] [varchar](20) NULL,
	[ID_WO_NO] [varchar](50) NULL,
	[RETURN_CODE] [varchar](50) NULL,
	[DT_CREATED] [datetime] NOT NULL,
	[CREATED_BY] [varchar](20) NOT NULL,
	[MODIFIED_BY] [varchar](20) NULL,
	[DT_MODIFIED] [datetime] NULL,
 CONSTRAINT [PK_TBL_MAS_ITEM_DETAILS_RETURN] PRIMARY KEY CLUSTERED 
(
	[ID_ITEM_DETAILS_RETURN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_MAS_ITEM_DETAILS_RETURN]  WITH CHECK ADD  CONSTRAINT [FK_TBL_MAS_ITEM_DETAILS_RETURN] FOREIGN KEY([ID_RETURN_NUM])
REFERENCES [dbo].[TBL_MAS_ITEM_HEADER_RETURN] ([ID_RETURN_NUM])
GO
ALTER TABLE [dbo].[TBL_MAS_ITEM_DETAILS_RETURN] CHECK CONSTRAINT [FK_TBL_MAS_ITEM_DETAILS_RETURN]
GO
