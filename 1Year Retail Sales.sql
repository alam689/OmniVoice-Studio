select * from opchallan where CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2020-12-01'  --and xshipcode='Vessel' 
and xchlnum in (select xchlnum from opchallanalc) and coalesce(xdornum,'')<>'Allocated'
--update opchallan set xdornum='Allocated' where CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2020-12-01'  --and xshipcode='Vessel' 
and xchlnum in (select xchlnum from opchallanalc) and coalesce(xdornum,'')<>'Allocated'

with retail as (
select o.xzone,o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt,h.xchlnum,(d.xqtychl) total,
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=12 then d.xqtychl else  0 end  "DEC20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=1 then d.xqtychl else  0 end "JAN21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2 then d.xqtychl else  0 end  "FEB21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3 then d.xqtychl else  0 end  "MAR21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=4 then d.xqtychl else  0 end  "APR21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=5 then d.xqtychl else  0 end  "MAY21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqtychl else  0 end  "JUN21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=7 then d.xqtychl else  0 end  "JUL21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=8  then d.xqtychl else  0 end  "AUG21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=09 then d.xqtychl else  0 end  "SEP21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=10 then d.xqtychl else  0 end  "OCT21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=11 then d.xqtychl else  0 end  "NOV21"
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) 
between '2020-12-01' and '2021-11-30' and coalesce(h.xdornum,'')<>'Allocated' 
 union all
select o.xzone, o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,h.xchlnum, (d.xqty) total,
case when month(d.xdate)=12 then d.xqty else  0 end  "DEC20",
case when month( d.xdate)=1 then d.xqty else  0 end "JAN21",
case when month( d.xdate)=2 then d.xqty else  0 end  "FEB21",
case when month( d.xdate)=3 then d.xqty else  0 end  "MAR21",
case when month( d.xdate)=4 then d.xqty else  0 end  "APR21",
case when month( d.xdate)=5 then d.xqty else  0 end  "MAY21",
case when month(d.xdate)=6  then d.xqty else  0 end  "JUN21",
case when month( d.xdate)=7 then d.xqty else  0 end  "JUL21",
case when month( d.xdate)=8 then d.xqty else  0 end  "AUG21",
case when month(d.xdate)=09 then d.xqty else  0 end  "SEP21",
case when month(d.xdate)=10 then d.xqty else  0 end  "OCT21",
case when month(d.xdate)=11 then d.xqty else  0 end  "NOV21"
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2020-12-01' and '2021-11-30'  and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AIID,
(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name,
sum(DEC20) DEC20,SUM(JAN21) JAN21,sum(FEB21) FEB21,sum(MAR21) MAR21,sum(APR21) APR21,
sum(MAY21) MAY21,sum(JUN21) JUN21,sum(JUL21) JUL21,sum(AUG21) AUG21,sum(SEP21) SEP21,
sum(OCT21) OCT21,sum(NOV21) NOV21
from retail a --where a.xid in (select xid from retailtargetraw where xqtychl>=juntarget+julytarget)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana




with retail as (
select o.xzone,o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt,h.xchlnum,(d.xqtychl) total,
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=12 then d.xqtychl else  0 end  "DEC20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=1 then d.xqtychl else  0 end "JAN21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2 then d.xqtychl else  0 end  "FEB21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3 then d.xqtychl else  0 end  "MAR21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=4 then d.xqtychl else  0 end  "APR21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=5 then d.xqtychl else  0 end  "MAY21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqtychl else  0 end  "JUN21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=7 then d.xqtychl else  0 end  "JUL21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=8  then d.xqtychl else  0 end  "AUG21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=09 then d.xqtychl else  0 end  "SEP21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=10 then d.xqtychl else  0 end  "OCT21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=11 then d.xqtychl else  0 end  "NOV21"
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutletctg o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) 
between '2020-12-01' and '2021-11-30' and coalesce(h.xdornum,'')<>'Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from pcmlapp.ERPonTheNet.dbo.prmst where xemp=a.xriid) RI_Name,
sum(DEC20) DEC20,SUM(JAN21) JAN21,sum(FEB21) FEB21,sum(MAR21) MAR21,sum(APR21) APR21,
sum(MAY21) MAY21,sum(JUN21) JUN21,sum(JUL21) JUL21,sum(AUG21) AUG21,sum(SEP21) SEP21,
sum(OCT21) OCT21,sum(NOV21) NOV21
from retail a --where a.xid in (select xid from retailtargetraw where xqtychl>=juntarget+julytarget)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana

