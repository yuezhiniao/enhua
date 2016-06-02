--指令获取
CREATE PROC ProcPtsServiceQuery 
@ServiceID INT
AS 
SET NOCOUNT ON 
DECLARE @QueryID int
DECLARE @RetCode varchar(10)
DECLARE @RetMsg varchar(1000)
DECLARE	@AnswerData varchar(max)
DECLARE @lasttime DATETIME 
DECLARE @tem DATETIME 


DECLARE ci CURSOR FOR
SELECT serviceid,servicetype,lastexetime,tem
FROM tabptsservicecommand sc 
WHERE sc.serviceid= @ServiceID AND sc.optype=1 AND USED=1
OPEN ci 
	FETCH NEXT FROM ci INTO @ServiceID, @QueryID  ,@lasttime,@tem
	WHILE (@@FETCH_STATUS = 0)
	BEGIN 
		print @lasttime
		print getdate()
		IF (@lasttime IS NULL OR abs(DATEDIFF(minute, @lasttime, GETDATE())) >= @tem) ---时间间隔控制
	    
	    exec ProcPtsServiceAnswer @ServiceID , @QueryID , @RetCode , @RetMsg , @AnswerData 
        waitfor delay '00:00:02'
		FETCH NEXT FROM ci INTO @ServiceID, @QueryID  ,@lasttime,@tem
		END 
	CLOSE ci 
	DEALLOCATE ci	