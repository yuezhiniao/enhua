USE [zbwms_EnHua]
GO

--�Զ������ϴ�ָ��
ALTER PROC  ProcPtsServiceAutoUpload9701 


AS 
SET NOCOUNT ON 

SELECT listid 
INTO #temp
FROM wmsorderlist AS wl 
WHERE wl.upsendstatus IS NULL 
AND wl.CommTag=5
---�ж��Ƿ�����
SELECT distinct t.listid 
INTO #temp1
FROM #temp t 
INNER JOIN WMSEPSCRECORD AS w ON t.listid=w.listid 
inner JOIN WMSGoodsProdCode AS wpc ON wpc.listid=wpc.ListID 

IF (@@ROWCOUNT>0)
BEGIN 
	-----��Ҫ�ϴ��ļ�¼
	UPDATE a SET a.upsendstatus =1 FROM wmsorderlist a 
	INNER JOIN #temp1 t ON t.listid=a.listid  
	--------------�����ϴ���
	INSERT INTO tabptsserviceuplog (ListID,ItemID,UpStatus)
	SELECT listid,'1','1' FROM #temp1 
	--------------����ָ�����ϵͳ�Զ���ȡ  
	--UPDATE tabptsservicecommand SET optype=1   WHERE servicetype=1115   
END