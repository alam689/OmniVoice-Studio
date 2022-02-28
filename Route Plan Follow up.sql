with cte as (
select xzone,(select xname from prmst where xemp=routep.xziid)+'-'+xziid ZI,
(select xname from prmst where xemp=routep.xtsoid)+'-'+xtsoid AI,
(select xmobile1 from prmst where xemp=routep.xtsoid) AI_Contact,
(select xname from prmst where xemp=routep.xriid)+'-'+xriid RI_Name,
(select xmobile1 from prmst where xemp=routep.xtsoid) RI_Contact,20 TOBE,count(*) Routeplan,
sum(case when xstatus=1 then 1 else 0 end) Verifiied --,sum(case when xstatusjob=1 then 1 else 0 end) Called
from routep
where xname ='WED'  and xzone not in ('Office Sales','CHITTAGONG-02')-- and (select xmobile1 from prmst where xemp=routep.xtsoid)<>''
group by  xzone,xziid,xtsoid,xriid
)
select * from cte

with cte as (
select xzone,(select xname from prmst where xemp=routep.xziid)+'-'+xziid ZI,
(select xname from prmst where xemp=routep.xtsoid)+'-'+xtsoid AI,
(select xmobile1 from prmst where xemp=routep.xtsoid) AI_Contact,xriid,
(select xname from prmst where xemp=routep.xriid) RI_Name,20 TOBE,count(*) Routeplan,
sum(case when xstatus=1 then 1 else 0 end) Verifiied,
sum(case when xstatusjob=1 then 1 else 0 end) Called from routep
where xname='THU'  and xzone not in ('Office Sales','CHITTAGONG-02')-- and (select xmobile1 from prmst where xemp=routep.xtsoid)<>''
group by  xzone,xziid,xtsoid,xriid
)
select xzone,ZI,(select count(distinct xemp) from opritargetdt where xyear=2021 and xper=6 and xzone=cte.xzone)*20,
sum(Routeplan),sum(Verifiied),sum(Called) from cte group by xzone,ZI



select xzone,xid,xriid,xtsoid,xziid,(select xempnew from opritargetdt where xyear=2021 and xper=6 and xemp=caoutlet.xriid) from caoutlet
where xtsoid<>(select xempnew from opritargetdt where xyear=2021 and xper=6 and xemp=caoutlet.xriid)

select xzone,xid,xriid,xtsoid,xziid,(select xziid from opritargetdt where xyear=2021 and xper=6 and xemp=caoutlet.xriid) from caoutlet
where xziid<>(select xziid from opritargetdt where xyear=2021 and xper=6 and xemp=caoutlet.xriid)

select xcus,xzone,(select xbloodgrp from cacus where xcus=caoutlet.xcus) from caoutlet
where xcus<>'NA' and xzone<> (select xbloodgrp from cacus where xcus=caoutlet.xcus)

select xzone,xemp,xempnew,xziid,(select xname from prmst where xemp=opritargetdt.xziid) from   opritargetdt
where xyear=2021 and xper=6 and xemp='002075'

select xzone,xriid,xtsoid,xziid,(select xname from prmst where xemp=cacushrc.xziid) from   cacushrc where xriid='002075'

with cte as
(
select xzone,xtsoid,xriid,count(distinct xid) "Retail",0 verified from routep
group by xzone,xtsoid,xriid
union all
select xzone,xtsoid,xriid,0,count(distinct xid) verified from routep where xstatus=1
group by xzone,xtsoid,xriid
)
select xzone,(select xname from prmst where xemp=(select xziid from cazone where xzone=cte.xzone)) ZI_Name1,
(select xtsoid from cacushrc where xriid=cte.xriid) AI_ID,
(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=cte.xriid)) AI_Name,xriid ,
(select xname from prmst where xemp=cte.xriid) RI_Name,
sum(Retail),sum(verified) from cte --where (select xtsoid from cacushrc where xriid=cte.xriid)<>xtsoid
group by xzone,xtsoid,xriid


with cte as
(
select xzone,count(distinct xid) "Retail",0 verified from routep
group by xzone
union all
select xzone,0 "Retail",count(distinct xid) verified from routep where xstatus=1
group by xzone
)
select xzone,sum(Retail),sum(verified) from cte
group by xzone


select xdate,count(distinct xriid),count(*),count(*)/count(distinct xriid) from outletcalllog group by xdate order by xdate


with cte as (
select  ROW_NUMBER() OVER (PARTITION BY xriid ORDER BY xintime DESC) AS rn,
xriid,xid,(select xolat from caoutlet where xid=outletcalllog.xid) xolat,
(select xolong from caoutlet where xid=outletcalllog.xid) xolong,
(select xaddress from caoutlet where xid=outletcalllog.xid) xaddress,
(select Xthana from caoutlet where xid=outletcalllog.xid) Xthana,
(select xdistrict from caoutlet where xid=outletcalllog.xid) xdistrict,
(select xzone from caoutlet where xid=outletcalllog.xid) xzone from outletcalllog
where xdate>='2021-06-01' and calltype='A'  )
SELECT xriid,(select xname from prmst where xemp=cte.xriid),
(select xmobile1 from prmst where xemp=cte.xriid), xolat,xolong,
(select xaddress from caoutlet where xid=cte.xid),Xthana,xdistrict,xzone
FROM cte
WHERE rn = 1 and xzone not like 'CHITTAGONG%' order by xzone,xdistrict,Xthana


with cte as
(
select xzone,xtsoid,xriid,count(distinct xid) "Retail",0 verified from routep
group by xzone,xtsoid,xriid
union all
select xzone,xtsoid,xriid,0,count(distinct xid) verified from routep where xstatus=1
group by xzone,xtsoid,xriid
)
select xzone,(select xname from prmst where xemp=(select xziid from cazone where xzone=cte.xzone)) ZI_Name1,
(select xtsoid from cacushrc where xriid=cte.xriid) AI_ID,
(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=cte.xriid)) AI_Name,xriid ,
(select xname from prmst where xemp=cte.xriid) RI_Name,120,
sum(Retail),sum(verified) from cte --where (select xtsoid from cacushrc where xriid=cte.xriid)<>xtsoid
where xzone in (select xzone from cazone where xregion='South Bengal' )
group by xzone,xtsoid,xriid



