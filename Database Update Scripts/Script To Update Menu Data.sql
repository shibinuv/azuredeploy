-- To update CustomerInfo to CustomerSearch - /master/frmCustomerInfo.aspx

UPDATE TBL_UTIL_MOD_DETAILS
SET
NAME_URL='/master/frmCustomerSearch.aspx'
WHERE ID_SCR in (315,482)

-- To update VehicleInfo to VehicleSearch - /master/frmVehicleInfo.aspx
UPDATE TBL_UTIL_MOD_DETAILS
SET
NAME_URL='/master/frmVehicleSearch.aspx'
WHERE ID_SCR in (314,481)


-- To update Name_Module from Configuration to Customer for  /master/frmCfCustomer.aspx  - 209 -> 205
UPDATE TBL_UTIL_MOD_DETAILS
SET
NAME_MODULE ='CUSTOMER', Module_level = 205 
WHERE ID_SCR in (236)

-- To update Name_Module from Configuration to Vehicle for  /master/frmCfVehicleDetail.aspx  - 209 -> 206
UPDATE TBL_UTIL_MOD_DETAILS
SET
NAME_MODULE ='VEHICLE', Module_level = 206 
WHERE ID_SCR in (238)

--To update the page name  --215	Mechanic Day Plan	/Transactions/frmGPDayplanMech.aspx	PLANNING	203	1
UPDATE TBL_UTIL_MOD_DETAILS
SET
NAME_URL ='/Transactions/frmDayPlan.aspx' 
WHERE ID_SCR in (213,215)
