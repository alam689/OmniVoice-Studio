with retail as (
select o.xzone,o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt,h.xchlnum,(d.xqtychl) total,
case when year( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2020  and month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=9 then d.xqtychl else  0 end "SEP20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=10 then d.xqtychl else  0 end  "OCT20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=11 then d.xqtychl else  0 end  "NOV20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=12 then d.xqtychl else  0 end  "DEC20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=1 then d.xqtychl else  0 end "JAN21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2 then d.xqtychl else  0 end  "FEB21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3 then d.xqtychl else  0 end  "MAR21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=4 then d.xqtychl else  0 end  "APR21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=5 then d.xqtychl else  0 end  "MAY21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqtychl else  0 end  "JUN21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=7 then d.xqtychl else  0 end  "JUL21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=8  then d.xqtychl else  0 end AUG21,
case when  year( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2021  and  month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=9  then d.xqtychl else  0 end SEP21
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) 
between '2020-09-01' and CONVERT(date,getdate()-1) and coalesce(h.xdornum,'')<>'Allocated' 
 union all
select o.xzone, o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,h.xchlnum, (d.xqty) total,
case when year(d.xdate)=2020 and month(d.xdate)=9 then d.xqty else  0 end  "SEP20",
case when month(d.xdate)=10 then d.xqty else  0 end  "OCT20",
case when month(d.xdate)=11 then d.xqty else  0 end  "NOV20",
case when month(d.xdate)=12 then d.xqty else  0 end  "DEC20",
case when month( d.xdate)=1 then d.xqty else  0 end "JAN21",
case when month( d.xdate)=2 then d.xqty else  0 end  "FEB21",
case when month( d.xdate)=3 then d.xqty else  0 end  "MAR21",
case when month( d.xdate)=4 then d.xqty else  0 end  "APR21",
case when month( d.xdate)=5 then d.xqty else  0 end  "MAY21",
case when month(d.xdate)=6  then d.xqty else  0 end  "JUN21",
case when month( d.xdate)=7 then d.xqty else  0 end  "JUL21",
case when month( d.xdate)=8 then d.xqty else  0 end  "AUG21",
case when year(d.xdate)=2021 and month( d.xdate)=9 then d.xqty else  0 end  "SEP21"
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2020-09-01' and CONVERT(date,getdate()-1)  and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AIID,
(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name,
sum(SEP20) SEP20,sum(OCT20) OCT20,
sum(NOV20) NOV20,sum(DEC20) DEC20,SUM(JAN21) JAN21,sum(FEB21) FEB21,sum(MAR21) MAR21,sum(APR21) APR21,sum(MAY21) MAY21,sum(JUN21) JUN21,
sum(JUL21) JUL21,sum(AUG21) AUG21,sum(SEP21) SEP21 from retail a --where a.xid in (select xid from retailtargetraw where xqtychl>=juntarget+julytarget)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana



with retail as (
select o.xzone,o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt,h.xchlnum,(d.xqtychl) total,
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))<'2021-08-01' then d.xqtychl else  0 end last12Month,
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2021-08-01' then d.xqtychl else  0 end AUG
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-08-01' and '2021-07-31' and
coalesce(h.xdornum,'')<>'Allocated' 
 union all
 select o.xzone, o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,h.xchlnum, (d.xqty) total,
case when  d.xdate<'2021-08-01' then d.xqty else  0 end last12Month,
case when  d.xdate>='2021-08-01' then d.xqty else  0 end AUG
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2020-08-01' and '2021-07-31' and coalesce(h.xdornum,'')='Allocated' 
),ttt as (
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,(select xtsoid from cacushrc where xriid=a.xriid) xtsoid,
sum(last12Month) last12Month,sum(AUG) AUG2021 from retail a 
where a.xid not like 'CUS%'
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana)
select Zone_Name,xtsoid,(select xname from prmst where xemp=ttt.xtsoid),count(*),sum(last12Month) last12Month,sum(AUG2021) AUG2021 from ttt
group by Zone_Name,xtsoid

with retail as (
select o.xzone,o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt,h.xchlnum,(d.xqtychl) total,
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2021-08-01' then d.xqtychl else  0 end AUG
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutletctg o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-01' and CONVERT(date,getdate()-1) and
coalesce(h.xdornum,'')<>'Allocated' ),ttt as (
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,
a.xriid RI_ID,(select xname from pcmlapp.ERPonTheNet.dbo.prmst where xemp=a.xriid) RI_Name,
(select xtsoid from pcmlapp.ERPonTheNet.dbo.cacushrc where xriid=a.xriid) xtsoid,sum(AUG) AUG2021 from retail a 
where a.xid not like 'CUS%'
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana)
select Zone_Name,xtsoid,(select xname from pcmlapp.ERPonTheNet.dbo.prmst where xemp=ttt.xtsoid),count(*) ret,sum(AUG2021) AUG2021  from ttt
group by Zone_Name,xtsoid
---------------------------------------------------------------------------------------------




with retail as (
select c.xbloodgrp xzone,c.xcus,c.xorg,h.xteam xriid,year(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xyear,
month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xper ,d.xqtychl,h.xordernum xid
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-11-01' and CONVERT(date,getdate()-1) and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' 
 union all
 select c.xbloodgrp xzone,c.xcus,c.xorg,d.xriid xriid,year(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xyear,
month(CONVERT(date,DATEADD(HOUR,-6,xconfirmt))) xper ,d.xqty xqtychl,d.xid
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-11-01' and CONVERT(date,getdate()-1)  and 
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
), cte2 as (
select a.xzone Zone_Name,a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,a.xyear,a.xper,
count(distinct xid ) No_of_Retail,sum(xqtychl) xqtychl
 from retail a 
group by a.xzone,a.xriid,a.xyear,a.xper)
select Zone_Name,RI_ID,RI_Name,
sum( case when xper=11 then No_of_Retail else  0 end) "NOV_Retail",
sum( case when xper=11 then xqtychl else  0 end) "NOV_Sales",
sum(case when xper=12 then No_of_Retail else 0 end) "DEC_Retail",
sum(case when xper=12 then xqtychl else 0 end) "DEC_Sales",
sum(case when xper=01 then No_of_Retail else 0 end) "JAN_Retail",
sum(case when xper=01 then xqtychl else 0 end) "JAN_Sales",
sum(case when xper=02 then No_of_Retail else 0 end)  "FEB_Retail",
sum(case when xper=02 then xqtychl else 0 end)  "FEB_Sales",
sum(case when xper=03 then No_of_Retail else 0 end)  "MAR_Retail",
sum(case when xper=03 then xqtychl else 0 end)  "MAR_Sales",
sum(case when xper=04 then No_of_Retail else 0 end)  "APR_Retail",
sum(case when xper=04 then xqtychl else 0 end)  "APR_Sales",
sum(case when xper=05 then No_of_Retail else 0 end) "MAY_Retail",
sum(case when xper=05 then xqtychl else 0 end) "MAY__Sales",
sum(case when xper=06 then No_of_Retail else 0 end)  "JUN_Retail",
sum(case when xper=06 then xqtychl else 0 end)  "JUN_Sales",
sum(case when xper=07 then No_of_Retail else 0 end)  "JUL_Retail",
sum(case when xper=07 then xqtychl else 0 end)  "JUL_Sales",
sum(case when xper=08 then No_of_Retail else 0 end)  "AUG_Retail",
sum(case when xper=08 then xqtychl else 0 end)  "AUG_Sales"
from cte2 group by Zone_Name,RI_ID,RI_Name


with retail as (
select o.xzone,c.xgcus,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt, 
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total,
 case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=11 then d.xqtychl else  0 end "NOV",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=12 then d.xqtychl else  0 end "DEC",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=1 then d.xqtychl else  0 end "JAN",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2 then d.xqtychl else  0 end  "FEB",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3 then d.xqtychl else  0 end  "MAR",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=4 then d.xqtychl else  0 end  "APR",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=5 then d.xqtychl else  0 end  "MAY",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqtychl else  0 end  "JUN",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=7 then d.xqtychl else  0 end  "JUL",
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2021-08-07' then d.xqtychl else  0 end AUG,
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))=CONVERT(date,getdate()-1) then d.xqtychl else  0 end  "LastDaySales"
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-11-01' and CONVERT(date,getdate()-1) and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' 
 union all
 select o.xzone, c.xgcus,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,
 DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,d.xqty total,
 case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=11 then d.xqty else  0 end "NOV",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=12 then d.xqty else  0 end "DEC",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=1 then d.xqty else  0 end "JAN",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2 then d.xqty else  0 end  "FEB",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3 then d.xqty else  0 end  "MAR",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=4 then d.xqty else  0 end  "APR",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=5 then d.xqty else  0 end  "MAY",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqty else  0 end  "JUN",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=7 then d.xqty else  0 end  "JUL",
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2021-08-07'  then d.xqty else  0 end AUG,
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))=CONVERT(date,getdate()-1) then d.xqty else  0 end  "LastDaySales"
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-11-01' and CONVERT(date,getdate()-1)  and 
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
),cte2 as (
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AI_ID,(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xziid from cacushrc where xriid=a.xriid) ZI_ID,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name1,
sum(NOV) NOV, sum(DEC) DEC,sum(JAN) JAN,sum(FEB) FEB, 
sum(MAR) MAR,sum(APR) APR,sum(MAY) MAY, sum(JUN) JUN,sum(JUL) JUL,sum(AUG) AUG,
sum(LastDaySales) LastDaySales
 from retail a 
 where a.xgcus  in ('Retailer','Dealer','Net Dealer')
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana
having sum(NOV)>0)
select Zone_Name,AI_Name,RI_ID,RI_Name,count(distinct Retail_ID ),sum(NOV) NOV, sum(DEC) DEC,sum(JAN) JAN,sum(FEB) FEB, 
sum(MAR) MAR,sum(APR) APR,sum(MAY) MAY, sum(JUN) JUN,sum(JUL) JUL,sum(AUG) AUG,
sum(LastDaySales) LastDaySales from cte2
group by Zone_Name,AI_Name,RI_ID,RI_Name



