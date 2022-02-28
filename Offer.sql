
select * from opchallan where CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2020-12-01'  and xshipcode='Vessel' 
and xchlnum in (select xchlnum from opchallanalc) and coalesce(xdornum,'')<>'Allocated'
--update opchallan set xdornum='Allocated' where CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2020-12-01'  and xshipcode='Vessel' 
--and xchlnum in (select xchlnum from opchallanalc) and coalesce(xdornum,'')<>'Allocated'

with cte as (
select c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,
(select xname from prmst where xemp=o.xriid and zid=100000) RINAME,
(select xempnew from opritargetdt where xyear=2020 and xper=12 and xemp=o.xriid) AIID, 
(select xname from prmst where zid=100000 and xemp=(select xempnew from opritargetdt where xyear=2020 and xper=12 and xemp=o.xriid)) AINAME, 
sum(d.xqtychl) total from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xrow
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-01-01' and '2021-01-02' and  c.xsimcardno in ('Dhaka','Out Dhaka') 
and coalesce(h.xdornum,'')<>'Allocated'
--and c.xbloodgrp in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
 group by c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid
 union all
 select c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,
(select xname from prmst where xemp=o.xriid and zid=100000) RINAME,
(select xempnew from opritargetdt where xyear=2020 and xper=12 and xemp=o.xriid) AIID, 
(select xname from prmst where zid=100000 and xemp=(select xempnew from opritargetdt where xyear=2020 and xper=12 and xemp=o.xriid)) AINAME, 
sum(d.xqty) total from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-01-01' and '2021-01-02' and  c.xsimcardno in ('Dhaka','Out Dhaka') 
and coalesce(h.xdornum,'')='Allocated'
--and c.xbloodgrp in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
 group by c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid
)
select  xbloodgrp,xcus,xorg,xrow,xid,xoutletname,xthana,xdistrict,xriid,RINAME,AIID,AINAME,sum(total) total,
(select xqty from caoutlettarget where xid=cte.xid),(select xtype from caoutlettarget where xid=cte.xid) from cte
group by xbloodgrp,xcus,xorg,xrow,xid,xoutletname,xthana,xdistrict,xriid,RINAME,AIID,AINAME


 select  xbloodgrp xzone,h.xcus,c.xorg,'' OutletID,'',xcuspo,'','', max(xteam),(select xname from prmst where xemp=max(xteam)),'','',
sum(case when xconfirmt between '2020-09-02 06:00:00.000' and '2020-10-01 06:00:00.000' then xqtychl else 0 end ) SEP,
sum(case when xconfirmt between '2020-10-01 06:00:00.000' and '2020-11-01 06:00:00.000' then xqtychl else 0 end ) OCT,
sum(case when xconfirmt between '2020-11-01 06:00:00.000' and '2020-11-17 06:00:00.000' then xqtychl else 0 end ) NOV,
sum(xqtychl) from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on h.zid=c.zid and h.xcus=c.xcus where xconfirmt between '2020-09-02 06:00:00.000' and '2020-11-17 06:00:00.000'
and xsimcardno<>'Corporate' 
group by xbloodgrp,h.xcus,c.xorg,xcuspo


with cte as
(select xdiv,xzone,xteam xemp,(select xempnew from opritargetdt where xyear=2020 and xper=11 and xemp=opchallandt.xteam) xempnew,
COUNT(distinct xrow) xrow,(select xqty from opritargetdt where xyear=2020 and xper=11 and xemp=opchallandt.xteam) xqty,
SUM(xqtychl)/20 xqtychl from opchallandt where xdatecom between  '2020-11-01' and '2020-11-15' 
and xdiv in ('Dhaka','Out Dhaka','Corporate') 
--and xzone in ('MYMENSINGH','NILPHAMARI') 
--and xrow not in (select xrow from opchallandt where xdatecom between  '2020-09-02' and '2020-09-13' and xdiv in ('Dhaka','Out Dhaka') )
group by xdiv,xzone,xteam 
union all 
select xsimcardno xdiv,xzone,xemp,xempnew,0 xrow,xqty,0 xqtychl from opritargetdt where xyear=2020 and xper=11 and 
xemp not in (select xteam from opchallan where xdatecom between  '2020-11-01' and '2020-11-15' and xdiv in ('Dhaka','Out Dhaka','Corporate') ))
select xdiv,xzone,xemp,(select xname from prmst where xemp=cte.xemp and zid=100000),
(select xmobile1 from prmst where xemp=cte.xemp and zid=100000),xempnew,
(select xname from prmst where xemp=cte.xempnew and zid=100000),
sum(xrow),sum(xqty),sum(xqtychl) from cte where  xdiv in ('Dhaka','Out Dhaka') 
group by  xdiv,xzone,xemp,xempnew

