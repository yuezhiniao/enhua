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

--�ж��Ƿ���ƥ��
select @clientid =wl.Custom  FROM wmsorderlist wl WHERE listid=@listid 
SELECT @matchtype=matchtype FROM clientunit cu WHERE clientid=@clientid 

IF (@matchtype=2)
	BEGIN
 	SET @RetMsg= 'δƥ��'
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
 		wl.custom as CorpId,		--��ҵID
 		wl.CorpCode as CorpCode,		--��ҵ����
 		ul.listid AS StoreId ,		--����ID
 		wl.listcode AS StoreNo,  --���ݺ�
 		wl.maketime AS StoreDate,  --����ʱ��
 		'5' as StoreType,  ----�������� (д��)
 		'���۳���' AS StoreTypeText, ---���������ı�(д��)
		wl.consignor  as StoreMan,  --ָ���� (ί����)
 		cl.corpid   AS BizCorpId,   --������ҵID
 		cl.corpcode AS BizCorpCode,  --������ҵ����
        cl.corpname AS BizCorpName,     --������ҵ���� 
		wl.custom	AS RecCorpId ,  --������ҵ
 		wl.corpcode AS RecCorpCode,    --  ������ҵ����
 		wl.corpname AS RecCorpName ,   -- ������ҵ���� 
 		                             
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
		CorpId,		--��ҵID
		CorpCode,		--��ҵ����
		StoreId ,		--����ID
		StoreNo,  --���ݺ�
		StoreDate,  --����ʱ��
		StoreType,  ----�������� (д��)
		StoreTypeText, ---���������ı�(д��)
		StoreMan,  --ָ���� (ί����)
		BizCorpId,   --������ҵID
		BizCorpCode,  --������ҵ����
		BizCorpName,     --������ҵ���� 
		RecCorpId ,  --������ҵ
		RecCorpCode,    --  ������ҵ����
		RecCorpName ,   -- ������ҵ����                  	
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
	SELECT '-1000','����'
	END
 	END