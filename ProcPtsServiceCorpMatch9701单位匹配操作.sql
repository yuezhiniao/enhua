USE [zbwms_EnHua]
GO

--匹配操作
ALTER  proc ProcPtsServiceCorpMatch9701 
@UserID int, 
@ServiceID int, 
@SysCorpID int, 
@ClientID INT=987654
AS
set nocount ON 

IF @ClientID=987654 
BEGIN
	SELECT  cl.ServiceID,cl.CorpID,cu.clientid INTO #temp
	FROM 
	tabptsservicecorplist AS cl 
	INNER JOIN  clientunit AS cu ON cu.clientname =cl.CorpName
	WHERE cu.IsCustom=1
	AND cu.used=1
	 
	INSERT INTO TabPtsServiceCorpMap(ServiceID,SysCorpID,ClientID) 
	SELECT t.ServiceID,t.CorpID,t.clientid FROM #temp  t WHERE NOT EXISTS 
	(SELECT '1' FROM TabPtsServiceCorpMap b WHERE  b.SysCorpID=t.corpid)
	
	
		update A SET matchtype = 1 FROM clientunit a inner JOIN #temp B on A.clientid = B.clientid 
		SELECT '1000', '匹配成功'
	  
END
else IF EXISTS (SELECT * FROM TabPtsServiceCorpMap AS tpscm WHERE tpscm.ClientID=@ClientID)
BEGIN
	SELECT -1000, '该单位已有匹配'
	RETURN  
END  
else 
BEGIN
	SELECT  cl.ServiceID,cl.CorpID,cu.clientid INTO #temp1
	FROM 
	tabptsservicecorplist AS cl 
	INNER JOIN  clientunit AS cu ON cu.clientname =cl.CorpName 
	WHERE  
	cl.serviceid=@ServiceID 
	AND cl.corpid=@SysCorpID 
	AND cu.USED=1 
	AND cu.clientid=@clientid
	AND cu.IsCustom=1
 
INSERT INTO TabPtsServiceCorpMap(ServiceID,SysCorpID,ClientID) 
SELECT t.ServiceID,t.CorpID,t.clientid FROM #temp1  t 
IF @@ROWCOUNT>0
BEGIN 
	update A SET matchtype = 1 FROM clientunit a inner JOIN #temp1 B on A.clientid = B.clientid 
	SELECT '1000', '匹配成功'
	END 
ELSE 
	SELECT '-1000', '匹配失败'  
END