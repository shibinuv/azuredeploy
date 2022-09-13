/****** Object:  Table [dbo].[TBL_BARGAIN_SMS_DETAILS]    Script Date: 24-08-2022 19:21:28 ******/
DROP TABLE IF EXISTS [dbo].[TBL_BARGAIN_SMS_DETAILS]
GO
/****** Object:  Table [dbo].[TBL_BARGAIN_SMS_DETAILS]    Script Date: 24-08-2022 19:21:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_BARGAIN_SMS_DETAILS](
	[ID_SMS_DETAILS] [int] IDENTITY(1,1) NOT NULL,
	[BargainId] [nvarchar](max) NULL,
	[WO_NO] [varchar](50) NULL,
	[WO_PREFIX] [varchar](30) NULL,
	[WO_JOB_NO] [int] NULL,
	[IsAccepted] [bit] NOT NULL,
	[CreatedBy] [varchar](100) NULL,
	[ModifiedBy] [varchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_BARGAIN_SMS_DETAILS] PRIMARY KEY CLUSTERED 
(
	[ID_SMS_DETAILS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
