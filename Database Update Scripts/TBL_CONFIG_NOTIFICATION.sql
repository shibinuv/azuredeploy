/****** Object:  Table [dbo].[TBL_CONFIG_NOTIFICATION]    Script Date: 24-08-2022 19:20:33 ******/
DROP TABLE IF EXISTS [dbo].[TBL_CONFIG_NOTIFICATION]
GO
/****** Object:  Table [dbo].[TBL_CONFIG_NOTIFICATION]    Script Date: 24-08-2022 19:20:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CONFIG_NOTIFICATION](
	[IdNotification] [int] IDENTITY(1,1) NOT NULL,
	[NotificationMessage] [nvarchar](max) NULL,
	[NotificationType] [int] NOT NULL,
	[IsNotification] [bit] NOT NULL,
	[WO_NO] [varchar](50) NULL,
	[WO_PREFIX] [varchar](30) NULL,
	[WO_JOB_NO] [int] NULL,
	[CreatedBy] [varchar](100) NULL,
	[ModifiedBy] [varchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_CONFIG_NOTIFICATION] PRIMARY KEY CLUSTERED 
(
	[IdNotification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
