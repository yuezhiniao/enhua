USE [zbwms_EnHua]
GO

ALTER  PROC ProcPtsServiceUploadQuery9701
@UserID int, 
@Parastr varchar(2000)='2016-04-03,2016-06-06,,,,,5'
AS
	set nocount ON
	DECLARE @StartDate DATETIME --��ʼ����
	DECLARE @EndDate   DATETIME --��ֹ���� 
    DECLARE @ListCode  varchar(50) --�������
    DECLARE @CorpSearch varchar(200) --��λ�����ִ�
    DECLARE @GoodsSearch varchar(200) --Ʒ�ּ����ִ�
    DECLARE @BatchNo varchar(50) --���ż��� 
    DECLARE @UpStatus VARCHAR(10) --�����ϴ�״̬  
    DECLARE @Paraout varchar(500) 
    DECLARE @sql NVARCHAR(max)
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
      SELECT  
      l.listid, 
      l.listcode ,
      l.maketime,
      l.CORPNAME ,
      i.batchno,
      g.goodsname,
      l.custom,
	  il.CompanyName as ConsignorName,
      ul.upstatus,ul.UpTime,ul.UpMsg,l.CommTag ,
	  case when  l.upsendstatus=1 then ''������ϴ�'' 
		   when  l.upsendstatus=0 then ''����''  
		   when  l.upsendstatus=2 then ''�ϴ�ʧ��''  
		   when  l.upsendstatus=4 then ''��λδƥ��'' 
		   when  l.upsendstatus=5 then ''�ϴ��ɹ�'' end upsendstatus
		   
       FROM  wmsorderlist l with(nolock)
		JOIN dbo.WMSORDERITEMS i with(nolock) ON i.listid = l.listid 
		join wmsordertype ot  with(nolock) ON l.BusiType = ot.OTID
		JOIN goodsbaseinfo g  with(nolock) ON i.goodsid = g.goodsid
		left join tabptsserviceuplog ul with (nolock) on l.listid = ul.listid 
		left join InterList il with (nolock) on il.InterFaceId = g.InterID
		left join InterConsignor ic with (nolock) on ic.interid=g.InterId '
     SET @clause ='WHERE l.CommTag=5 '
    SET @clause = @clause +  'AND picktime BETWEEN '''+convert(varchar(10),@StartDate,120)+ '''AND'''+ convert(varchar(10),@EndDate,120)+''''
    IF (@listcode!='')
    SET @clause=@clause + ' AND  l.listcode like ''%' +@listcode+'%'''
    IF @BatchNo!=''
     SET @clause=@clause + ' AND  i.batchno like ''%' +@batchno+'%'''
     IF @CorpSearch!=''
      SET @clause=@clause + ' AND l.custom= '+@CorpSearch+''
    IF @GoodsSearch <> ''            
 BEGIN             
 SET @gtype = dbo.pub_getCodeType(@GoodsSearch)            
 IF @gtype = 1             
  SET @clause = @clause + ' and g.GoodsCode like ''%' + @goodsSearch + '%'''            
 ELSE IF @gtype = 2             
  SET @clause = @clause + ' and g.spellcode like ''%' + @goodsSearch + '%'''            
 ELSE IF @gtype = 3                
  SET @clause = @clause + ' and g.goodsname like ''%' + @goodsSearch+ '%'''  
  END  
  
 IF @UpStatus='' 
 SET @UpStatus='-1'
 if @UpStatus!='-1'
 SET @clause=@clause + 'and l.upsendstatus= '+@UpStatus+''
    
 SET @sql=@sql+@clause 
 PRINT (@sql)
 EXEC (@sql)