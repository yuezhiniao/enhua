-----上传指令获取
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
DECLARE @clientid int

SELECT TOP 1 @listid=listid ,@itemid=ul.ItemID FROM TabPtsServiceUpLog AS ul WHERE ul.UpStatus=1 

--判断是否已匹配
SELECT @clientid =wl.Custom  FROM wmsorderlist wl WHERE listid=@listid 
SELECT * FROM TabPtsServiceCorpMap AS cm WHERE cm.ClientID=@clientid

IF (@@ROWCOUNT=0)
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
 		wl.BusiType as StoreType,  ----单据类型
 		wl.businame AS StoreTypeText, ---单据类型文本
		wl.consignor  as StoreMan,  --指派人 (委托人)
 		cl.corpid   AS BizCorpId,   --往来企业ID
 		cl.corpcode AS BizCorpCode,  --往来企业编码
        cl.corpname AS BizCorpName,     --往来企业名称 
		wl.custom	AS RecCorpId ,  --接受企业
 		wl.corpcode AS RecCorpCode,    --  接收企业编码
 		wl.corpname AS RecCorpName    -- 接收企业名称           
 		                             
 		FROM TabPtsServiceUpLog AS ul
 		inner join wmsorderlist AS wl ON wl.ListID=ul.ListID
 		INNER JOIN wmsorderitems AS wi ON (wi.listid=ul.listid AND wi.itemid=ul.ItemID)
 		--INNER JOIN clientunit as cu ON cu.clientid=wl.custom
 		INNER JOIN TabPtsServiceCorpMap AS cm ON cm.clientid=wl.custom
 		INNER JOIN TabPtsServiceCorpList AS cl ON cl.corpid=cm.SysCorpID
 		INNER JOIN WMSEPSCRECORD AS er ON (er.ListID= ul.listid AND er.ItemID=ul.ItemID)
 		WHERE ul.listid=@listid  AND wl.CommTag=5 AND ordertype=2
 		
 		IF (@@ROWCOUNT>0)
 		BEGIN 
	
	UPDATE TabPtsServiceUpLog
	SET
		UpStatus = 1,
		UpMsg = @retmsg,
		UpTime = GETDATE()
 		WHERE listid=@listid 
 
 	END
 	ELSE
	BEGIN

	UPDATE TabPtsServiceUpLog 
	SET
		UpStatus = 4,
		UpMsg = @retmsg,
		UpTime = GETDATE()
	WHERE listid=@listid AND ItemID=@itemid 
	UPDATE wmsorderlist SET upsendstatus=0 WHERE listid=@listid 
	END
	END