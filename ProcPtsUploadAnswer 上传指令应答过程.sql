USE [zbwms_EnHua]
GO

ALTER  proc ProcPtsUploadAnswer 
@ListID int, 
@ItemID int, 
@RetCode varchar(10) OUTPUT , 
@RetMsg varchar(max) OUTPUT 
AS
SET NOCOUNT ON 
DECLARE @clientid int
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
	WHERE listid=@listid AND ItemID=@itemid 
	UPDATE wmsorderitems SET upsendstatus=4 WHERE listid=@listid AND ItemID=@itemid
	END
 ELSE 
 	BEGIN  
 		SELECT w.EPSCCode FROM WMSEPSCRECORD AS w WHERE w.ListID=@listid AND w.itemid=@itemid
 		IF (@@ROWCOUNT>0)
 		BEGIN 
	SET @RetMsg= '回传成功'
	SET @RetCode= 1000
	UPDATE TabPtsServiceUpLog
	SET
		UpStatus = 5,
		UpMsg = @retmsg,
		UpTime = GETDATE()
 		WHERE listid=@listid AND ItemID=@itemid
 		
 		UPDATE wmsorderitems SET upsendstatus=5 WHERE listid=@listid AND ItemID=@itemid
 	END
 	ELSE
	BEGIN
	SET @RetMsg= '无码'
	SET @RetCode= -1000
	UPDATE TabPtsServiceUpLog 
	SET
		UpStatus = 2,
		UpMsg = @retmsg,
		UpTime = GETDATE()
	WHERE listid=@listid AND ItemID=@itemid 
	UPDATE wmsorderitems SET upsendstatus=0 WHERE listid=@listid AND ItemID=@itemid
	END
	END