select xzone,COUNT(distinct xrow),SUM(xqtychl)/20,sum((case when xshipcode='Vessel' then xqtychl else 0 end)/20) from opchallandt 
where xdatecom between  '2021-01-01' and '2021-01-01' and xdiv in ('Dhaka','Out Dhaka') 
--and xrow not in (select xrow from opchallandt where xdatecom between  '2020-09-02' and '2020-10-06' and xdiv in ('Dhaka','Out Dhaka') )
group by xzone order by xzone

select xbloodgrp,COUNT(distinct xcuspo),sum(xqtychl)/20,sum((case when xshipcode='Vessel' then xqtychl else 0 end)/20)
from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join cacus c on h.zid=c.zid and h.xcus=c.xcus 
where xconfirmt between '2021-01-01 06:00:00.000' and '2021-01-02 06:00:00.000' and xsimcardno<>'Corporate'  group by xbloodgrp

select xcuspo,sum(xqtychl)/20 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on h.zid=c.zid and h.xcus=c.xcus where xconfirmt between '2020-09-05 06:00:00.000' and '2020-09-06 06:00:00.000'
and xsimcardno<>'Corporate'  and xcuspo not in (select xcuspo from opchallan where xconfirmt between '2020-09-02 06:00:00.000' 
and '2020-09-05 06:00:00.000' and xsimcardno<>'Corporate' ) group by xcuspo

with cte as (
select c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,
(select xname from prmst where xemp=o.xriid and zid=100000) RINAME,
(select xempnew from opritargetdt where xyear=2020 and xper=11 and xemp=o.xriid) AIID, 
(select xname from prmst where zid=100000 and xemp=(select xempnew from opritargetdt where xyear=2020 and xper=11 and xemp=o.xriid)) AINAME, 
sum(d.xqty)/20 total from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-01-01' and '2021-01-02' and  c.xsimcardno in ('Dhaka','Out Dhaka') 
--and coalesce(h.xdornum,'')='Allocated'
--and c.xbloodgrp in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
 group by c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid
)
select  xbloodgrp,count(distinct xid),sum(total) total from cte group by xbloodgrp

--------------------------------------Retail Target setup--------------------------------------
with cte as (
select c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,
sum(d.xqtychl) total from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xrow
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-10-01' and '2020-11-30' and  c.xsimcardno in ('Dhaka','Out Dhaka') 
and coalesce(h.xdornum,'')<>'Allocated'
--and c.xbloodgrp in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
 group by c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid
 union all
 select c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,
sum(d.xqty) total from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-10-01' and '2020-11-30' and  c.xsimcardno in ('Dhaka','Out Dhaka') 
and coalesce(h.xdornum,'')='Allocated'
--and c.xbloodgrp in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
 group by c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid
)
select  getdate(),100000,xid,xrow,max(xcus),max(xriid),2020,12,sum(total) total from cte where xbloodgrp  in ('BARISAL','KHULNA')
group by xid,xrow


SELECT        ztime, zid, xid, xrow, xcus, xriid, xyear, xper, xqtydel,xqty,
case when xqtydel between 50 and 700  then 900 when xqtydel between 701 and 1000  then 1200 when xqtydel between 1001 and 1200  then 1500
when xqtydel between 1201 and 1500  then 1800 when xqtydel between 1501 and 2000  then 2400 when xqtydel between 2001 and 2400  then 3000
when xqtydel between 2401 and 3500  then 4500 when xqtydel between 3501 and 4500  then 6000 when xqtydel between 4501 and 6000  then 7500
when xqtydel between 6001 and 7500  then 9000 when xqtydel between 7501 and 9000  then 12000 when xqtydel between 9001 and 12000  then 15000
when xqtydel between 12001 and 15000  then 18000 when xqtydel between 15001 and 17000  then 20000 when xqtydel between 17001 and 20000  then 24000 else 0 end
FROM            caoutlettarget order by xqtydel




