alter PROC  ProcPtsServiceAutoUpload9701 
@userd INT 

AS 
SET NOCOUNT ON 


SELECT  wl.listid ,wi.itemid,1 AS upstatus INTO #temp  FROM  wmsorderlist wl 
INNER JOIN WMSORDERITEMS AS wi ON wl.listid=wi.listid 
WHERE wl.UpSendStatus IS NULL AND wl.CommTag=5 AND wl.CORPNAME LIKE '%哈药%'

UPDATE a SET a.upsendstatus =1 FROM WMSORDERITEMS a 
INNER JOIN #temp t ON t.listid=a.listid AND t.itemid=a.itemid AND upsendstatus IS null


INSERT INTO tabptsserviceuplog (ListID,ItemID,UpStatus)
SELECT listid,itemid,upstatus FROM #temp --加入自动上传表


 
 


