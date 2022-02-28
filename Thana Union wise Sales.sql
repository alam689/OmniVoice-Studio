
with retail as (
select o.xzone,o.xdistrict,o.Xthana,o.xbazar,o.xid,o.xoutletname,h.xcus,c.xorg,o.xriid, 
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=1 then d.xqtychl else  0 end "JAN",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2 then d.xqtychl else  0 end  "FEB",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3 then d.xqtychl else  0 end  "MAR",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=4 then d.xqtychl else  0 end  "APR",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=5 then d.xqtychl else  0 end  "MAY",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqtychl else  0 end  "JUN",(d.xqtychl) total
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-01-01' and '2021-06-30' and
c.xbloodgrp='Gazipur' and coalesce(h.xdornum,'')<>'Allocated' 
 union all
 select o.xzone,o.xdistrict,o.Xthana,o.xbazar,o.xid,o.xoutletname,h.xcus,c.xorg,o.xriid, 
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=1 then d.xqty else  0 end "JAN",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2 then d.xqty else  0 end  "FEB",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3 then d.xqty else  0 end  "MAR",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=4 then d.xqty else  0 end  "APR",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=5 then d.xqty else  0 end  "MAY",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqty else  0 end  "JUN",(d.xqty) total
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-01-01' and '2021-06-30' and 
c.xbloodgrp='Gazipur' and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone,a.xdistrict,a.Xthana,a.xbazar,a.xid,a.xoutletname,a.xcus,a.xorg,a.xriid, 
(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AI_ID,(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name1,
sum(JAN) JAN,sum(FEB) FEB, sum(MAR) MAR,sum(APR) APR,sum(MAY) MAY, sum(JUN) JUN
 from retail a  group by a.xzone,a.xdistrict,a.Xthana,a.xbazar,a.xid,a.xoutletname,a.xcus,a.xorg,a.xriid