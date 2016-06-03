USE [zbwms_EnHua]
GO

ALTER  proc [dbo].[ProcPtsSERVICE_LOGIN] 
	@ServiceID int,
	@ServiceTypeName nvarchar(50),
	@ServiceKey varchar(50),
	@IsActive int = 1,
	@ErrorMsg nvarchar(500) = '',
	@IPAddress VARCHAR(30) = ''
as 
	if @isactive = 1 
	begin 
		if not exists (select * from TabPtsServices where ServiceID = @ServiceID and ServiceKey = @ServiceKey)
			insert TabPtsServices (serviceID, ServiceTypeName, servicekey, activetime, lasterror, lasttime, ipaddress)
				values (@serviceid, @ServiceTypeName, @servicekey, getdate(), '', getdate(), @IPAddress)
		else 
			update TabPtsServices set activetime = getdate(), lasttime = getdate(), ipaddress = @IPAddress
				where ServiceID = @ServiceID and ServiceKey = @ServiceKey 
	end 
	else 
	begin 
		if not exists (select * from TabPtsServices where ServiceID = @ServiceID and ServiceKey = @ServiceKey)
			insert TabPtsServices (serviceID, ServiceTypeName, servicekey, activetime, lasterror,LastTime, ipaddress)
				values (@serviceid, @ServiceTypeName, @servicekey, null, @ErrorMsg, getdate(), @IPAddress)
		else 
			update TabPtsServices set activetime = null, lasttime = getdate(), lasterror = @ErrorMsg, ipaddress = @IPAddress
				where ServiceID = @ServiceID and ServiceKey = @ServiceKey
	end 
	select 1000,''