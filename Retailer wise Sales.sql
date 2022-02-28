 with cte as (
 select h.zid,   xconfirmt   xdatecom,h.xdelivery,h.xwh,  h.xdelpoint,   
 (select xdistrict from cadelpoint where  zid=h.zid and xthana=h.xdelpoint) xdistrict, h.xsornum, h.xvehicle,h.xtypeloc,     
 h.xconfirmt,h.xchlnum,c.xbloodgrp,h.xcus,c.xorg ,h.xordernum,h.xsitemobile,h.xdelsite, o.xqtydel,o.xoutletname,o.xproprietor,o.xaddress, 
 h.xteam,coalesce((select xname from prmst where xemp=h.xteam and zid=h.zid),'NA') RINAME,                        
 coalesce((select max(xtsoid) from cacushrc where xriid=h.xteam),'NA') xtsoid ,  coalesce((select  xname from prmst where zid=h.zid     
 and  xemp=coalesce((select max(xtsoid) from cacushrc where xriid=h.xteam),'')),'NA') AINAME ,              
 d.xqtychl,d.xrate,d.xchgdel,d.xbonqty,CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) xdate from   opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum 
 join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where o.xcus<>'NA' and CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-04-01' and '2021-04-30'  and  h.xdiv in ('Dhaka','Out Dhaka')
and coalesce(h.xdornum,'')<>'Allocated'
 union all
 select h.zid, xconfirmt  xdatecom,h.xdelivery,h.xwh,  h.xdelpoint,   
 (select xdistrict from cadelpoint where  zid=h.zid and xthana=h.xdelpoint) xdistrict, h.xsornum, h.xvehicle,h.xtypeloc,     
 h.xconfirmt,h.xchlnum,c.xbloodgrp,h.xcus,c.xorg ,h.xordernum,h.xsitemobile,h.xdelsite,  o.xqtydel,o.xoutletname,o.xproprietor,o.xaddress, 
 h.xteam,coalesce((select xname from prmst where xemp=h.xteam and zid=h.zid),'NA') RINAME,                        
 coalesce((select max(xtsoid) from cacushrc where xriid=h.xteam),'NA') xtsoid ,  coalesce((select  xname from prmst where zid=h.zid     
 and  xemp=coalesce((select max(xtsoid) from cacushrc where xriid=h.xteam),'')),'NA') AINAME ,              
 d.xqty,0 xrate,0 xchgdel,0 xbonqty,CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) xdate from     opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum             
 join cacus c on c.zid=h.zid and c.xcus=h.xcus join caoutlet o  on h.zid=o.zid and h.xordernum=o.xid where o.xcus<>'NA' and  
CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-04-01' and '2021-04-30' and  h.xdiv in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated')

select xbloodgrp, xcus,xorg,xordernum,xoutletname,xproprietor,sum(xqtychl) from cte 
group by xbloodgrp,xcus,xorg,xordernum,xoutletname,xproprietor


with cte as (
select h.xcus,c.xorg,c.xbloodgrp xzone,h.xordernum outletID,o.xoutletname, d.xqtychl,month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) mnth,xteam,
case when month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=9 then d.xqtychl else 0 end September,
case when month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=10 then d.xqtychl else 0 end October from 
opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join  cacus c 
on h.zid=c.zid and h.xcus=c.xcus join caoutlet o on h.zid=o.zid and h.xordernum=o.xrow where  xsimcardno in ('Dhaka','Out Dhaka') 
and  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-09-01' and '2020-10-28'),cte2 as
(select xzone,xcus,xorg,outletID,xoutletname,max(xteam) xteam,sum(September) September,sum(October) October from cte
group by xzone,xcus,xorg,outletID,xoutletname)
select xzone,xcus,xorg,outletID,xoutletname,xteam,
(select xname from prmst where xemp=cte2.xteam and zid=100000),
(select xmobile1 from prmst where xemp=cte2.xteam and zid=100000), 
(select xempnew from opritargetdt where xyear=2020 and xper=10 and xemp=cte2.xteam and xemp<>'') AI,
(select xname from prmst where  zid=100000 and xemp=(select xempnew from opritargetdt where xyear=2020 and xper=10 and xemp=cte2.xteam and xemp<>'')) AINAME,
(select xmobile1 from prmst where  zid=100000 and xemp=(select xempnew from opritargetdt where xyear=2020 and xper=10 and xemp=cte2.xteam and xemp<>'')) AICOnt,
September,October from cte2



select * from Outlet where Phone in (
select tr from erp200.ERPonTheNet.dbo.tr3 where tr<>'') and shopno in ('29665','29823','6062') order by Phone

select * from erp200.ERPonTheNet.dbo.caoutlet  where xmobile in (
select tr from erp200.ERPonTheNet.dbo.tr3 where tr<>'') and xrow in ('29665','29823','6062') order by xmobile

