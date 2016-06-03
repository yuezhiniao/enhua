USE [zbwms_EnHua]
GO

--自动插入上传指令
ALTER PROC  ProcPtsServiceAutoUpload9701 


AS 
SET NOCOUNT ON 

SELECT listid 
INTO #temp
FROM wmsorderlist AS wl 
WHERE wl.upsendstatus IS NULL 
AND wl.CommTag=5
---判断是否有码
SELECT distinct t.listid 
INTO #temp1
FROM #temp t 
INNER JOIN WMSEPSCRECORD AS w ON t.listid=w.listid 
inner JOIN WMSGoodsProdCode AS wpc ON wpc.listid=wpc.ListID 

IF (@@ROWCOUNT>0)
BEGIN 
	-----需要上传的记录
	UPDATE a SET a.upsendstatus =1 FROM wmsorderlist a 
	INNER JOIN #temp1 t ON t.listid=a.listid  
	--------------加入上传表
	INSERT INTO tabptsserviceuplog (ListID,ItemID,UpStatus)
	SELECT listid,'1','1' FROM #temp1 
	--------------更新指令表让系统自动获取  
	--UPDATE tabptsservicecommand SET optype=1   WHERE servicetype=1115   
END