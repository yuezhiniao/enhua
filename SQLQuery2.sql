SELECT 
 		wl.custom as CorpId,		--��ҵID
 		wl.CorpCode as CorpCode,		--��ҵ����
 		ul.listid AS StoreId ,		--����ID
 		wl.listcode AS StoreNo,  --���ݺ�
 		wl.maketime AS StoreDate,  --����ʱ��
 		'5' as StoreType,  ----�������� (д��)
 		'���۳���' AS StoreTypeText, ---���������ı�(д��)
		wl.consignor  as StoreMan,  --ָ���� (ί����)
 		cl.corpid   AS BizCorpId,   --������ҵID
 		cl.corpcode AS BizCorpCode,  --������ҵ����
        cl.corpname AS BizCorpName,     --������ҵ���� 
		wl.custom	AS RecCorpId ,  --������ҵ
 		wl.corpcode AS RecCorpCode,    --  ������ҵ����
 		wl.corpname AS RecCorpName ,   -- ������ҵ���� 
 		                             
 		convert(varchar,wi.goodsid )  +'|'+   -- productId
 		wi.GoodsCode   +'|' +         --productCode
 		gb.goodsname  +'|'+         -- productName
 		gb.unit  +'|'+              -- productUnit
 		 convert(varchar,gb.ProviderID)  +'|'+       -- produceCorpId
 		gb.ProduceArea   +'|'+         -- produceCorpName
 		wi.BatchNo   +'|'+          --produceBatchNo
 		''  +'|' +              --displayAmount
 		''  +'|'+               -- displayProductUnit
 		convert(varchar,wi.Amount)  ,     -- amount
 		wi.itemid , er.EPSCCode 
 		
 		FROM TabPtsServiceUpLog AS ul
 		inner join wmsorderlist AS wl ON wl.ListID=ul.ListID
 		INNER JOIN wmsorderitems AS wi ON (wi.listid=ul.listid)
 		--INNER JOIN clientunit as cu ON cu.clientid=wl.custom
 		INNER JOIN TabPtsServiceCorpMap AS cm ON cm.clientid=wl.custom
 		INNER JOIN TabPtsServiceCorpList AS cl ON cl.corpid=cm.SysCorpID
 		--inner join WMSGoodsProdCode AS pc ON pc.listid=ul.listid
 		INNER JOIN WMSEPSCRECORD AS er ON (er.ListID= ul.listid AND er.ItemID=ul.ItemID) 
 		INNER JOIN goodsbaseinfo AS gb ON gb.goodsid=wi.GoodsID
 		
 		WHERE ul.listid=380027  AND wl.CommTag=5 AND wl.ordertype=2 
 		
 		SELECT TOP 100 t.listid  ,max(CASE WHEN listid =t.listid THEN itemid ELSE '6' END )listid 
 		 FROM (select listid FROM  wmsorderitems ) AS t
 		
 		
 		select listid ,goodsid, max(case itemid when 1 then itemid else 0 end) [itemid],max(case itemid when 2 then itemid else 0 end) [itemid]
 		 from wmsorderitems where listid=380027 
 		group by listid,goodsid
 		
 		
 		declare @sql varchar(8000)
set @sql = 'select listid '
select @sql = @sql + ' , max(case convert(varchar,goodscode when ''' + goodscode + ''' then goodsid else 0 end) [' + goodscode + ']'
from (select distinct goodscode from wmsorderitems) as a
set @sql = @sql + ' from  wmsorderitems where listid=380027 group by listid'
print (@sql)
exec(@sql)  


SELECT otcode, CASE when t.otid=otid THEN businame ELSE '2222' END y
FROM WMSOrderType AS t 
DECLARE @a INT 
DECLARE @b INT 
DECLARE @c VARCHAR(100)
DECLARE @d VARCHAR(100)
SELECT @a=COUNT(1)FROM wmsordertype

SET @b=0
WHILE (@b<@a )BEGIN
              	
 @d=1
SELECT @c=otid  FROM wmsordertype WHERE USED=@d
 END


DECLARE @varCursor Cursor --�����α����
DECLARE @a   INT 
DECLARE @b VARCHAR(200)              

DECLARE yyy CURSOR FOR --�����α�

SELECT TOP 10 listid,listcode FROM wmsorderlist

OPEN yyy --���α�

SET @varCursor=yyy --Ϊ�α������ֵ

--FETCH NEXT FROM @varCursor --���α�����ж�ȡֵ

WHILE @@FETCH_STATUS=0 --�ж�FETCH����Ƿ�ִ�гɹ�
{
BEGIN

FETCH NEXT FROM @varCursor INTO @a, @b  --��ȡ�α�����е�����
SELECT @a,@b
END
}
CLOSE @varCursor --�ر��α�

DEALLOCATE @varCursor; --�ͷ��α�
                       --
                       DECLARE @t VARCHAR(MAX)
  SELECT @t=( SELECT ','+convert(varchar,serviceid)  FROM WMSServices  for xml PATH('') )
  SELECT @t
select Stuff((select ','+convert(varchar,P_lsm) from person a for xml path('')),1,1,'') yy 
select(select ','+convert(varchar,P_lsm)  from person a for xml path('')) yy
IF 1=1
SELECT 1 

ELSE 2=2
	SELECT 3
	
	SELECT * FROM person AS p WHERE p.WORK_NO='1129'
	SELECT * FROM TabPtsServiceUpLog AS tpsul WHERE upstatus=5 
	SELECT * FROM TabPtsServiceCommand AS tpsc 
	EXEC ProcPtsServiceQuery
		@ServiceID = null