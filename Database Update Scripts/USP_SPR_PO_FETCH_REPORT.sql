/****** Object:  StoredProcedure [dbo].[USP_SPR_PO_FETCH_REPORT]    Script Date: 29-03-2022 00:40:01 ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SPR_PO_FETCH_REPORT]
GO
/****** Object:  StoredProcedure [dbo].[USP_SPR_PO_FETCH_REPORT]    Script Date: 29-03-2022 00:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Anuj
-- Create date: 
-- Description:	Generation of PO report if attached to any WO
-- =============================================
CREATE PROCEDURE [dbo].[USP_SPR_PO_FETCH_REPORT] 
@PO_NUMBER VARCHAR(30)

AS
BEGIN

	select distinct 
			poi.PONUMBER as PONUMBER,
			sup.SUP_Name AS SUP_NAME,
			poi.ID_ITEM_CATG as ID_ITEM_CATG,
			poi.ID_ITEM as ID_ITEM,
			wh.WO_CUST_NAME as CUST_NAME,
			wh.WO_VEH_REG_NO as WO_VEH_REG_NO,
			wh.id_wo_prefix + wh.id_wo_no AS ID_WO,
			wd.ID_JOB AS ID_JOB,
			wh.DT_ORDER as ORDER_DATE, -- Need to check
			--poi.BACKORDERQTY as BACKORDERQTY,
			poi.ORDERQTY as ORDERQTY,
			poi.DELIVERED_QTY as DELIVERED_QTY,
			poi.REMAINING_QTY as REMAINING_QTY
			
			from TBL_SPR_PO_ITEM poi
			inner join tbl_WO_Job_Detail job on job.ID_WOITEM_SEQ = poi.ID_WOITEM_SEQ
			inner join tbl_wo_header wh on wh.id_Wo_no = job.ID_WO_NO and wh.id_wo_prefix = job.id_wo_prefix
			inner join tbl_wo_detail wd on job.ID_WODET_SEQ_JOB =wd.ID_WODET_SEQ 
			inner join TBL_MAS_SUPPLIER sup ON sup.SUPP_CURRENTNO = poi.SUPP_CURRENTNO

		where PONUMBER = @PO_NUMBER
 END


GO
