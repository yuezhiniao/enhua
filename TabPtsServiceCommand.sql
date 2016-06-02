CREATE TABLE TabPtsServiceCommand (
	ServiceID INT ,  --9701
	ServiceTypeName VARCHAR(200),
	ServiceType int,
	LastExeTime DATETIME,  --最后运行时间
	RunStatus	int	, --运行结果
	Status INT ,		--状态
	ProcSql  VARCHAR(1000), --过程
	Parameter  VARCHAR(200),		--参数
	Used  INT,			--是否可用
	OpResult VARCHAR(200),--运行结果
	OpType INT	,	 --操作状态   1表示等待操作  2表示不用操作 
	Memo   VARCHAR(200)    --备注
	tem    int    --时间间隔
)

	
	
