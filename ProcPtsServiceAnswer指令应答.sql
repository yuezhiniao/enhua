----Ö¸ÁîÓ¦´ð
CREATE proc  ProcPtsServiceAnswer 
	@ServiceID int,
	@QueryID int, 
	@RetCode varchar(10), 
	@RetMsg varchar(1000), 
	@AnswerData varchar(max)
AS
SET NOCOUNT ON 
IF @QueryID=1115 
BEGIN
	EXEC ProcPtsUploadCode 9701
	
END


