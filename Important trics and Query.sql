--Group by Data using column and XML PATH	
SELECT StudentName,STUFF((SELECT ', ' + Course + ' by ' + CAST(Instructor AS VARCHAR(MAX)) + ' in Room No ' + CAST(RoomNo AS VARCHAR(MAX))FROM rnd_stuffxmlpath WHERE (StudentName = c.StudentName) FOR XML PATH ('')) ,1,2,'') AS NameValues FROM rnd_stuffxmlpath c GROUP BY StudentName
--Department wise Employee name
SELECT xdept,STUFF((SELECT ', Name: '  + CAST(xname AS VARCHAR(MAX))FROM prmst WHERE (xdept = c.xdept) FOR XML PATH ('')) ,1,2,'') AS NameValues FROM prmst c GROUP BY xdept
--Customer wise last Transaction
SELECT d.xcus,h.xdate,d.xitem FROM opodt d join opord h on d.zid=h.zid and d.xordernum=h.xordernum JOIN(SELECT xcus, MAX(xdate) dt FROM opord GROUP BY xcus ) x On x.xcus = d.xcus And x.dt = h.xdate order by 1
--Sub total and grand total in SQL
select  CASE GROUPING(h.xcus) WHEN 1 THEN 'ALL' ELSE h.xcus END AS 'XCUS',CASE GROUPING(d.xitem) WHEN 1 THEN 'ALL' ELSE  d.xitem  END AS 'xitem',sum(d.xqtychl),sum(d.xlineamt) from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum where year(h.xconfirmt)=2018 and month(h.xconfirmt) in (1,2,3) and h.xcus = 'CUS-000015' group by h.xcus, d.xitem with rollup  
--Sub total and grand total in SQL 2
select  h.xcus , d.xitem ,sum(d.xqtychl),sum(d.xlineamt) from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum where year(h.xconfirmt)=2018 and month(h.xconfirmt) in (1,2,3) and h.xcus = 'CUS-000015' group by h.xcus, d.xitem with rollup  
--kill session (Oracle)
BEGIN FOR C IN (SELECT S.SID SID, S.SERIAL# SERIAL FROM V$LOCKED_OBJECT L, V$SESSION S WHERE L.SESSION_ID = S.SID) LOOP    EXECUTE IMMEDIATE ('ALTER SYSTEM KILL SESSION ''' || C.SID || ',' || C.SERIAL || ''''); END LOOP; END;
--DB_LINK (Oracle)
CREATE PUBLIC DATABASE LINK TESTDBLINK  CONNECT TO ACIS  IDENTIFIED BY <PWD>  USING '(description=(address=(protocol=TCP)(host=192.168.0.6)(port=1521))(connect_data=(sid=shakti)))';
--SHOW DATA FROM DBLINK (Oracle)
select *from tab@testdblink  select * from EMPBASICINFO A, EMPLOYEE@testdblink B  WHERE A.EMPID=B.EMP_ID
--GRANT ALL
FOR x IN (SELECT * FROM user_tables) LOOP    EXECUTE IMMEDIATE 'GRANT ALL ON ' || x.table_name || ' TO <<someone>>'; END LOOP;
--CMD CONNECT WITH IP
ACIS/ACIS@192.168.0.6:1521/shakti
--Random Number Generate
select cast((Abs(Checksum(NewId()))%10) as varchar(1)) + char(ascii('a')+(Abs(Checksum(NewId()))%25)) + char(ascii('A')+(Abs(Checksum(NewId()))%25)) +left(newid(),5)
--Auto Increment Number(Group wise)
select c.ztime,c.zutime,c.zid,xcus,c.xdistrict, c.xdestin, ROW_NUMBER () OVER (PARTITION BY xcus ORDER BY xcus) AS xrow,coalesce(xwh,'FINISHED GOODS')from cacuscorrt c  where c.xcus='CUS-000164'
--Auto Increment
SELECT xcus, ROW_NUMBER() OVER (ORDER BY xcus) AS New_Id FROM cacomslab where xcus='CUS-000005' and xtype='Realistic Commission'
--Duplicate record delete
WITH cte AS (SELECT *,ROW_NUMBER() OVER(PARTITION BY xlocation ORDER BY xlocation)'RowRank'  FROM test) select * from cte --delete from cte WHERE RowRank > 1 
--convert data
CONVERT(varchar(100), Cast(xcheque as decimal(38, 0)))
--SQL Text
SELECT * FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest where dest.text like '%opord%' ORDER BY deqs.last_execution_time DESC
--Row count of objects
SELECT t.name, s.row_count from sys.tables t JOIN sys.dm_db_partition_stats s ON t.object_id = s.object_id AND t.type_desc = 'USER_TABLE' AND t.name not like '%dss%' AND s.index_id IN (0,1)
--Padding
SELECT 'CUS-'+RIGHT('000000' + CAST(cusid AS varchar), 6),RIGHT('000000' + CAST(ri AS varchar), 6) from retailerdatabase
--Remove Leading Zero or spaces
SELECT Replace(Ltrim(Replace('00078708', '0', ' ')), ' ', '0') ,Ltrim(rtrim(xbloodgrp))
--Update using temptable
with toupsdateee as (select c.*, 'L-'+cast(ROW_NUMBER() OVER (ORDER BY xemp) AS varchar(10)) secnum from prleave c where  xtrnnum='') --  update toupdate set xtrnnum=secnum
--Exponential to Varchar
CAST(0 AS VARCHAR)+LTRIM(STR(mob,32))
--Update using Common table expression
with cte as (select xadvnum,dumzid,xtrnnum,'M'+cast((87309+ROW_NUMBER() OVER (ORDER BY xadvnum))as varchar) AS New_Id  from opadvice where xtrnnum is null and dumzid is null) update cte set xtrnnumcc=New_Id
--Child Table
select object_name(parent_object_id), object_name(referenced_object_id) from sys.foreign_keys WHERE object_name(referenced_object_id) ='TableName'
--VIew Using CTE
CREATE VIEW vcte AS WITH cte (zid,xcus,xqtchl) AS (SELECT zid,xcus,xqtydel/20 xqtydel FROM   cacus ) select * from cte
--Replace & stuff
  select xcus,xorg,xzone,xfphone, STUFF(xfphone, 1, 2, ''),replace(xfphone,'-','')  from cacus
  --Select a random row with MySQL:
  SELECT column FROM table ORDER BY RAND() LIMIT 1
  --Select a random row with PostgreSQL:
  SELECT column FROM table ORDER BY RANDOM() LIMIT 1
  --Select a random row with Microsoft SQL Server:
  SELECT TOP 1 column FROM table  ORDER BY NEWID()
  --Select a random row with IBM DB2
  SELECT column, RAND() as IDX   FROM table   ORDER BY IDX FETCH FIRST 1 ROWS ONLY
  --Select a random record with Oracle:
  SELECT column FROM  ( SELECT column FROM table  ORDER BY dbms_random.value )  WHERE rownum = 1
  --Select a random row with sqlite:
  SELECT column FROM table   ORDER BY RANDOM() LIMIT 1
  --Add Column  ALTER TABLE opordexception ADD  zflag BIT NOT NULL DEFAULT 0;
 --Random Number insert in a table
 DECLARE @val AS INT = 1;  WHILE @val <= 1000      BEGIN          INSERT tr (tr)          --SELECT CONVERT(VARCHAR(8), RIGHT(NEWID(), 8)) ;    SELECT  LEFT(CAST(RAND()*1000000000+999999 AS INT),8) ;           SET @val = @val + 1;      END  SELECT tr,LEN(tr),DATENAME(WEEKDAY,ABS(CHECKSUM(NEWID()))%7 + 1) AS RandomDay,   RIGHT('00000000' + CAST(tr AS varchar), 8) paddingwith_zero,    RIGHT('XXXXXXXX' + CAST(tr AS varchar), 8) paddingwith_alphabet  FROM    tr where LEN(tr)<>8  
 --Random Number
 select LEFT(CONVERT(VARCHAR(36),NEWID()),4)+RIGHT(CONVERT(VARCHAR(36),NEWID()),8)
 --Exclude some character
 select  replace(replace(replace(newid(),'6','X'),'1','X'),'0','X')
 --Dateformat
 SELECT FORMAT (getdate(), 'yyyyMMddhhmmss') as date,FORMAT (getdate(), 'yyyy-MM-dd') as date,FORMAT (getdate(), 'hh:mm:ss') as date,FORMAT (xdate, 'yyyyddMM') as varchar,FORMAT (xdate, 'hhmmss') as varchar 
 --View Defination
 SELECT  definition FROM sys.sql_modules WHERE object_id= object_id('vzitargetachv');
 --Yesterday,Six Month Before
 select GETDATE(),DATEADD(mm, DATEDIFF(mm, 0, GETDATE()) - 6, 0) sixmnthbefore, DATEADD(hh, DATEDIFF(hh, 0, GETDATE()) - 6, 0) sixhrbfore,CONVERT(date,(GETDATE()-1)) YesterdayDate  , DATEADD(day, -1, CAST(GETDATE() AS date)) AS YesterdayDate, DATEADD(D,-1,DATEDIFF(D,0,GETDATE())) YesterdayDate,DATEADD(D,0,DATEDIFF(D,0,GETDATE())) TodayDatefromgetdate
 --Distance using LAt long
 select xid,xoutletname,xolat,xolong, SQRT(POWER(69.1 * ( @destinationLatitude - @sourceLatitude),    2) + POWER(69.1 * ( @sourceLongitude  - @destinationLongitude ) * COS(@destinationLatitude / 57.3), 2)) from  caoutlet where xolat>0
 --Distance using LAt long
 select xid,xoutletname,xolat,xolong, SQRT(POWER(69.1 * (xolat - 24.052992),    2) + POWER(69.1 * ( 89.042238  - xolong ) * COS(xolat/ 57.3), 2)) from  caoutlet where xolat>0
 --Distance using LAt long As Meter
 Select geography::Point(@SourceLAT, @SourceLONG, 4326).STDistance(geography::Point(@DestinationLAT, @DestinationLONG, 4326)) as Meters
 --Distance using LAt long As Mile
 Select (geography::Point(@SourceLAT, @SourceLONG, 4326).STDistance(geography::Point(@DestinationLAT, @DestinationLONG, 4326)))/1609.344 as Miles
 --Wild Card Search
 select * from zxaccess where xalist LIKE '%[[]%' or select * from zxaccess where xalist LIKE '%![%' ESCAPE '!'
 --Sequence Generate in PostgreSQL
 SELECT CAST(2021 AS text)||'-'||LPAD( CAST(8 AS text),2,'0')||'-'||LPAD(CAST(generate_series(1, 100) as text),5,'0')
 --Sequence Generate in SQL Server
 WITH SeqOfNumbers (NumSeq)AS (  -- Anchor member definition  SELECT 1 UNION ALL  -- Recursive member definition  SELECT NumSeq + 1 FROM SeqOfNumbers sn WHERE sn.NumSeq < 100)  -- Statement that executes the CTE  SELECT cast(year(getdate()) as varchar)+'-'+cast(month(getdate()) as varchar)+'-'+cast(NumSeq as varchar) As NumberSeq FROM SeqOfNumbers OPTION (MAXRECURSION 32767);  
 --Nth Hieghest or lowest or n rows SQL Server
 SELECT xemp, xname, xdtwotax FROM prmst ORDER BY xdtwotax DESC OFFSET 1 ROWS FETCH FIRST 1 ROWS ONLY;SELECT xemp, xname, xdtwotax FROM prmst ORDER BY xdtwotax DESC OFFSET 0 ROWS FETCH FIRST 1 ROWS ONLY;
 --Nth Hieghest or lowest or n rows PostgreSQL
 SELECT xordernum,xappamt FROM opord ORDER BY xappamt DESC LIMIT 1 OFFSET 1;
 --Extract Numeric from Alphanumeric
   CREATE FUNCTION dbo.udf_GetNumeric  (@strAlphaNumeric VARCHAR(256))  RETURNS VARCHAR(256)  AS  BEGIN  DECLARE @intAlpha INT  SET @intAlpha = PATINDEX('%[^0-9]%', @strAlphaNumeric)  BEGIN  WHILE @intAlpha > 0  BEGIN  SET @strAlphaNumeric = STUFF(@strAlphaNumeric, @intAlpha, 1, '' )  SET @intAlpha = PATINDEX('%[^0-9]%', @strAlphaNumeric )  END  END  RETURN ISNULL(@strAlphaNumeric,0)  END  GO  SELECT dbo.udf_GetNumeric('B2C Salary Payout via WEB to 01875557586 - Mohammad Abu Manjur') AS 'asdf1234a1s2d3f4@@@';
--Find position then find nth String from a field
substring(xremark,patindex('%0%',xremark) ,11) 
--Merge Query
MERGE category t       USING category_staging s  ON (s.category_id = t.category_id)  WHEN MATCHED      THEN UPDATE SET           t.category_name = s.category_name,          t.amount = s.amount  WHEN NOT MATCHED BY TARGET       THEN INSERT (category_id, category_name, amount)           VALUES (s.category_id, s.category_name, s.amount)  WHEN NOT MATCHED BY SOURCE       THEN DELETE;
--Sequence Generate in SQL Server Alternative
WITH Nums AS  (  SELECT n = ROW_NUMBER() OVER (ORDER BY [object_id])   FROM sys.all_objects)  SELECT n FROM Nums WHERE n BETWEEN 1 AND 1000 ORDER BY n;


