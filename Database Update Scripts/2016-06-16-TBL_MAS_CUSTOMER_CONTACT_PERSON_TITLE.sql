-- =============================================
-- Author:		Thomas Won Nyheim (TWN)
-- Create date: 2016/06/16
-- Description:	Changes the description on TBL_MAS_CUSTOMER_CONTACT_TITLE to 25 length
-- =============================================

IF EXISTS (
	SELECT * 
    FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
	WHERE CONSTRAINT_NAME ='FK_CONTACT_PERSON_TITLE'
	)
BEGIN
	ALTER TABLE TBL_MAS_CUSTOMER_CONTACT_PERSON
    DROP CONSTRAINT FK_CONTACT_PERSON_TITLE
END

IF EXISTS(
	SELECT *
    FROM   INFORMATION_SCHEMA.TABLES
    WHERE  TABLE_NAME = 'TBL_MAS_CUSTOMER_CONTACT_PERSON_TITLE'
           AND TABLE_SCHEMA = 'dbo'
	)
BEGIN
	DROP TABLE TBL_MAS_CUSTOMER_CONTACT_PERSON_TITLE
END

IF NOT EXISTS(
	SELECT *
    FROM   INFORMATION_SCHEMA.TABLES
    WHERE  TABLE_NAME = 'TBL_MAS_CUSTOMER_CONTACT_PERSON_TITLE'
           AND TABLE_SCHEMA = 'dbo'
	)
BEGIN
	CREATE TABLE [dbo].[TBL_MAS_CUSTOMER_CONTACT_PERSON_TITLE](
		[ID_CP_TITLE] [int] IDENTITY(1,1) NOT NULL,
		[TITLE_CODE] [varchar](10) NOT NULL,
		[TITLE_DESCRIPTION] [varchar](25) NOT NULL,
		[CREATED_BY] [varchar](15) NULL,
		[DT_CREATED] [datetime] NULL,
		[MODIFIED_BY] [varchar](15) NULL,
		[DT_MODIFIED] [datetime] NULL
		PRIMARY KEY ([ID_CP_TITLE])
	) ON [PRIMARY]
	ALTER TABLE TBL_MAS_CUSTOMER_CONTACT_PERSON 
	ADD CONSTRAINT FK_CONTACT_PERSON_TITLE FOREIGN KEY ([CP_ID_TITLE]) 
		REFERENCES TBL_MAS_CUSTOMER_CONTACT_PERSON_TITLE ([ID_CP_TITLE]) 
		ON DELETE CASCADE
		ON UPDATE CASCADE
	;
END