with cte as (
select o.zid,o.xzone,o.xcus,o.xrow,o.xid,o.xoutletname,o.xproprietor, o.xmobile, o.xthana,o.xdistrict,o.xriid,
year(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xyear,month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xper,
(select xname from prmst where xemp=o.xriid and zid=100000) RINAME,
(select xempnew from opritargetdt where xyear=2021 and xper=02  and xemp=o.xriid) AIID, 
(select xname from prmst where zid=100000 and xemp=(select xempnew from opritargetdt where xyear=2021 and xper=02  and xemp=o.xriid)) AINAME, 
d.xqtychl total from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-12-01' and '2021-02-26'  and  o.xdiv in ('Dhaka','Out Dhaka')
and coalesce(h.xdornum,'')<>'Allocated'
--and c.xbloodgrp in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
 --group by c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid
 union all
 select o.zid,o.xzone,o.xcus,o.xrow,o.xid,o.xoutletname,o.xproprietor, o.xmobile,o.xthana,o.xdistrict,o.xriid,
 year(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xyear,month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xper,
(select xname from prmst where xemp=o.xriid and zid=100000) RINAME,(select xempnew from opritargetdt where xyear=2021 and xper=02 and xemp=o.xriid) AIID, 
(select xname from prmst where zid=100000 and xemp=(select xempnew from opritargetdt where xyear=2021 and xper=02 and xemp=o.xriid)) AINAME, 
d.xqty total from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum join caoutlet o on h.zid=o.zid and d.xid=o.xid
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-12-01' and '2021-02-26' and  o.xdiv in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated'
--and c.xbloodgrp in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
 --group by c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid
)
select cte.xzone,cte.xcus,c.xorg,xrow,cte.xid,xoutletname,xproprietor,cte.xmobile,xthana,cte.xdistrict,xriid,RINAME,AIID,AINAME,sum(total) xqtychl,
0 xqty,(select xtype from caoutlettarget where xid=cte.xid) xtype  from cte
join cacus c on c.xcus=cte.xcus 
group by cte.xzone,cte.xcus,c.xorg,xrow,cte.xid,xoutletname,xproprietor,cte.xmobile,xthana,cte.xdistrict,xriid,RINAME,AIID,AINAME

 select  xbloodgrp xzone,h.xcus,c.xorg,'' OutletID,'',xcuspo,'',(
select max(xmobile) from caoutlet where xdesc=h.xcuspo),'','', max(xteam),(select xname from prmst where xemp=max(xteam)),'','',
sum(xqtychl) from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on h.zid=c.zid and h.xcus=c.xcus where xconfirmt between '2020-09-02 06:00:00.000' and '2020-11-17 06:00:00.000'
and xsimcardno<>'Corporate' 
group by xbloodgrp,h.xcus,c.xorg,xcuspo


---------------------Loyel Retailer------------------------------------------------
with cte as (
select o.zid,o.xzone,o.xcus,o.xrow,o.xid,o.xoutletname,o.xproprietor, o.xmobile, o.xthana,o.xdistrict,o.xriid,
year(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xyear,month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xper,
(select xname from prmst where xemp=o.xriid and zid=100000) RINAME,
(select xempnew from opritargetdt where xyear=2021 and xper=02  and xemp=o.xriid) AIID, 
(select xname from prmst where zid=100000 and xemp=(select xempnew from opritargetdt where xyear=2021 and xper=02  and xemp=o.xriid)) AINAME, 
d.xqtychl total from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-12-01' and '2021-02-27' and  o.xdiv in ('Dhaka','Out Dhaka')
and coalesce(h.xdornum,'')<>'Allocated'
--and c.xbloodgrp in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
 --group by c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid
 union all
 select o.zid,o.xzone,o.xcus,o.xrow,o.xid,o.xoutletname,o.xproprietor, o.xmobile,o.xthana,o.xdistrict,o.xriid,
 year(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xyear,month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xper,
(select xname from prmst where xemp=o.xriid and zid=100000) RINAME,(select xempnew from opritargetdt where xyear=2021 and xper=02 and xemp=o.xriid) AIID, 
(select xname from prmst where zid=100000 and xemp=(select xempnew from opritargetdt where xyear=2021 and xper=02 and xemp=o.xriid)) AINAME, 
d.xqty total from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum join caoutlet o on h.zid=o.zid and d.xid=o.xid
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-12-01' and '2021-02-27' and  o.xdiv in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated'
--and c.xbloodgrp in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
 --group by c.xbloodgrp,c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid
)
select cte.xzone,cte.xcus,c.xorg,xrow,cte.xid,xoutletname,xproprietor,cte.xmobile,xthana,cte.xdistrict,xriid,RINAME,AIID,AINAME,
sum(case when xper=12 then total else 0 end),sum(case when xper=1 then total else 0 end) ,sum(case when xper=2 then total else 0 end),
(select xqty from caoutlettarget where xid=cte.xid) xqty  from cte
join cacus c on c.xcus=cte.xcus 
group by cte.xzone,cte.xcus,c.xorg,xrow,cte.xid,xoutletname,xproprietor,cte.xmobile,xthana,cte.xdistrict,xriid,RINAME,AIID,AINAME
having sum(case when xper=12 then total else 0 end)>=200 and sum(case when xper=1 then total else 0 end)>=200
and sum(case when xper=2 then total else 0 end)>0
-------------------------CTG--------------------------------------------------------
with cte as (
 select  xbloodgrp xzone,h.xcus,c.xorg,'' OutletID,'' f ,xcuspo,'' a ,(
select max(xmobile) from caoutlet where xdesc=h.xcuspo) xmobile,'' b,'' c, xteam,
(select xname from prmst where xemp=(xteam)) xname,'' d ,'' e,
year(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xyear,month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xper,
 xqtychl from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on h.zid=c.zid and h.xcus=c.xcus where xconfirmt between'2020-12-01 06:00:00.000' and '2021-02-28 06:00:00.000'
and xsimcardno<>'Corporate' 
)
select xzone,xcus,xorg,OutletID,f ,xcuspo, a , xmobile, b, c, xteam,
(select xname from prmst where xemp=(xteam)) xname, d , e,
sum(case when xper=12 then xqtychl else 0 end),sum(case when xper=1 then xqtychl else 0 end) ,
sum(case when xper=2 then xqtychl else 0 end) from cte
group by xzone,xcus,xorg,OutletID,f ,xcuspo, a , xmobile, b, c, xteam,d , e 
having sum(case when xper=12 then xqtychl else 0 end)>=200 and sum(case when xper=1 then xqtychl else 0 end)>=200
and sum(case when xper=2 then xqtychl else 0 end)>0

select xzone, xcus, xorg, xrow, xid, xoutletname, xproprietor, xmobile, xthana, xdistrict, xriid, RINAME, AIID, AINAME, count(*) from brandoffer
where xyear=2020 and xper  in (6,7,8,9,10,11)
and xrow  not in (select xrow from brandoffer where (xyear=2020 and xper=12) or (xyear=2021 and xper=1))
group by xzone, xcus, xorg, xrow, xid, xoutletname, xproprietor, xmobile, xthana, xdistrict, xriid, RINAME, AIID, AINAME
select xrow from brandoffer where (xyear=2020 and xper=12) or (xyear=2021 and xper=1)


:Retention rate:
with cte as (
select o.xzone,o.xcus,o.xorg,o.xrow,count(*) conts,sum(o.xqtychl) xqtychl,
(select count(1) from brandoffer where xrow=o.xrow and xyear=2020 and xper=12) decm
from brandoffer o where xyear=2020 and xper between 9 and 9 
group by xzone,xcus,xorg,xrow )
select xzone,count(*),sum(decm),(sum(decm)*100)/count(*) from cte
group by xzone order by 4
