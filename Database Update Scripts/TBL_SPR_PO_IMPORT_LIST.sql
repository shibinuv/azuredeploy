USE [CARSDEV]
GO

/****** Object:  Table [dbo].[TBL_SPR_PO_IMPORT_LIST]    Script Date: 27.03.2020 12:14:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TBL_SPR_PO_IMPORT_LIST](
	[PID] [int] IDENTITY(1,1) NOT NULL,
	[ID_ITEM] [varchar](50) NULL,
	[ID_ITEM_CATG] [int] NULL,
	[SUPP_CURRENTNO] [int] NULL,
	[QUANTITY] [decimal](18, 2) NULL,
	[WAREHOUSE] [int] NULL,
	[PURCHASE_TYPE] [varchar](50) NULL,
	[MODULE] [varchar](max) NULL,
	[ORDERPREFIX] [varchar](max) NULL,
	[ORDERNUMBER] [varchar](max) NULL,
	[ORDERLINE] [varchar](max) NULL,
	[ORDERSEQ] [int] NULL,
	[DT_CREATED] [datetime] NULL,
	[CREATED_BY] [varchar](max) NULL,
	[CREATED_BY_ID_DEPT] [varchar](max) NULL,
	[DT_MODIFIED] [datetime] NULL,
	[MODIFIED_BY] [varchar](max) NULL,
	[MODIFIED_BY_ID_DEPT] [varchar](max) NULL,
	[FLG_IMPORTED] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

