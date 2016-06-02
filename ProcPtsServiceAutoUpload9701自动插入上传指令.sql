--自动插入上传指令
ALTER PROC  ProcPtsServiceAutoUpload9701 


AS 
SET NOCOUNT ON 

SELECT  wl.listid ,wi.itemid,1 AS upstatus INTO #temp  
FROM  wmsorderlist wl 
INNER JOIN WMSORDERITEMS AS wi ON wl.listid=wi.listid 
WHERE  wl.CommTag=5 AND wl.CORPNAME LIKE '%哈药%'

IF (@@ROWCOUNT>0)
BEGIN 
	UPDATE a SET a.upsendstatus =1 FROM wmsorderlist a 
	INNER JOIN #temp t ON t.listid=a.listid  
	--------------加入上传表
	INSERT INTO tabptsserviceuplog (ListID,ItemID,UpStatus)
	SELECT listid,itemid,upstatus FROM #temp 
	--------------更新指令表让系统自动获取  
	UPDATE tabptsservicecommand SET optype=1   WHERE servicetype=1115   
END                            