ALTER  proc ProcPtsServiceCorpMatch9701 
@UserID int, 
@ServiceID int, 
@SysCorpID int, 
@ClientID INT
AS
set nocount ON 

IF EXISTS (SELECT * FROM TabPtsServiceCorpMap AS tpscm WHERE tpscm.ClientID=@ClientID)
	BEGIN
	SELECT -3223, '该单位已有匹配'
	RETURN  
	END  
SELECT  cl.ServiceID,cl.CorpID,cu.clientid INTO #temp
FROM 
tabptsservicecorplist AS cl 
INNER JOIN  clientunit AS cu ON cu.clientname =cl.CorpName 
WHERE  cl.serviceid=@ServiceID AND cl.corpid=@SysCorpID AND cu.USED=1 AND cu.clientid=@clientid

INSERT INTO TabPtsServiceCorpMap(ServiceID,SysCorpID,ClientID) SELECT t.ServiceID,t.CorpID,t.clientid FROM #temp  t 
IF @@ROWCOUNT>0
	BEGIN 
	update A SET matchtype = 1 from clientunit A inner join #temp B on A.clientid = B.clientid 
	SELECT 1000, '匹配成功'
	END 
ELSE 
	SELECT -2333, '匹配失败'
	
