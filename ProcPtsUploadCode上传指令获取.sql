-----�ϴ�ָ���ȡ
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

--�ж��Ƿ���ƥ��
SELECT @clientid =wl.Custom  FROM wmsorderlist wl WHERE listid=@listid 
SELECT * FROM TabPtsServiceCorpMap AS cm WHERE cm.ClientID=@clientid

IF (@@ROWCOUNT=0)
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
 		wl.BusiType as StoreType,  ----��������
 		wl.businame AS StoreTypeText, ---���������ı�
		wl.consignor  as StoreMan,  --ָ���� (ί����)
 		cl.corpid   AS BizCorpId,   --������ҵID
 		cl.corpcode AS BizCorpCode,  --������ҵ����
        cl.corpname AS BizCorpName,     --������ҵ���� 
		wl.custom	AS RecCorpId ,  --������ҵ
 		wl.corpcode AS RecCorpCode,    --  ������ҵ����
 		wl.corpname AS RecCorpName    -- ������ҵ����           
 		                             
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