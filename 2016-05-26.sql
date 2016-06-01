IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE ID=OBJECT_ID('WmsOrderList') AND NAME='UpSendStatus') 
SELECT 1
ELSE 
	SELECT 2
ALTER TABLE TabPtsServiceCorpList  add MatchType INT NULL;--哈药追溯系统上传标记。0:无码，1:有码需上传，2：上传失败，4：单位未匹配，5：上传成功
 ALTER TABLE clientunit  add MatchType INT NULL
 ALTER TABLE TabPtsServiceCorpList DROP COLUMN matchtype 
 ALTER TABLE TabPtsServiceCorpMap DROP COLUMN used
SELECT TOP 100 upsendstatus , * FROM wmsorderlist WHERE upsendstatus 
BEGIN TRAN 
ALTER TABLE wmsorderlist ADD  UpSendStatus INT NULL 
COMMIT TRAN

SELECT * FROM interinfolist a 
LEFT JOIN systeminfo b ON a.infoid=b.infoid
SELECT * FROM SystemInfo AS si 
SELECT * FROM WMSORDERLIST AS w WHERE w.BusiType=21
SELECT * FROM WMSORDERITEMS AS w 
WMS_Cold_Q_WmsRefrigerantContainer_List 1,',0' 
v6_GOODS_MAINTAIN_SELECT_QRY 1,'2015-01-26,2016-05-26,0,,0,0'  

SELECT * FROM SYSCOLUMNS WHERE ID=OBJECT_ID('WmsOrderList') AND NAME='UpSendStatus' 
Wms_Store_Items 1,',0,'
SELECT * FROM clientunit WHERE clientname LIKE '%恩华%' and used =1 and iscustom=1
SELECT * FROM TabPtsServiceUpLog AS tpsul 
SELECT matchtype ,* FROM TabPtsServiceCorpList AS tpscl WHERE 
 select TOP 10 *  from wmsepscrecord 
 FROM EPSCRECORD AS e 
 FROM wmsgoodsre (益萨林)
  DECLARE @a VARCHAR (200)
  DECLARE @sql VARCHAR (200)
  SET @a ='阿莫西林片' 
SET   @sql ='SELECT TOP 10 * FROM GoodsBaseInfo AS gbi WHERE goodsname LIKE' + '%'+@a+'%'
 FROM eps  
 
 INSERT INTO tabptsservicecorplist(CorpName)  SELECT clientname
        FROM clientunit WHERE  clientname LIKE '%哈药%' and used =1 
        
   SELECT *  FROM TabPtsServiceCorpMap AS tpscm 
   SELECT *  FROM TabPtsServiceCorpList AS l WHERE l.ServiceID=110 AND l.CorpID=322
        
        
        ProcPtsServiceCorpList9701 1,''
        EXEC  ProcPtsServiceCorpMatchList9701 1,',0'
        ProcPtsServiceCorpMatch9701 1,111,323,214 
        ProcPtsServiceCorpDismatch9701 1,111,323,214
        
        
        ALTER table tabptsservicecorpmap ADD USED INT NULL 
        UPDATE      TabPtsServiceCorpMap
        SET USED =1 
        
        SELECT  cu.IsCustom,cl.ServiceID,cl.CorpID,cu.clientid 
FROM 
tabptsservicecorplist AS cl 
INNER JOIN  clientunit AS cu ON cu.clientname =cl.CorpName 
WHERE  cl.serviceid=111 AND cl.corpid=323  AND cu.USED=1 AND cu.IsCustom 

SELECT  cu.ClientName,cu.clientid ,cl.corpname,cl.ServiceID,cl.CorpID,(case when cl.matchtype=1 THEN '已匹配' else  '未匹配' end) statu
    FROM clientunit cu
    left JOIN TabPtsServiceCorpList AS cl ON cl.corpname=cu.clientname 
WHERE clientname LIKE '%哈药%' 

SELECT * FROM clientunit WHERE clientid IN (205,21294)
UPDATE clientunit SET matchtype = 2 
SELECT TOP 1000  matchtype  FROM clientunit WHERE matchtype  
SELECT * FROM tabptsserviceuplog 

ProcPtsServiceUploadQuery9701 1,'2015-05-24,2016-05-27,,,,,' 
UPDATE wmsorderlist SET upsendstatus=0 WHERE listid<388628
SELECT * FROM wmsorderlist ORDER BY up  DESC 


SELECT  wl.listid ,wi.itemid,waveid AS upstatus ,wl.Custom  
  FROM  wmsorderlist wl 
INNER JOIN WMSORDERITEMS AS wi ON wl.listid=wi.listid 

WHERE wl.UpSendStatus IS NULL AND wl.CommTag=5 
if EXISTS( SELECT listid,waveid FROM WMSEPSCRECORD AS w WHERE waveid=194422 )
  ALTER TABLE wmsorderitems ADD upsendstatus INT NULL 
  
  CREATE INDEX yy
ON WMSEPSCRECORD (listid)
SELECT * FROM TabPtsServiceUpLog AS tpsul 
DELETE  TabPtsServiceUpLog WHERE listid <388662 
UPDATE TabPtsServiceUpLog
SET
	
	SELECT * FROM WMSORDERLIST AS w WHERE listid=211184
	SELECT 
	SELECT w2.upsendstatus FROM wmsorderlist w
	INNER JOIN wmsorderitems w2  ON w.listid =w2.listid 
	 WHERE custom =20953
	
	SELECT clientid ,clientno FROM clientunit WHERE clientname LIKE  '%哈药%'  
	SELECT 1 ,custom,corpname FROM wmsorderlist WHERE corpname LIKE  '%哈药%'
	SELECT * FROM TabPtsServiceUpLog AS ul WHERE ul.UpStatus=2
	    ProcPtsServiceCorpList9701 1,'' 
        EXEC  ProcPtsServiceCorpMatchList9701 1,',2'
      EXEC   ProcPtsServiceCorpMatch9701 1,110,322,21294
        ProcPtsServiceCorpDismatch9701 1,111,323,214 
        ProcPtsServiceAutoUpload9701 1   --插入上传表
        ProcPtsUploadCode 1              --自动获取上传指令
        DELETE FROM TabPtsServiceUpLog 
        
        
	
	
	