SELECT     zid, xrow, xid, xoutletname, xremark, xproprietor, xmobile, xaddress, xcus, xriid, xqtydel
,CHARINDEX('+', xremark, 0),cast((replace(SUBSTRING(xremark,1,CHARINDEX('+', xremark, 0)),'+','')) as int)
FROM  update caoutlett set xqtydel=cast((replace(SUBSTRING(xremark,1,CHARINDEX('+', xremark, 0)),'+','')) as int)

SELECT     zid, xrow, xid, xoutletname,  xproprietor, xmobile, xaddress, xcus, xriid, xqtydel
,CHARINDEX('+', xremark, 0),cast((replace(SUBSTRING(xremark,1,CHARINDEX('+', xremark, 0)),'+','')) as int)
FROM  update caoutlett set xqtydel=cast((replace(SUBSTRING(xremark,1,CHARINDEX('+', xremark, 0)),'+','')) as int)

insert into caoutlet(zid,xrow,xid,xoutletname,xproprietor, xmobile, xaddress, xcus, xriid, xqtydel,xthana,xzone,xbloodgrp,xdistrict,xcode)
SELECT     zid, (select max(xrow) from caoutlet)+ROW_NUMBER() OVER (ORDER BY xoutletname),
'NRY-'+RIGHT('00000' + CAST((467+ROW_NUMBER() OVER (ORDER BY xoutletname)) AS varchar), 5) ,
 xoutletname,  xproprietor, xmobile, xaddress, xcus, xriid, xqtydel,'Narayanganj' xthana,'Narayanganj' xzone,
 (select xbloodgrp from cacus where zid=100000 and xcus=caoutlett.xcus) xbloodgrp,'Narayanganj' xdistrict,'NRY' xcode
FROM         caoutlett
WHERE     (xid = '')



with cte as (
select h.xchlnum,xdiv,h.xcus,d.xqtychl,xadvnum,(select xid from opadvice where xadvnum=h.xadvnum) xid,c.xzone from 
opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join cacus c on c.zid=h.zid and c.xcus=h.xcus
where xconfirmt between '2020-06-12 06:00:00' and '2020-06-13 06:00:00'  and xdiv in ('Dhaka','Out Dhaka') 
and (select xid from opadvice where xadvnum=h.xadvnum and xid<>'Shop_No')  IN (select xrow from caoutlet)
)
select xzone,SUM(xqtychl)/20,COUNT(distinct xid ) from cte
group by xzone


select h.xchlnum,xdiv,c.xzone,h.xcus,c.xorg ,h.xconfirmt,
d.xqtychl,xadvnum,(select xid from opadvice where xadvnum=h.xadvnum) xid,
(select xtrnnum from opadvice where xadvnum=h.xadvnum) from 
opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join cacus c on c.zid=h.zid and c.xcus=h.xcus
where xconfirmt between '2020-06-05 06:00:00' and '2020-06-11 06:00:00' and xdiv in ('Dhaka','Out Dhaka') and 
(select xid from opadvice where xadvnum=h.xadvnum and xid<>'Shop_No')  IN 
(select xrow from caoutlet where xproprietor='Dealer Own')

select h.xchlnum,c.xzone,h.xcus,c.xorg ,h.xconfirmt,
d.xqtychl,xadvnum,(select xid from opadvice where xadvnum=h.xadvnum) xid,
(select xtrnnum from opadvice where xadvnum=h.xadvnum) from 
opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join cacus c on c.zid=h.zid and c.xcus=h.xcus
where xconfirmt between '2020-06-12 06:00:00' and '2020-06-13 06:00:00'  and xdiv in ('Dhaka','Out Dhaka') and 
(select xid from opadvice where xadvnum=h.xadvnum and xid<>'Shop_No') not IN (select xrow from caoutlet)
union all
select h.xchlnum,c.xzone,h.xcus,c.xorg ,h.xconfirmt,
d.xqtychl,xadvnum,(select xid from opadvice where xadvnum=h.xadvnum) xid,
(select xtrnnum from opadvice where xadvnum=h.xadvnum) from 
opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join cacus c on c.zid=h.zid and c.xcus=h.xcus
where xconfirmt between '2020-06-12 06:00:00' and '2020-06-13 06:00:00' and xdiv in ('Dhaka','Out Dhaka') and 
(select xid from opadvice where xadvnum=h.xadvnum)='Shop_No'

