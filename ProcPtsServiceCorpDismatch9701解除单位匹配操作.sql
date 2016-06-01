ALTER  PROC  ProcPtsServiceCorpDismatch9701 
@UserID int, 
@ServiceID int, 
@SysCorpID int,
@ClientID int  
AS
set nocount ON  
DECLARE @meg VARCHAR (1000)

SELECT  cl.ServiceID,cl.CorpID,cu.clientid INTO #temp
FROM 
tabptsservicecorplist AS cl 
INNER JOIN  clientunit AS cu ON cu.clientname =cl.CorpName 
WHERE  cl.serviceid=@ServiceID AND cl.corpid=@SysCorpID  AND cu.USED=1 
update A SET matchtype = 2 
 from clientunit A inner join #temp B on A.clientid = B.clientid  WHERE a.matchtype=1  
IF @@ROWCOUNT>0
	BEGIN 
	DELETE TabPtsServiceCorpMap WHERE clientid=@ClientID and ServiceID=@ServiceID and SysCorpID=@SysCorpID 
	SELECT 1000,'解除成功'
	END
ELSE 
	SELECT -2333, '解除失败'
	
