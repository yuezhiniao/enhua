
---上传指令应答
ALTER  proc ProcPtsUploadAnswer 
@serviceid INT,
@ListID int, 
@RetCode varchar(10) OUTPUT , 
@RetMsg varchar(max) OUTPUT 
AS
SET NOCOUNT ON 
IF @retcode= '-1000'
	BEGIN
	UPDATE TabPtsServiceUpLog 
	SET
	UpStatus = 2,
	UpMsg = @retmsg,
	UpTime = GETDATE()
	WHERE listid=@listid 
	UPDATE wmsorderilist 
	SET upsendstatus=2
	WHERE listid=@listid 
	IF @@error!=0
	BEGIN
	SELECT -1000,'应答失败'
	RETURN
	END
	ELSE 
	SELECT 1000,'应答成功'	
	END
ELSE 
 	BEGIN  
	UPDATE TabPtsServiceUpLog
	SET
	UpStatus = 5,
	UpMsg = @retmsg,
	UpTime = GETDATE()
 	WHERE listid=@listid 
 	UPDATE wmsorderlist 
 	SET upsendstatus=5 
 	WHERE listid=@listid
 	IF @@error!=0
	BEGIN
	SELECT -1000,'应答失败'
	RETURN
	END
	ELSE 
	SELECT 1000,'应答成功'
 	END
 	