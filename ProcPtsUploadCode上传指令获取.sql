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

SELECT TOP 1 @listid=listid ,@itemid=ul.ItemID FROM TabPtsServiceUpLog AS ul WHERE ul.UpStatus=1 

EXEC ProcPtsUploadAnswer @ListID ,@ItemID,@RetCode OUTPUT,@RetMsg OUTPUT 

SELECT @RetCode,@RetMsg