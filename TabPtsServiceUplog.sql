CREATE TABLE [dbo].[TabPtsServiceUpLog](
	[ListID] [int] NOT NULL,			-- 订单ID
	[ItemID] [int] NOT NULL,			-- 明细ID ,如果按明细上传，需提供
	[UpStatus] [int] NULL,				-- 1:等待上传2：上传失败5：上传成功
	[UpMsg] [varchar](max) NULL,		-- 返回信息
	[UpTime] [datetime] NULL,			-- 上传时间
 CONSTRAINT [PK_TabPtsServiceUpLog] PRIMARY KEY CLUSTERED 
(
	[ListID] ASC,
	[ItemID] ASC
)
) ON [PRIMARY]

GO
