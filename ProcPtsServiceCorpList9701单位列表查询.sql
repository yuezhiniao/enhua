ALTER PROC  ProcPtsServiceCorpList9701 
@UserID int, 
@Parastr varchar(2000)
AS
set nocount ON
     DECLARE  @SearchName varchar(200)  --¼ìË÷×Ö´®
     SET @searchname=@Parastr
      
    SELECT SysID, ServiceID, CorpID, CorpCode, CorpName, SpellCode
    FROM TabPtsServiceCorpList AS cl 
    WHERE corpname LIKE '%'+@SearchName+'%' 
   