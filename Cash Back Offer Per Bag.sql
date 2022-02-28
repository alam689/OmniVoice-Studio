with retail as (
select o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt, 
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-07' and CONVERT(date,getdate()-1) and
c.xgcus  in ('Retailer','Dealer','Net Dealer') and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' --and d.xqtychl<1000
 union all
 select o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,
 DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,d.xqty total
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2021-08-07' and CONVERT(date,getdate()-1)  and 
c.xgcus  in ('Retailer','Dealer','Net Dealer') and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AI_ID,(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name,sum(total) total from retail a  
--and a.xid in (select xid from retailtargetraw where Criteria_3<=200)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana


select * from opchallan where CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2020-12-01'  --and xshipcode='Vessel' 
and xchlnum in (select xchlnum from opchallanalc) and coalesce(xdornum,'')<>'Allocated'
--update opchallan set xdornum='Allocated' where CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2020-12-01'  --and xshipcode='Vessel' 
and xchlnum in (select xchlnum from opchallanalc) and coalesce(xdornum,'')<>'Allocated'

select CONVERT(date,getdate()-1),o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xproprietor,o.xmobile, o.xthana,o.xdistrict,o.xaddress,o.bkash_no,o.relation_bkash,o.name_bkash,
o.nagad_no,o.relation_nagad,o.name_nagad,'' "Correction_Made/Required",sum(d.xqtychl) DeliveryQty,
case when o.xzone in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(d.xqtychl) between 100 and 299 then sum(d.xqtychl)*5
	 when o.xzone not in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(d.xqtychl) between 200 and 299 then sum(d.xqtychl)*5
	 when  sum(d.xqtychl) between 300 and 399 then sum(d.xqtychl)*6.67
	 when sum(d.xqtychl) between 400 and 499 then sum(d.xqtychl)*7.50
	 when  sum(d.xqtychl) between 500 and 599 then sum(d.xqtychl)*8
	 when  sum(d.xqtychl) between 600 and 799 then sum(d.xqtychl)*8.33
	 when  sum(d.xqtychl) between 800 and 999 then sum(d.xqtychl)*8.75
	 when  sum(d.xqtychl)>=1000 then sum(d.xqtychl)*10 else 0 end,'' "Comment from Marketting",
	 '' "Comment from Account",'' "Comment from Audit"		
from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))=CONVERT(date,getdate()-1) and 
c.xsimcardno in ('Dhaka','Out Dhaka') and -- select CONVERT(date,getdate()-1)
 c.xgcus  in ('Retailer','Dealer','Net Dealer') and h.xshipcode='Vehicle' 
 group by o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xproprietor,o.xmobile, o.xthana,o.xdistrict,o.xaddress,o.bkash_no,o.relation_bkash,o.name_bkash,
o.nagad_no,o.relation_nagad,o.name_nagad

select CONVERT(date,getdate()-1),o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xproprietor, o.xmobile,o.xthana,o.xdistrict,o.xaddress,o.bkash_no,o.relation_bkash,o.name_bkash,
o.nagad_no,o.relation_nagad,o.name_nagad,'' "Correction_Made/Required",sum(d.xqty) DeliveryQty,
case when o.xzone in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(d.xqty) between 100 and 299 then sum(d.xqty)*5
	 when o.xzone not in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(d.xqty) between 200 and 299 then sum(d.xqty)*5
	 when  sum(d.xqty) between 300 and 399 then sum(d.xqty)*6.67
	 when sum(d.xqty) between 400 and 499 then sum(d.xqty)*7.50
	 when  sum(d.xqty) between 500 and 599 then sum(d.xqty)*8
	 when  sum(d.xqty) between 600 and 799 then sum(d.xqty)*8.33
	 when  sum(d.xqty) between 800 and 999 then sum(d.xqty)*8.75
	 when  sum(d.xqty)>=1000 then sum(d.xqty)*10 else 0 end,'' "Comment from Marketting",
	 '' "Comment from Account",'' "Comment from Audit"		
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate=CONVERT(date,getdate()-1) and
c.xsimcardno in ('Dhaka','Out Dhaka') and 
 c.xgcus  in ('Retailer','Dealer','Net Dealer') and h.xshipcode='Vessel' 
 group by o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xproprietor, o.xmobile,o.xthana,o.xdistrict,o.xaddress,o.bkash_no,o.relation_bkash,o.name_bkash,
o.nagad_no,o.relation_nagad,o.name_nagad

