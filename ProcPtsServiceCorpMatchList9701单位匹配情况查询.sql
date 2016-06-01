ALTER  PROC  ProcPtsServiceCorpMatchList9701 
@UserID INT ,
@Parastr varchar(2000)
AS
    SET NOCOUNT ON 
	DECLARE  @SearchName varchar(200)  --¼ìË÷×Ö´®
	DECLARE  @MatchType int  --0ËùÓÐ£¬1 Æ¥Åä£¬2 Î´Æ¥Åä
	DECLARE @Paraout   varchar(2000)
	DECLARE @sql NVARCHAR (1000)
	DECLARE @caluse NVARCHAR (1000)
	
    EXEC  dbo.v6_PopFirstWord  @Parastr OUTPUT,@Paraout OUTPUT 
    SET    @SearchName=@paraout  
    EXEC  dbo.v6_PopFirstWord  @Parastr OUTPUT,@Paraout OUTPUT 
    SET    @MatchType=@paraout  
    set @sql='
    SELECT  cu.ClientName,cu.clientid ,cl.corpname,cl.ServiceID,cl.CorpID,(case when cu.matchtype=1 THEN ''ÒÑÆ¥Åä'' else  ''Î´Æ¥Åä'' end) statu
    FROM clientunit cu 
   
    left JOIN TabPtsServiceCorpList AS cl ON cl.corpname=cu.clientname '
   
    IF @MatchType=0 
    SET @caluse= 'WHERE cu.ClientName LIKE ''%¹þÒ©%'' and cu.used=1 '
    IF @MatchType=1
    SET @caluse='WHERE cu.ClientName LIKE ''%¹þÒ©%'' and cu.used=1  and cu.MatchType=1'
    IF @MatchType=2 
    SET @caluse='WHERE cu.ClientName LIKE ''%¹þÒ©%'' and cu.used=1  and cu.MatchType=2'
    IF @SearchName!=''
    SET @caluse=@caluse+ 'AND cl.corpname LIKE ' + '%'+@SearchName+'%'
    SET @sql = @sql + @caluse 
    EXEC (@sql)
    
     
    
    
    