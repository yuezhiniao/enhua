CREATE TABLE [dbo].[TabPtsServiceCorpList](
	[SysID] [int] IDENTITY(1,1) NOT NULL,--系统自动生成单位ID
	[ServiceID] [int] NULL,-- 外部系统ID
	[CorpID] [varchar](50) NULL,-- 外部系统单位ID
	[CorpCode] [varchar](50) NULL,-- 外部系统单位编码
	[CorpName] [nvarchar](100) NULL,-- 单位名称
	[SpellCode] [varchar](50) NULL, -- 拼音码
	[MatchType] int  NULL --状态
 CONSTRAINT [PK_TabPtsServiceCorpList] PRIMARY KEY CLUSTERED 
(
	[SysID] ASC
)) ON [PRIMARY]
