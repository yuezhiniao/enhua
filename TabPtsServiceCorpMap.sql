CREATE TABLE [dbo].[TabPtsServiceCorpMap](
	[ServiceID] [int] NOT NULL,		--系统ID
	[SysCorpID] [int] NOT NULL,		--系统自动生成单位ID
	[ClientID] [int] NOT NULL,		--wms单位ID
 CONSTRAINT [PK_TabPtsServiceCorpMap] PRIMARY KEY CLUSTERED 
(
	[ServiceID] ASC,
	[SysCorpID] ASC,
	[ClientID] ASC
)
) ON [PRIMARY]