with retail as (
select o.xzone,c.xgcus,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt, 
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total,
case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt))<'2021-01-01' then d.xqtychl else  0 end "BeforeJan2021",
case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-01-01' and '2021-07-31' then d.xqtychl else  0 end "JanToJul2021",
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2021-08-07' then d.xqtychl else  0 end AUG,
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))=CONVERT(date,getdate()-1) then d.xqtychl else  0 end  "LastDaySales"
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-06-01' and CONVERT(date,getdate()-1) and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' 
 union all
 select o.xzone, c.xgcus,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,
 DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,d.xqty total,
 case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt))<'2021-01-01' then d.xqty else  0 end "BeforeJan2021",
case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-01-01' and '2021-07-31' then d.xqty else  0 end "JanToJul2021",
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2021-08-07' then d.xqty else  0 end AUG,
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))=CONVERT(date,getdate()-1) then d.xqty else  0 end  "LastDaySales"
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-06-01' and CONVERT(date,getdate()-1)  and 
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AI_ID,(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name1,
sum(BeforeJan2021) BeforeJan2021, sum(JanToJul2021) JanToJul2021,sum(AUG) AUG,
sum(LastDaySales) LastDaySales
 from retail a 
 where a.xgcus  in ('Retailer','Dealer','Net Dealer')
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana
having  sum(JanToJul2021) =0


with retail as (
select o.xzone,o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt,h.xchlnum,(d.xqtychl) total,
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=9 then d.xqtychl else  0 end "SEP20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=10 then d.xqtychl else  0 end  "OCT20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=11 then d.xqtychl else  0 end  "NOV20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=12 then d.xqtychl else  0 end  "DEC20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=1 then d.xqtychl else  0 end "JAN21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2 then d.xqtychl else  0 end  "FEB21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3 then d.xqtychl else  0 end  "MAR21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=4 then d.xqtychl else  0 end  "APR21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=5 then d.xqtychl else  0 end  "MAY21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqtychl else  0 end  "JUN21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=7 then d.xqtychl else  0 end  "JUL21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=8  then d.xqtychl else  0 end AUG21
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-09-01' and '2021-08-31' and coalesce(h.xdornum,'')<>'Allocated' 
 union all
select o.xzone, o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,h.xchlnum, (d.xqty) total,
case when month(d.xdate)=9 then d.xqty else  0 end "SEP20",
case when month(d.xdate)=10 then d.xqty else  0 end  "OCT20",
case when month(d.xdate)=11 then d.xqty else  0 end  "NOV20",
case when month(d.xdate)=12 then d.xqty else  0 end  "DEC20",
case when month( d.xdate)=1 then d.xqty else  0 end "JAN21",
case when month( d.xdate)=2 then d.xqty else  0 end  "FEB21",
case when month( d.xdate)=3 then d.xqty else  0 end  "MAR21",
case when month( d.xdate)=4 then d.xqty else  0 end  "APR21",
case when month( d.xdate)=5 then d.xqty else  0 end  "MAY21",
case when month(d.xdate)=6 then d.xqty else  0 end  "JUN21",
case when month( d.xdate)=7 then d.xqty else  0 end  "JUL21",
case when month( d.xdate)=8 then d.xqty else  0 end  "AUG21"
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2020-09-01' and '2021-08-31'  and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,xdistrict,xthana,(select xtsoid from cacushrc where xriid=a.xriid),(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)),
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,
sum(AUG21) AUG21,sum(JUL21) JUL21,sum(JUN21) JUN21,sum(MAY21) MAY21 ,sum(APR21) APR21,
sum(MAR21) MAR21,sum(FEB21) FEB21,SUM(JAN21) JAN21 ,sum(DEC20) DEC20,
sum(NOV20) NOV20 ,sum(OCT20) OCT20,sum(SEP20) SEP20 from retail a where a.xid not like 'CUS-%'
group by a.xzone,xdistrict,xthana,a.xriid,a.xcus,a.xorg,a.xid,a.xoutletname
order by a.xzone