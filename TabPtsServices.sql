
CREATE TABLE [dbo].[TabPtsServices] (
[ServiceID] int NOT NULL ,
[ServiceTypeName] varchar(50) NULL ,
[ServiceKey] varchar(50) NOT NULL ,
[ActiveTime] datetime NULL ,
[LastError] varchar(500) NULL ,
[LastTime] datetime NULL ,
[IPADDRESS] varchar(30) NULL 
)


GO

-- ----------------------------
-- Indexes structure for table WMSServices
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table WMSServices
-- ----------------------------
ALTER TABLE [dbo].[TabPtsServices] ADD PRIMARY KEY ([ServiceID], [ServiceKey])
GO
