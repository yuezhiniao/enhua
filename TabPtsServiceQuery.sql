CREATE TABLE [dbo].[TabPtsServiceQuery](
	[ServiceQueryID] [int] NOT NULL,			-- 系统指令ID
	[ServiceID] [int] NOT NULL,					-- 系统ID
	[ProcTag] [int] NULL,						-- 处理标记0：待处理1:提取5:完成
	[QueryType] [int] NULL,						-- 指令类型
	[ServiceName] [varchar](200) NULL,			-- 服务名称
	[QueryString] [varchar](max) NULL,			-- 指令参数
	[RetCode] [varchar](10) NULL,				-- 返回码
	[RetMsg] [varchar](1000) NULL,				-- 返回信息
	[AnswerString] [varchar](max) NULL,			-- 应答数据
	[QueryTime] [datetime] NOT NULL,			-- 指令时间
	[AnswerTime] [datetime] NULL,				-- 应答时间
	[autoflag] [int] NOT NULL,					-- 自动处理标记
 CONSTRAINT [PK_TabPtsServiceQuery] PRIMARY KEY CLUSTERED 
(
	[ServiceQueryID] ASC
)
) ON [PRIMARY]

GO
