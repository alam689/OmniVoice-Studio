
select * from opchallan where CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2020-12-01'  --and xshipcode='Vessel' 
and xchlnum in (select xchlnum from opchallanalc) and coalesce(xdornum,'')<>'Allocated'
--update opchallan set xdornum='Allocated' where CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2020-12-01'  --and xshipcode='Vessel' 
and xchlnum in (select xchlnum from opchallanalc) and coalesce(xdornum,'')<>'Allocated'

with retail as (
select o.xzone,o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total,
case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-10-01' and '2021-10-06' then (d.xqtychl) else  0 end OCT_1_6,
case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-10-07' and '2021-10-14' then (d.xqtychl) else  0 end OCT_7_14,
case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-10-15' and '2021-10-20' then (d.xqtychl) else  0 end OCT_15_20
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between  '2021-10-01' and '2021-10-20' and
c.xgcus  in ('Retailer','Dealer','Net Dealer') and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' --and d.xqtychl<1000
 union all
 select o.xzone,o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,
 DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,d.xqty total,
 case when d.xdate between '2021-10-01' and '2021-10-06' then (d.xqty) else  0 end OCT_1_6,
case when d.xdate between '2021-10-07' and '2021-10-14' then (d.xqty) else  0 end OCT_7_14,
case when d.xdate between '2021-10-15' and '2021-10-20' then (d.xqty) else  0 end OCT_15_20
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2021-10-01' and '2021-10-20'  and 
c.xgcus  in ('Retailer','Dealer','Net Dealer') and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AI_ID,(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name,sum(total) total,
sum(OCT_1_6),sum(OCT_7_14),sum(OCT_15_20)
from retail a  
--and a.xid in (select xid from retailtargetraw where Criteria_3<=200)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana

------------------------NCML-----------------------------
with retail as (
select o.xzone,o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total,
case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-10-01' and '2021-10-06' then (d.xqtychl) else  0 end OCT_1_6,
case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-10-07' and '2021-10-14' then (d.xqtychl) else  0 end OCT_7_14,
case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-10-15' and '2021-10-20' then (d.xqtychl) else  0 end OCT_15_20
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutletctg o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between  '2021-10-01' and '2021-10-20' and
c.xsimcardno <>'Corporate' --and d.xqtychl<1000

)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from PCMLAPP.ERPonTheNet.dbo.prmst where xemp=a.xriid) RI_Name,
(select xtsoid from PCMLAPP.ERPonTheNet.dbo.cacushrc where xriid=a.xriid) AI_ID,
(select xname from PCMLAPP.ERPonTheNet.dbo.prmst where xemp=(select xtsoid from PCMLAPP.ERPonTheNet.dbo.cacushrc where xriid=a.xriid)) AI_Name,
(select xname from PCMLAPP.ERPonTheNet.dbo.prmst where xemp=(select xziid from PCMLAPP.ERPonTheNet.dbo.cazone where xzone=a.xzone)) ZI_Name,sum(total) total,
sum(OCT_1_6),sum(OCT_7_14),sum(OCT_15_20)
from retail a  
--and a.xid in (select xid from retailtargetraw where Criteria_3<=200)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana


with retail as (
select o.xzone,o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt,h.xchlnum,(d.xqtychl) total,
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=10 then d.xqtychl else  0 end  "OCT20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=11 then d.xqtychl else  0 end  "NOV20"
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) 
between '2021-10-01' and '2021-11-30' and coalesce(h.xdornum,'')<>'Allocated' 
 union all
select o.xzone, o.xcus,o.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,h.xchlnum, (d.xqty) total,
case when month(d.xdate)=10 then d.xqty else  0 end  "OCT20",
case when month(d.xdate)=11 then d.xqty else  0 end  "NOV20"
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between  '2021-10-01' and '2021-11-30'  and coalesce(h.xdornum,'')='Allocated' 
),  distr as (
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AIID,
(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name,
sum(OCT20) OCT20,
case when sum(OCT20) between 100 and 199 then 1 else 0 end OCT1,
case when sum(OCT20) between 200 and 299 then 1 else 0 end OCT2,
case when sum(OCT20) between 300 and 399 then 1 else 0 end OCT3,
case when sum(OCT20) between 400 and 499 then 1 else 0 end OCT4,
case when sum(OCT20) between 500 and 599 then 1 else 0 end OCT5,
case when sum(OCT20) between 600 and 799 then 1 else 0 end OCT6,
case when sum(OCT20) between 800 and 999 then 1 else 0 end OCT7,
case when sum(OCT20) between 1000 and 1199 then 1 else 0 end OCT8,
case when sum(OCT20) between 1200 and 1499 then 1 else 0 end OCT9,
case when sum(OCT20) between 1500 and 1799 then 1 else 0 end OCT10,
case when sum(OCT20) between 1800 and 1999 then 1 else 0 end OCT11,
case when sum(OCT20) between 2000 and 2199 then 1 else 0 end OCT12,
case when sum(OCT20) between 2200 and 2499 then 1 else 0 end OCT13,
case when sum(OCT20) between 2500 and 2999 then 1 else 0 end OCT14,
case when sum(OCT20) between 3000 and 3999 then 1 else 0 end OCT15,
case when sum(OCT20) between 4000 and 4999 then 1 else 0 end OCT16,
case when sum(OCT20)>=5000 then 1 else 0 end OCT17,
sum(NOV20) NOV20,
case when sum(NOV20) between 100 and 199 then 1 else 0 end NOV1,
case when sum(NOV20) between 200 and 299 then 1 else 0 end NOV2,
case when sum(NOV20) between 300 and 399 then 1 else 0 end NOV3,
case when sum(NOV20) between 400 and 499 then 1 else 0 end NOV4,
case when sum(NOV20) between 500 and 599 then 1 else 0 end NOV5,
case when sum(NOV20) between 600 and 799 then 1 else 0 end NOV6,
case when sum(NOV20) between 800 and 999 then 1 else 0 end NOV7,
case when sum(NOV20) between 1000 and 1199 then 1 else 0 end NOV8,
case when sum(NOV20) between 1200 and 1499 then 1 else 0 end NOV9,
case when sum(NOV20) between 1500 and 1799 then 1 else 0 end NOV10,
case when sum(NOV20) between 1800 and 1999 then 1 else 0 end NOV11,
case when sum(NOV20) between 2000 and 2199 then 1 else 0 end NOV12,
case when sum(NOV20) between 2200 and 2499 then 1 else 0 end NOV13,
case when sum(NOV20) between 2500 and 2999 then 1 else 0 end NOV14,
case when sum(NOV20) between 3000 and 3999 then 1 else 0 end NOV15,
case when sum(NOV20) between 4000 and 4999 then 1 else 0 end NOV16,
case when sum(NOV20)>=5000 then 1 else 0 end NOV17 from retail a --where a.xid in (select xid from retailtargetraw where xqtychl>=juntarget+julytarget)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana)
select xdistrict,sum(OCT20) OCT20,
sum(OCT1),sum(OCT2),sum(OCT3),sum(OCT4),sum(OCT5),sum(OCT6),sum(OCT7),sum(OCT8),sum(OCT9),
sum(OCT10),sum(OCT11),sum(OCT12),sum(OCT13),sum(OCT14),sum(OCT15),sum(OCT16),sum(OCT17),
sum(NOV20) NOV20,
sum(NOV1),sum(NOV2),sum(NOV3),sum(NOV4),sum(NOV5),sum(NOV6),sum(NOV7),sum(NOV8),sum(NOV9),
sum(NOV10),sum(NOV11),sum(NOV12),sum(NOV13),sum(NOV14),sum(NOV15),sum(NOV16),sum(NOV17)
from distr
group by  xdistrict


