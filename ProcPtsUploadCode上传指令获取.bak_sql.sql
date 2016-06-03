USE [zbwms_EnHua]
GO

ALTER PROC  ProcPtsUploadCode 
@ServiceID INT
AS 
SET NOCOUNT ON 

DECLARE @ListID int 
DECLARE @ItemID int 
DECLARE @RetCode varchar(10)
DECLARE @RetMsg varchar(max)
DECLARE @clientid INT
DECLARE @matchtype INT 
DECLARE @t1 nvarchar(MAX)
DECLARE @t2 varchar(MAX)

SELECT TOP 1 @listid=listid  FROM TabPtsServiceUpLog AS ul WHERE ul.UpStatus=1

--判断是否已匹配
select @clientid =wl.Custom  FROM wmsorderlist wl WHERE listid=@listid 
SELECT @matchtype=matchtype FROM clientunit cu WHERE clientid=@clientid 

IF (@matchtype=2)
	BEGIN
 	SET @RetMsg= '未匹配'
 	SET @RetCode= '-1000'
	UPDATE TabPtsServiceUpLog 
	SET
		UpStatus = 2,
		UpMsg = @retmsg,
		UpTime = GETDATE()
	WHERE listid=@listid  
	UPDATE wmsorderlist SET upsendstatus=4 WHERE listid=@listid
	END
 ELSE 
 	BEGIN  
 		SELECT 
 		wl.custom as CorpId,		--企业ID
 		wl.CorpCode as CorpCode,		--企业编码
 		ul.listid AS StoreId ,		--单据ID
 		wl.listcode AS StoreNo,  --单据号
 		wl.maketime AS StoreDate,  --单据时间
 		'5' as StoreType,  ----单据类型 (写死)
 		'销售出库' AS StoreTypeText, ---单据类型文本(写死)
		wl.consignor  as StoreMan,  --指派人 (委托人)
 		cl.corpid   AS BizCorpId,   --往来企业ID
 		cl.corpcode AS BizCorpCode,  --往来企业编码
        cl.corpname AS BizCorpName,     --往来企业名称 
		wl.custom	AS RecCorpId ,  --接受企业
 		wl.corpcode AS RecCorpCode,    --  接收企业编码
 		wl.corpname AS RecCorpName ,   -- 接收企业名称 
 		                             
 		convert(varchar,wi.goodsid )  +'|'+   -- productId
 		wi.GoodsCode   +'|' +         --productCode
 		gb.goodsname  +'|'+         -- productName
 		gb.unit  +'|'+              -- productUnit
 		 convert(varchar,gb.ProviderID)  +'|'+       -- produceCorpId
 		gb.ProduceArea   +'|'+         -- produceCorpName
 		wi.BatchNo   +'|'+          --produceBatchNo
 		''  +'|' +              --displayAmount
 		''  +'|'+               -- displayProductUnit
 		convert(varchar,wi.Amount) yy  ,     -- amount
 		wi.itemid , er.EPSCCode 
 		INTO #tt
 		FROM TabPtsServiceUpLog AS ul
 		inner join wmsorderlist AS wl ON wl.ListID=ul.ListID
 		INNER JOIN wmsorderitems AS wi ON (wi.listid=ul.listid)
 		--INNER JOIN clientunit as cu ON cu.clientid=wl.custom
 		INNER JOIN TabPtsServiceCorpMap AS cm ON cm.clientid=wl.custom
 		INNER JOIN TabPtsServiceCorpList AS cl ON cl.corpid=cm.SysCorpID
 		--inner join WMSGoodsProdCode AS pc ON pc.listid=ul.listid
 		INNER JOIN WMSEPSCRECORD AS er ON (er.ListID= ul.listid AND er.ItemID=ul.ItemID) 
 		INNER JOIN goodsbaseinfo AS gb ON gb.goodsid=wi.GoodsID
 		
 		WHERE ul.listid=@listid  AND wl.CommTag=5 AND wl.ordertype=2
 		
 		IF (@@ROWCOUNT>0)
 		BEGIN 
 			SELECT * FROM #tt
 		SELECT @t1= Stuff((select ','+convert(NVARCHAR(MAX),a.yy) FROM (SELECT yy from #tt GROUP BY yy) a for xml path('')),1,1,'') 
 		
 		SELECT @t2= Stuff((select ','+convert(varchar(MAX),a.epsccode) from #tt a for xml path('')),1,1,'') 
 	    SELECT TOP 1
		CorpId,		--企业ID
		CorpCode,		--企业编码
		StoreId ,		--单据ID
		StoreNo,  --单据号
		StoreDate,  --单据时间
		StoreType,  ----单据类型 (写死)
		StoreTypeText, ---单据类型文本(写死)
		StoreMan,  --指派人 (委托人)
		BizCorpId,   --往来企业ID
		BizCorpCode,  --往来企业编码
		BizCorpName,     --往来企业名称 
		RecCorpId ,  --接受企业
		RecCorpCode,    --  接收企业编码
		RecCorpName ,   -- 接收企业名称                  	
		@t1 AS itemid,
		@t2 AS CodeId
 	    FROM #tt 
 	    
 		
 		
 			UPDATE TabPtsServiceUpLog 
	SET
		UpStatus = 5,
		UpTime = GETDATE()
	WHERE listid=@listid 
	END
 		ELSE
 			BEGIN 
	UPDATE wmsorderlist SET upsendstatus=0 WHERE listid=@listid 
	UPDATE TabPtsServiceUpLog 
	SET
		UpStatus = 5,
		UpTime = GETDATE()
	WHERE listid=@listid 
	SELECT '-1000','无码'
	END
 	END