------------------NCML---------------------------
select CONVERT(date,getdate()-1),o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xproprietor,o.xmobile, o.xthana,o.xdistrict,o.xaddress,o.bkash_no,o.relation_bkash,o.name_bkash,
o.nagad_no,o.relation_nagad,o.name_nagad,'' "Correction_Made/Required",sum(d.xqtychl) DeliveryQty,
case when o.xzone in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(d.xqtychl) between 100 and 299 then sum(d.xqtychl)*5
	 when o.xzone not in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(d.xqtychl) between 200 and 299 then sum(d.xqtychl)*5
	 when  sum(d.xqtychl) between 300 and 399 then sum(d.xqtychl)*6.67
	 when sum(d.xqtychl) between 400 and 499 then sum(d.xqtychl)*7.50
	 when  sum(d.xqtychl) between 500 and 599 then sum(d.xqtychl)*8
	 when  sum(d.xqtychl) between 600 and 799 then sum(d.xqtychl)*8.33
	 when  sum(d.xqtychl) between 800 and 999 then sum(d.xqtychl)*8.75
	 when  sum(d.xqtychl)>=1000 then sum(d.xqtychl)*10 else 0 end,'' "Comment from Marketting",
	 '' "Comment from Account",'' "Comment from Audit"		
from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutletctg o on h.zid=o.zid and h.xordernum=o.xid
where  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))=CONVERT(date,getdate()-1) and
c.xsimcardno<>'Corporate' --and 
-- c.xgcus  in ('Retailer','Dealer') and h.xshipcode='Vehicle' 
 group by o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xproprietor,o.xmobile,  o.xthana,o.xdistrict,o.xaddress,o.bkash_no,o.relation_bkash,o.name_bkash,
o.nagad_no,o.relation_nagad,o.name_nagad

---------------------------------------------------------------------------------------
with retail as (
select o.xzone,c.xgcus,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt, 
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-07' and CONVERT(date,getdate()-1) and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' and d.xqtychl<1000
 union all
 select o.xzone, c.xgcus,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,
 DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,d.xqty total
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2021-08-07' and CONVERT(date,getdate()-1)  and 
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AI_ID,(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name1,
sum(total) total from retail a  where a.xgcus  in ('Retailer','Dealer','Net Dealer')
--and a.xid in (select xid from retailtargetraw where Criteria_3<=200)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana


with retail as (
select o.xzone,o.xriid, o.xid,o.xoutletname,sum(d.xqtychl) total,
case  when  sum(d.xqtychl)>=200 then 1 else 0 end achiver
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-07' and CONVERT(date,getdate()-1) and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' and d.xqtychl<1000
and c.xgcus  in ('Retailer','Dealer','Net Dealer')
group by o.xzone,o.xriid, o.xid,o.xoutletname
 union all
 select o.xzone,o.xriid, o.xid,o.xoutletname,sum(d.xqty) total,
 case  when  sum(d.xqty)>=200 then 1 else 0 end achiver
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate   between '2021-08-07' and CONVERT(date,getdate()-1)  and 
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
 and c.xgcus  in ('Retailer','Dealer','Net Dealer')
group by o.xzone,o.xriid, o.xid,o.xoutletname
)
select a.xzone Zone_Name,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,count(distinct xid),sum(achiver),
sum(total) total from retail a 
group by a.xzone,a.xriid

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
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' and d.xqtychl<1000
 union all
 select o.xzone, c.xgcus,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,
 DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,d.xqty total,
 case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt))<'2021-01-01' then d.xqty else  0 end "BeforeJan2021",
