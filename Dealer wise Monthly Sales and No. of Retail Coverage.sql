with retail as (
select c.xbloodgrp xzone,c.xcus,c.xorg,h.xordernum xid,xconfirmt,h.xchlnum,(d.xqtychl) total,
case when year( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2020  and month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=8 then d.xqtychl else  0 end "AUG2020",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=9 then d.xqtychl else  0 end "SEP2020",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=10 then d.xqtychl else  0 end  "OCT2020",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=11 then d.xqtychl else  0 end  "NOV2020",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=12 then d.xqtychl else  0 end  "DEC2020",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=1 then d.xqtychl else  0 end "JAN2021",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2 then d.xqtychl else  0 end  "FEB2021",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3 then d.xqtychl else  0 end  "MAR2021",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=4 then d.xqtychl else  0 end  "APR2021",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=5 then d.xqtychl else  0 end  "MAY2021",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqtychl else  0 end  "JUN2021",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=7 then d.xqtychl else  0 end  "JUL2021"
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-08-01' and  '2021-07-31' and
coalesce(h.xdornum,'')<>'Allocated' 
 union all
 select  c.xbloodgrp xzone,c.xcus,c.xorg,d.xid,xconfirmt,h.xchlnum, (d.xqty) total,
case when year( d.xdate)=2020  and month( d.xdate)=8 then d.xqty else  0 end "AUG2020",
case when month(d.xdate)=9 then d.xqty else  0 end "SEP2020",
case when month(d.xdate)=10 then d.xqty else  0 end  "OCT2020",
case when month( d.xdate)=11 then d.xqty else  0 end  "NOV2020",
case when month(d.xdate)=12 then d.xqty else  0 end  "DEC2020",
case when month( d.xdate)=1 then d.xqty else  0 end "JAN2021",
case when month( d.xdate)=2 then d.xqty else  0 end  "FEB2021",
case when month( d.xdate)=3 then d.xqty else  0 end  "MAR2021",
case when month(d.xdate)=4 then d.xqty else  0 end  "APR2021",
case when month( d.xdate)=5 then d.xqty else  0 end  "MAY2021",
case when month(d.xdate)=6 then d.xqty else  0 end  "JUN2021",
case when month(d.xdate)=7 then d.xqty else  0 end  "JUL2021"
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate between '2020-08-01' and  '2021-07-31' and coalesce(h.xdornum,'')='Allocated' 
), ttt as (
select  a.xzone Zone_Name,a.xcus,a.xorg,a.xid,
sum(AUG2020) "AUG2020",sum(SEP2020) SEP2020,sum(OCT2020) OCT2020,sum(NOV2020) NOV2020,sum(DEC2020) DEC2020,SUM(JAN2021) JAN2021,
sum(FEB2021) FEB2021,sum(MAR2021) MAR2021,sum(APR2021) APR2021,sum(MAY2021) MAY2021,sum(JUN2021) JUN2021,sum(JUL2021) JUL2021,
case when sum(AUG2020)>0 then 1 else 0 end AUG2020R ,case when sum(SEP2020)>0 then 1 else 0 end SEP2020R ,
case when sum(OCT2020)>0 then 1 else 0 end OCT2020R ,case when sum(NOV2020)>0 then 1 else 0 end NOV2020R ,
case when sum(DEC2020)>0 then 1 else 0 end DEC2020R ,case when sum(JAN2021)>0 then 1 else 0 end JAN2021R ,
case when sum(FEB2021)>0 then 1 else 0 end FEB2021R ,case when sum(MAR2021)>0 then 1 else 0 end MAR2021R, 
case when sum(APR2021)>0 then 1 else 0 end APR2021R ,case when sum(MAY2021)>0 then 1 else 0 end MAY2021R,
case when sum(JUN2021)>0 then 1 else 0 end JUN2021R ,case when sum(JUL2021)>0 then 1 else 0 end JUL2021R from retail a 
--where a.xid not like 'CUS%'
group by  a.xzone ,a.xcus,a.xorg,a.xid
)
select  Zone_Name,xcus,xorg,sum(AUG2020) "AUG2020",sum(SEP2020) SEP2020,sum(OCT2020) OCT2020,sum(NOV2020) NOV2020,sum(DEC2020) DEC2020,SUM(JAN2021) JAN2021,
sum(FEB2021) FEB2021,sum(MAR2021) MAR2021,sum(APR2021) APR2021,sum(MAY2021) MAY2021,sum(JUN2021) JUN2021,sum(JUL2021) JUL2021,
sum(AUG2020R) "AUG2020R",sum(SEP2020R) SEP2020R,sum(OCT2020R) OCT2020R,sum(NOV2020R) NOV2020R,sum(DEC2020R) DEC2020R,
SUM(JAN2021R) JAN2021R,sum(FEB2021R) FEB2021R,sum(MAR2021R) MAR2021R,sum(APR2021R) APR2021R,sum(MAY2021R) MAY2021R,
sum(JUN2021R) JUN2021R,sum(JUL2021R) JUL2021R from ttt --where xcus='CUS-004885'
group by  Zone_Name,xcus,xorg