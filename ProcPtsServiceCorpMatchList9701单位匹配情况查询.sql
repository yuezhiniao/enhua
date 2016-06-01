ALTER  PROC  ProcPtsServiceCorpMatchList9701 
@UserID INT ,
@Parastr varchar(2000)
AS
    SET NOCOUNT ON 
	DECLARE  @SearchName varchar(200)  --�����ִ�
	DECLARE  @MatchType int  --0���У�1 ƥ�䣬2 δƥ��
	DECLARE @Paraout   varchar(2000)
	DECLARE @sql NVARCHAR (1000)
	DECLARE @caluse NVARCHAR (1000)
	
    EXEC  dbo.v6_PopFirstWord  @Parastr OUTPUT,@Paraout OUTPUT 
    SET    @SearchName=@paraout  
    EXEC  dbo.v6_PopFirstWord  @Parastr OUTPUT,@Paraout OUTPUT 
    SET    @MatchType=@paraout  
    set @sql='
    SELECT  cu.ClientName,cu.clientid ,cl.corpname,cl.ServiceID,cl.CorpID,(case when cu.matchtype=1 THEN ''��ƥ��'' else  ''δƥ��'' end) statu
    FROM clientunit cu 
   
    left JOIN TabPtsServiceCorpList AS cl ON cl.corpname=cu.clientname '
   
    IF @MatchType=0 
    SET @caluse= 'WHERE cu.ClientName LIKE ''%��ҩ%'' and cu.used=1 '
    IF @MatchType=1
    SET @caluse='WHERE cu.ClientName LIKE ''%��ҩ%'' and cu.used=1  and cu.MatchType=1'
    IF @MatchType=2 
    SET @caluse='WHERE cu.ClientName LIKE ''%��ҩ%'' and cu.used=1  and cu.MatchType=2'
    IF @SearchName!=''
    SET @caluse=@caluse+ 'AND cl.corpname LIKE ' + '%'+@SearchName+'%'
    SET @sql = @sql + @caluse 
    EXEC (@sql)
    
     
    
    
    