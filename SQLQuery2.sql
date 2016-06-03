SELECT 
 		wl.custom as CorpId,		--企业ID
 		wl.CorpCode as CorpCode,		--企业编码
 		ul.listid AS StoreId ,		--单据ID
 		wl.listcode AS StoreNo,  --单据号
 		wl.maketime AS StoreDate,  --单据时间
 		'5' as StoreType,  ----单据类型 (写死)
 		'销售出库' AS StoreTypeText, ---单据类型文本(写死)
		wl.consignor  as StoreMan,  --指派人 (委托人)
 		cl.corpid   AS BizCorpId,   --往来企业ID
 		cl.corpcode AS BizCorpCode,  --往来企业编码
        cl.corpname AS BizCorpName,     --往来企业名称 
		wl.custom	AS RecCorpId ,  --接受企业
 		wl.corpcode AS RecCorpCode,    --  接收企业编码
 		wl.corpname AS RecCorpName ,   -- 接收企业名称 
 		                             
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


DECLARE @varCursor Cursor --声明游标变量
DECLARE @a   INT 
DECLARE @b VARCHAR(200)              

DECLARE yyy CURSOR FOR --创建游标

SELECT TOP 10 listid,listcode FROM wmsorderlist

OPEN yyy --打开游标

SET @varCursor=yyy --为游标变量赋值

--FETCH NEXT FROM @varCursor --从游标变量中读取值

WHILE @@FETCH_STATUS=0 --判断FETCH语句是否执行成功
{
BEGIN

FETCH NEXT FROM @varCursor INTO @a, @b  --读取游标变量中的数据
SELECT @a,@b
END
}
CLOSE @varCursor --关闭游标

DEALLOCATE @varCursor; --释放游标
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