case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-01-01' and '2021-07-31' then d.xqty else  0 end "JanToJul2021",
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2021-08-07' then d.xqty else  0 end AUG,
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))=CONVERT(date,getdate()-1) then d.xqty else  0 end  "LastDaySales"
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate between '2020-06-01' and CONVERT(date,getdate()-1)  and 
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AI_ID,(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name1,
sum(BeforeJan2021) BeforeJan2021, sum(JanToJul2021) JanToJul2021,sum(AUG) Offer,
sum(LastDaySales) LastDaySales
 from retail a 
 where a.xgcus  in ('Retailer','Dealer','Net Dealer')
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana
having  sum(JanToJul2021) =0 and sum(AUG)>0
------------------------------------------NCML--------------------------------------------------
with retail as (
select o.xzone,c.xgcus,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt, 
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutletctg o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-07' and CONVERT(date,getdate()-1) and
c.xsimcardno <>'Corporate'
)
select xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,
xdistrict,xthana,a.xriid RI_ID,(select xname from pcmlapp.ERPonTheNet.dbo.prmst where xemp=a.xriid) RI_Name,
sum(total) total from retail a 
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana

with retail as (
select o.xzone,o.xriid, o.xid,o.xoutletname,sum(d.xqtychl) total,
case  when  sum(d.xqtychl)>=200 then 1 else 0 end achiver
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutletctg o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-07' and CONVERT(date,getdate()-1) and
c.xsimcardno <>'Corporate'
group by o.xzone,o.xriid, o.xid,o.xoutletname

)
select a.xzone Zone_Name,
a.xriid RI_ID,(select xname from pcmlapp.ERPonTheNet.dbo.prmst where xemp=a.xriid) RI_Name,count(distinct xid),sum(achiver),
sum(total) total from retail a 
group by a.xzone,a.xriid

with retail as (
select c.xbloodgrp xzone,h.xteam xriid, sum(d.xqtychl) total,
case  when  sum(d.xqtychl)>=200 then 1 else 0 end achiver
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-01' and '2021-08-31' and
c.xsimcardno <>'Corporate'
group by c.xbloodgrp ,h.xteam 

)
select a.xzone Zone_Name,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,sum(total) total from retail a 
group by a.xzone,a.xriid

-----------------------------------------------------------------------------------------------------------------------------------------------------

select xid,xoutletname,bkash_no,(select max(bkash_no) from opadviceapp where xid=caoutlet.xid and  bkash_no<>'' ),
relation_bkash,(select max(relation_bkash) from opadviceapp where xid=caoutlet.xid and  bkash_no<>'' ),
name_bkash,(select max(name_bkash) from opadviceapp where xid=caoutlet.xid and  bkash_no<>'' ) from 
caoutlet where xid in (select xid from opadviceapp where xdate>=CONVERT(date,getdate()-5) and bkash_no<>'' )
and (bkash_no is null or bkash_no='')

update caoutlet set bkash_no=(select max(bkash_no) from opadviceapp where xid=caoutlet.xid and  bkash_no<>'' ),
relation_bkash=(select max(relation_bkash) from opadviceapp where xid=caoutlet.xid and  bkash_no<>'' ),
name_bkash=(select max(name_bkash) from opadviceapp where xid=caoutlet.xid and  bkash_no<>'' ) 
where xid in (select xid from opadviceapp where xdate>=CONVERT(date,getdate()-5) and bkash_no<>'' )
and (bkash_no is null or bkash_no='')

select xid,xoutletname,nagad_no,(select max(nagad_no) from opadviceapp where xid=caoutlet.xid and  nagad_no<>'' ),
relation_nagad,(select max(relation_nagad) from opadviceapp where xid=caoutlet.xid and  nagad_no<>'' ),
name_nagad,(select max(name_nagad) from opadviceapp where xid=caoutlet.xid and  nagad_no<>'' ) from 
 caoutlet where xid in (select xid from opadviceapp where xdate>=CONVERT(date,getdate()-5) and nagad_no<>'' )
and (nagad_no is null or nagad_no='')

 update caoutlet set nagad_no=(select max(nagad_no) from opadviceapp where xid=caoutlet.xid and  nagad_no<>'' ),
relation_nagad=(select max(relation_nagad) from opadviceapp where xid=caoutlet.xid and  nagad_no<>'' ),
name_nagad=(select max(name_nagad) from opadviceapp where xid=caoutlet.xid and  nagad_no<>'' )
 where xid in (select xid from opadviceapp where xdate>=CONVERT(date,getdate()-5) and nagad_no<>'' )
and (nagad_no is null or nagad_no='')

select xid,xoutletname,bkash_no,(select max(bkash_no) from opchallanalc where xid=caoutlet.xid and  bkash_no<>'' ),
relation_bkash,(select max(relation_bkash) from opchallanalc where xid=caoutlet.xid and  bkash_no<>'' ),
name_bkash,(select max(name_bkash) from opchallanalc where xid=caoutlet.xid and  bkash_no<>'' ) from 
caoutlet where xid in (select xid from opchallanalc where xdate>=CONVERT(date,getdate()-5) and bkash_no<>'' )
and (bkash_no is null or bkash_no='')

update caoutlet set bkash_no=(select max(bkash_no) from opchallanalc where xid=caoutlet.xid and  bkash_no<>'' ),
relation_bkash=(select max(relation_bkash) from opchallanalc where xid=caoutlet.xid and  bkash_no<>'' ),
name_bkash=(select max(name_bkash) from opchallanalc where xid=caoutlet.xid and  bkash_no<>'' ) 
where xid in (select xid from opchallanalc where xdate>=CONVERT(date,getdate()-5) and bkash_no<>'' )
and (bkash_no is null or bkash_no='')

select xid,xoutletname,nagad_no,(select max(nagad_no) from opchallanalc where xid=caoutlet.xid and  nagad_no<>'' ),
relation_nagad,(select max(relation_nagad) from opchallanalc where xid=caoutlet.xid and  nagad_no<>'' ),
name_nagad,(select max(name_nagad) from opchallanalc where xid=caoutlet.xid and  nagad_no<>'' ) from 
 caoutlet where xid in (select xid from opchallanalc where xdate>=CONVERT(date,getdate()-5) and nagad_no<>'' )
and (nagad_no is null or nagad_no='')

 update caoutlet set nagad_no=(select max(nagad_no) from opchallanalc where xid=caoutlet.xid and  nagad_no<>'' ),
relation_nagad=(select max(relation_nagad) from opchallanalc where xid=caoutlet.xid and  nagad_no<>'' ),
name_nagad=(select max(name_nagad) from opchallanalc where xid=caoutlet.xid and  nagad_no<>'' )
 where xid in (select xid from opchallanalc where xdate>=CONVERT(date,getdate()-5) and nagad_no<>'' )
and (nagad_no is null or nagad_no='')