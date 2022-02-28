with retail as (
select o.xzone,o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt,h.xchlnum,(d.xqtychl) total,
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=9 then d.xqtychl else  0 end "SEP",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=10 then d.xqtychl else  0 end  "OCT",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=11 then d.xqtychl else  0 end  "NOV",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=12 then d.xqtychl else  0 end  "DEC",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=1 then d.xqtychl else  0 end "JAN",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2 then d.xqtychl else  0 end  "FEB",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3 then d.xqtychl else  0 end  "MAR",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=4 then d.xqtychl else  0 end  "APR",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=5 then d.xqtychl else  0 end  "MAY",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqtychl else  0 end  "JUN",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=7 then d.xqtychl else  0 end  "JUL",
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2021-08-07' then d.xqtychl else  0 end AUG
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-09-01' and CONVERT(date,getdate()-1) and
coalesce(h.xdornum,'')<>'Allocated' 
 union all
 select o.xzone, o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,h.xchlnum, (d.xqty) total,
 case when month(d.xdate)=9 then d.xqty else  0 end "SEP",
case when month(d.xdate)=10 then d.xqty else  0 end  "OCT",
case when month(d.xdate)=11 then d.xqty else  0 end  "NOV",
case when month(d.xdate)=12 then d.xqty else  0 end  "DEC",
case when month( d.xdate)=1 then d.xqty else  0 end "JAN",
case when month( d.xdate)=2 then d.xqty else  0 end  "FEB",
case when month( d.xdate)=3 then d.xqty else  0 end  "MAR",
case when month( d.xdate)=4 then d.xqty else  0 end  "APR",
case when month( d.xdate)=5 then d.xqty else  0 end  "MAY",
case when month(d.xdate)=6 then d.xqty else  0 end  "JUN",
case when month( d.xdate)=7 then d.xqty else  0 end  "JUL",
case when  d.xdate>='2021-08-07' then d.xqty else  0 end AUG
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2020-09-01' and CONVERT(date,getdate()-1)  and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,sum(SEP) SEP,sum(OCT) OCT,sum(NOV) NOV,sum(DEC) "DEC",SUM(JAN) JAN,
sum(FEB) FEB,sum(MAR) MAR,sum(APR) APR,sum(MAY) MAY,sum(JUN) JUN,sum(JUL) JUL,sum(AUG) AUG from retail a 
where a.xid in (select xid from retailtargetraw where xqtychl>=juntarget+julytarget)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana


with retail as (
select o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt, 
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-06-01' and '2021-07-19' and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' 
and c.xgcus  in ('Retailer','Dealer','Net Dealer')
 union all
 select o.xzone, o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,
 DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,d.xqty total
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2021-06-01' and '2021-07-19'  and 
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
and c.xgcus  in ('Retailer','Dealer','Net Dealer')
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AI_ID,(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name1,
sum(a.total) total from retail a join retailtargetraw r on a.xid=r.xid

