-------------RI AI wise Sales------------------------------
with cte as (
select c.xbloodgrp,c.xcus,c.xorg,h.xteam,
(select xname from prmst where xemp=h.xteam and zid=100000) RINAME,
(select xempnew from opritargetdt where xyear=2021 and xper=03 and xemp=h.xteam) AIID, 
(select xname from prmst where zid=100000 and xemp=(select xempnew from opritargetdt where xyear=2021 and xper=03  and xemp=h.xteam)) AINAME, 
sum(d.xqtychl) total from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus   
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-03-01' and '2021-03-31' and  c.xsimcardno in ('Dhaka','Out Dhaka') 
and coalesce(h.xdornum,'')<>'Allocated'   and c.xbloodgrp='FARIDPUR'
--and c.xbloodgrp in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
 group by c.xbloodgrp,c.xcus,c.xorg,h.xteam
 union all
 select c.xbloodgrp,c.xcus,c.xorg,d.xriid,
(select xname from prmst where xemp=d.xriid and zid=100000) RINAME,
(select xempnew from opritargetdt where xyear=2021 and xper=03 and xemp=d.xriid) AIID, 
(select xname from prmst where zid=100000 and xemp=(select xempnew from opritargetdt where xyear=2021 and xper=03 and xemp=d.xriid)) AINAME, 
sum(d.xqty) total from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-03-01' and '2021-03-31'  and  c.xsimcardno in ('Dhaka','Out Dhaka') 
and coalesce(h.xdornum,'')='Allocated'  and c.xbloodgrp='FARIDPUR' 
--and c.xbloodgrp='FARIDPUR' in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
 group by c.xbloodgrp,c.xcus,c.xorg,d.xriid
)
select  xteam,RINAME,AIID,AINAME,sum(total) from cte
group by xteam,RINAME,AIID,AINAME





with cte as (
select  year(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xyear , month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xper,
xteam,d.xqtychl xqtychl from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
where CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) between '2020-12-01' and '2021-02-28' and coalesce(h.xdornum,'')<>'Allocated'
--and c.xbloodgrp in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
 union all
 select year(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xyear , month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xper,
xteam,d.xqty xqtychl from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-12-01' and '2021-02-28' and coalesce(h.xdornum,'')='Allocated'
--and c.xbloodgrp in ('FARIDPUR','KUSHTIA','DHAKA NORTH','DHAKA MIDDLE','MYMENSINGH','NARAYANGONJ','BARISAL','KUSHTIA','FARIDPUR','JESSORE','GAZIPUR','KHULNA')
)
select  xyear,xper,xteam,sum(xqtychl)/20 xqtychl into risalesbijoyoff from cte
 group by  xyear,xper,xteam

---------------------------------------------------------------------------------------------

select  xzone,xemp,(select xname from prmst where zid=100000 and xemp=opritargetdt.xemp),
xempnew,(select xname from prmst where zid=100000 and xemp=opritargetdt.xempnew),
xziid,(select xname from prmst where zid=100000 and xemp=opritargetdt.xziid),xyear,xper,xqty,
(select xqtychl from risalesbijoyoff where xyear=opritargetdt.xyear and  xper=opritargetdt.xper and xteam=opritargetdt.xemp ) from opritargetdt
where xyear=2021 or (xyear=2020 and xper=12) and xzone not like '%corpo%'
order by xyear,xper,xzone,xemp

------------------------------------------------------
select xbloodgrp, xteam,(select xname from prmst where xemp=h.xteam and zid=100000),sum(d.xqtychl) xqtychl from  opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  
where  CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) between '2021-02-01' and '2021-02-28' 
and xteam not in (select xemp from opritargetdt where xyear=2021 and xper=02) and c.xsimcardno in ('Dhaka','Out Dhaka') 
group by xbloodgrp, xteam


with opchallans as (
select h.xdate,CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) as chldate,year(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))) xyear,
month(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))) xper,
h.xconfirmt,h.xchlnum,c.xcus,c.xsimcardno,c.xbloodgrp,c.xorg,h.xteam,h.xdelsite,h.xdelivery,
h.xdelpoint,h.xdestin,d.xqtychl,d.xbonqty,d.xdtwotax,d.xchgtot,d.xlineamt,d.xrate,d.xchgdel from opchallan h join opchalland d 
on h.zid=d.zid and h.xchlnum=d.xchlnum join cacus c  on h.zid=c.zid and h.xcus=c.xcus
where  (year(CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2021 and month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3)
)
, targets as (select  c.xdate,c.xyear,c.xper,c.xconfirmt,c.xchlnum,c.xcus,c.xsimcardno,c.xbloodgrp,c.xorg,c.xteam,c.xdelsite,c.xdelivery,
c.xdelpoint,c.xdestin,c.xqtychl,c.xbonqty,c.xdtwotax,c.xchgtot,c.xlineamt,c.xrate,c.xchgdel,
t.xordernum,t.xemp,t.xempnew,t.xziid,t.xzone,t.xqty,t.xyear tyear,t.xper tper,t.xamount,
case when t.xordernum is null then c.chldate else c.chldate end chldate2,c.chldate
from opritargetdt t  full outer join opchallans c on t.xemp=c.xteam and t.xyear=c.xyear
and t.xper=c.xper)
select * from targets where chldate2 between  DATEADD(DAY,1,EOMONTH(getdate(),-1)) and cast( getdate() as date) or
chldate2 between  DATEADD(DAY,1,EOMONTH(getdate()-30,-1)) and cast((DATEADD(month, -1, getdate())) as date) or
chldate2 between  DATEADD(DAY,1,EOMONTH(getdate()-365,-1)) and cast((DATEADD(year, -1, getdate())) as date)
select cast( getdate() as date), DATEADD(DAY,1,EOMONTH(getdate(),-1)),
DATEADD(DAY,1,EOMONTH(getdate()-30,-1)),cast((DATEADD(month, -1, getdate())) as date),
DATEADD(DAY,1,EOMONTH(getdate()-365,-1)),cast((DATEADD(year, -1, getdate())) as date)

--------------------------------------------------------------------------------------
create view targetvssales as with opchallans as (
select h.xdate,CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) as chldate,year(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))) xyear,
month(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))) xper,
h.xconfirmt,h.xchlnum,c.xcus,c.xsimcardno,c.xbloodgrp,c.xorg,h.xteam,h.xdelsite,h.xdelivery,
h.xdelpoint,h.xdestin,d.xqtychl,d.xbonqty,d.xdtwotax,d.xchgtot,d.xlineamt,d.xrate,d.xchgdel from opchallan h join opchalland d 
on h.zid=d.zid and h.xchlnum=d.xchlnum join cacus c  on h.zid=c.zid and h.xcus=c.xcus
where  (year(CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2021 and month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3)
)
, targets as 
(select  coalesce(c.xconfirmt,'') xconfirmt,coalesce(c.xchlnum,'') xchlnum,coalesce(c.xcus,'') xcus,
coalesce(c.xsimcardno,c.xsimcardno) xdiv,coalesce(c.xbloodgrp,t.xzone) xzone,coalesce(c.xorg,'') xorg,
coalesce(c.xdelsite,'') xdelsite,coalesce(c.xdelivery,'') xdelivery,coalesce(c.xdelpoint,'') xdelpoint,coalesce(c.xdestin,'') xdestin,
coalesce(c.xqtychl,0) xqtychl,coalesce(c.xbonqty,0) xbonqty ,coalesce(c.xdtwotax,0) xdtwotax , coalesce(c.xchgtot,0) xchgtot ,
coalesce(c.xlineamt,0) xlineamt ,coalesce(c.xrate,0) xrate ,coalesce(c.xchgdel,0) xchgdel ,
coalesce(t.xordernum,'')xordernum,case when t.xordernum is null then c.xteam when  c.xdate is null then t.xemp else c.xteam end xriid,
coalesce(t.xempnew,'') xaiid,coalesce(t.xziid,'') xziid,coalesce(t.xqty,0) xqty,coalesce(t.xamount,0) xamount,
case when t.xordernum is null then c.chldate when  c.xdate is null then datefromparts(t.xyear, t.xper, 01) else c.chldate end xdate,
case when t.xordernum is null then c.xyear when  c.xdate is null then t.xyear else c.xyear end xyear,
case when t.xordernum is null then c.xper when  c.xdate is null then t.xper else c.xper end xper
from opritargetdt t full outer join opchallans c on t.xemp=c.xteam and t.xyear=c.xyear and t.xper=c.xper) 
select *,day(getdate()) dysexp,DAY(EOMONTH(xdate)) totdys from targets where  -- xdate is null
(xdate between  DATEADD(DAY,1,EOMONTH(getdate(),-1)) and cast( getdate() as date) or
xdate between  DATEADD(DAY,1,EOMONTH(getdate()-30,-1)) and cast((DATEADD(month, -1, getdate())) as date) or
xdate between  DATEADD(DAY,1,EOMONTH(getdate()-365,-1)) and cast((DATEADD(year, -1, getdate())) as date)) 














    