select h.xconfirmt,h.xchlnum,c.xzone,h.xcus,c.xorg ,
--(select xoutletname from caoutlet where xrow=(select xid from opadvice where xadvnum=h.xadvnum)) xoutletname,
h.xteam,(select xname from prmst where xemp=h.xteam and zid=h.zid) RINAME,
(select xmobile1 from prmst where xemp=h.xteam and zid=h.zid) RImobile1,
(select xtsoid from cacushrc where xriid=h.xteam) xtsoid ,(select  xname from prmst where zid=h.zid
and  xemp=coalesce((select xtsoid from cacushrc where xriid=h.xteam),'')) AINAME ,(select  xmobile1 from prmst where zid=h.zid
and  xemp=coalesce((select xtsoid from cacushrc where xriid=h.xteam),'')) AImobile1 ,d.xqtychl from 
opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join cacus c on c.zid=h.zid and c.xcus=h.xcus
where xconfirmt>= '2020-06-11 06:00:00'  and xdiv in ('Dhaka','Out Dhaka') and 
(select xid from opadvice where xadvnum=h.xadvnum and xid<>'Shop_No') not IN (select xrow from caoutlet)
union all
select h.xconfirmt,h.xchlnum,c.xzone,h.xcus,c.xorg ,
--(select xoutletname from caoutlet where xrow=(select xid from opadvice where xadvnum=h.xadvnum)) xoutletname,
h.xteam,(select xname from prmst where xemp=h.xteam and zid=h.zid) RINAME,(select xmobile1 from prmst where xemp=h.xteam and zid=h.zid) RImobile1,
(select xtsoid from cacushrc where xriid=h.xteam) xtsoid ,(select  xname from prmst where zid=h.zid
and  xemp=coalesce((select xtsoid from cacushrc where xriid=h.xteam),'')) AINAME ,(select  xmobile1 from prmst where zid=h.zid
and  xemp=coalesce((select xtsoid from cacushrc where xriid=h.xteam),'')) AImobile1 ,d.xqtychl from 
opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join cacus c on c.zid=h.zid and c.xcus=h.xcus
where xconfirmt >='2020-06-11 06:00:00'  and xdiv in ('Dhaka','Out Dhaka') and 
(select xid from opadvice where xadvnum=h.xadvnum)='Shop_No'


select h.xconfirmt,h.xchlnum,c.xzone,h.xcus,c.xorg ,
(select xid from opadvice where xadvnum=h.xadvnum) xid,
(select xoutletname from caoutlet where xrow=(select xid from opadvice where xadvnum=h.xadvnum)) xoutletname,
h.xteam,(select xname from prmst where xemp=h.xteam and zid=h.zid) RINAME,
(select xtsoid from cacushrc where xriid=h.xteam) xtsoid ,(select  xname from prmst where zid=h.zid
and  xemp=coalesce((select xtsoid from cacushrc where xriid=h.xteam),'')) AINAME ,d.xqtychl from 
opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join cacus c on c.zid=h.zid and c.xcus=h.xcus
where xconfirmt >='2020-06-11 06:00:00' and xdiv in ('Dhaka','Out Dhaka') 
and (select xid from opadvice where xadvnum=h.xadvnum and xid<>'Shop_No')  IN (select xrow from caoutlet)


with cte as 
(select xzone,xqtychl,xordernum,xoutletname,coalesce((select max(xordernum) from opchallan202006
 where xdatecom<'2020-06-25' and xordernum=opretailsales.xordernum),'New') yesno from opretailsales where xdatecom='2020-06-25'
)
select xzone,sum(xqtychl)/20,count(*),sum(case when yesno='New' then 1 else 0 end) from cte
group by xzone

----------------------NCML Delivery--------------
select h.xchlnum,xconfirmt,c.xcus,xorg,xcuspo,xqtychl from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on h.zid=c.zid and h.xcus=c.xcus where xconfirmt between '2020-06-16 06:00:00.000' and '2020-06-17 06:00:00.000'
and xsimcardno<>'Corporate' order by xconfirmt

select h.xdate, sum(xqtychl)/20,count(*) from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on h.zid=c.zid and h.xcus=c.xcus where xconfirmt between '2020-06-18 06:00:00.000' and '2020-06-23 06:00:00.000'
and xsimcardno<>'Corporate' group by h.xdate

select xcuspo,coalesce((select max(xcuspo) from opchallan where xcuspo=h.xcuspo and xconfirmt<'2020-06-29 06:00:00.000'),'New'),sum(xqtychl)/20 from 
opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on h.zid=c.zid and h.xcus=c.xcus where xconfirmt between '2020-06-29 06:00:00.000' and '2020-06-30 06:00:00.000'
and xsimcardno<>'Corporate' group by xcuspo
-------------------------------------------------------------------------


select c.xzone,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xproprietor,o.xmobile,o.xriid,
(select xname from prmst where zid=o.zid and xemp=o.xriid),o.xqtydel,o.xqtychl,
coalesce((select sum(xqtychl) from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
where h.xordernum=o.xrow and  xconfirmt between '2020-06-11 06:00:00.000' and  '2020-07-18 06:00:00.000'),0),
coalesce((select max(xteam) from opchallan where xordernum=o.xrow and  xconfirmt 
between '2020-06-11 06:00:00.000' and  '2020-07-18 06:00:00.000'),'') from caoutlet o join cacus c
on o.zid=c.zid and o.xcus=c.xcus

