CREATE TABLE TabPtsServiceCommand (
	ServiceID INT ,  --9701
	ServiceTypeName VARCHAR(200),
	ServiceType int,
	LastExeTime DATETIME,  --�������ʱ��
	RunStatus	int	, --���н��
	Status INT ,		--״̬
	ProcSql  VARCHAR(1000),  --����
	Parameter  VARCHAR(200), --����
	Used  INT,			--�Ƿ����
	OpResult VARCHAR(200),--���н��
	OpType INT	,	 --����״̬   1��ʾָ���ȡ  2��ʾָ���Ҫ��ȡ 
	Memo   VARCHAR(200)    --��ע
	tem    int    --ʱ����
)

	
	
