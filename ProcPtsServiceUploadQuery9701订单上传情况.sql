ALTER  PROC ProcPtsServiceUploadQuery9701
@UserID int, 
@Parastr varchar(2000)
AS
	set nocount ON
	DECLARE @StartDate DATETIME --起始日期
	DECLARE @EndDate   DATETIME --截止日期 
    DECLARE @ListCode  varchar(50) --订单编号
    DECLARE @CorpSearch varchar(200) --单位检索字串
    DECLARE @GoodsSearch varchar(200) --品种检索字串
    DECLARE @BatchNo varchar(50) --批号检索 
    DECLARE @UpStatus int --订单上传状态  
    DECLARE @Paraout varchar(500) 
    DECLARE @sql NVARCHAR(1000)
    DECLARE @clause NVARCHAR(1000)  
    DECLARE @gtype   int            
                      
    EXEC  dbo.v6_PopFirstWord  @Parastr OUTPUT,@Paraout OUTPUT 
    SET   @StartDate=CONVERT(DATETIME,@ParaOut,120) 
    EXEC  dbo.v6_PopFirstWord  @Parastr OUTPUT,@Paraout OUTPUT 
    SET   @EndDate=CONVERT(DATETIME,@ParaOut,120)+1  
    EXEC  dbo.v6_PopFirstWord  @Parastr OUTPUT,@Paraout OUTPUT 
    SET    @ListCode=@paraout  
    EXEC  dbo.v6_PopFirstWord  @Parastr OUTPUT,@Paraout OUTPUT 
    SET    @CorpSearch=@paraout 
    EXEC  dbo.v6_PopFirstWord  @Parastr OUTPUT,@Paraout OUTPUT 
    SET    @GoodsSearch=@paraout  
    EXEC  dbo.v6_PopFirstWord  @Parastr OUTPUT,@Paraout OUTPUT 
    SET    @BatchNo=@paraout
    EXEC  dbo.v6_PopFirstWord  @Parastr OUTPUT,@Paraout OUTPUT 
    SET    @UpStatus=@paraout  
    
    
    SET @sql='
      SELECT  ot.BusiName, ot.SFDAFilePreFix + l.listcode + ''_'' + convert(varchar,i.itemid) + ''.xml'' as FileName
		, l.CORPNAME , g.GoodsName
		,i.*  
		, (select count(1) from wmsepscrecord with(nolock) where packtype <> ''零'' and listid = i.listid and itemid = i.itemid ) As barcount,il.CompanyName as ConsignorName,
		 ul.upstatus,ul.UpTime,ul.UpMsg,l.CommTag
       FROM dbo.WMSORDERITEMS i with(nolock) 
		JOIN wmsorderlist l with(nolock) ON i.listid = l.listid 
		join wmsordertype ot  with(nolock) ON l.BusiType = ot.OTID
		JOIN goodsbaseinfo g  with(nolock) ON i.goodsid = g.goodsid
		left join tabptsserviceuplog ul with (nolock) on i.listid = ul.listid and i.itemid = ul.itemid 
		left join InterList il with (nolock) on il.InterFaceId = g.InterID
		left join InterConsignor ic with (nolock) on ic.interid=g.InterId '
     SET @clause ='WHERE l.CommTag=5'
    SET @clause = @clause + ' and picktime BETWEEN ''' + CONVERT(VARCHAR(10),@StartDate,120) + ''' AND ''' + CONVERT(VARCHAR(10),@EndDate,120) + ''''
    IF (@listcode!='')
    SET @clause=@clause + 'and l.listcode= '+@listcode
    IF @BatchNo!=''
     SET @clause=@clause + 'and i.batchno= '+@batchno
     IF @CorpSearch!=''
      SET @clause=@clause + 'and l.custom= '+@CorpSearch
    IF @GoodsSearch <> ''            
 BEGIN             
 SET @gtype = dbo.pub_getCodeType(@GoodsSearch)            
 IF @gtype = 1             
  SET @clause = @clause + ' and gb.GoodsCode like ''%' + @goodsSearch + '%'''            
 ELSE IF @gtype = 2             
  SET @clause = @clause + ' and gb.spellcode like ''%' + @goodsSearch + '%'''            
 ELSE IF @gtype = 3                
  SET @clause = @clause + ' and gb.goodsname like ''%' + @goodsSearch+ '%'''            
 END    
 SET @sql=@sql+@clause 
 EXEC (@sql)        
    
    
    
                  