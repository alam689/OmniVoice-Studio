----------------------------------Suspicious Bkash Number------------------------------
select xzone,xriid,(select xname from prmst where xemp=caoutlet.xriid),bkash_no,
--(select distinct replace(xremark,'B2C Salary Payout via WEB to','') from     cashdisbursement where xmobile=caoutlet.bkash_no ),
count(*),(select sum(xamount) from     cashdisbursement where xmobile=caoutlet.bkash_no ) from caoutlet where bkash_no is not null 
group by xzone,xriid,bkash_no having count(*)>1
order by xriid
------------------------------------------------------------------

select * from opchallan where CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2020-12-01'  --and xshipcode='Vessel' 
and xchlnum in (select xchlnum from opchallanalc) and coalesce(xdornum,'')<>'Allocated'
--update opchallan set xdornum='Allocated' where CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>='2020-12-01'  --and xshipcode='Vessel' 
and xchlnum in (select xchlnum from opchallanalc) and coalesce(xdornum,'')<>'Allocated'


select CONVERT(date,getdate()-1),o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xproprietor,o.xmobile, o.xthana,o.xdistrict,o.xaddress,o.bkash_no,o.xmfstatus,
o.relation_bkash,o.name_bkash,o.nagad_no,o.xmfstatusnagod,o.relation_nagad,o.name_nagad,'' "Correction_Made/Required",sum(d.xqtychl) DeliveryQty,
case --when o.xzone in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(d.xqtychl) between 100 and 299 then sum(d.xqtychl)*5
	 when  sum(d.xqtychl) between 100 and 199 then sum(d.xqtychl)*5
	 when  sum(d.xqtychl) between 200 and 299 then sum(d.xqtychl)*5.5
	 when  sum(d.xqtychl) between 300 and 399 then sum(d.xqtychl)*6.67
	 when  sum(d.xqtychl) between 400 and 499 then sum(d.xqtychl)*7.50
	 when  sum(d.xqtychl) between 500 and 599 then sum(d.xqtychl)*8
	 when  sum(d.xqtychl) between 600 and 799 then sum(d.xqtychl)*8.33
	 when  sum(d.xqtychl) between 800 and 999 then sum(d.xqtychl)*8.75
	 when  sum(d.xqtychl)>=1000 then sum(d.xqtychl)*10 else 0 end,'' "Comment from Marketting",
	 '' "Comment from Account",'' "Comment from Audit"		
from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))=CONVERT(date,getdate()-1) and 
c.xsimcardno in ('Dhaka','Out Dhaka') and o.xzone not in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and 
 c.xgcus  in ('Retailer','Dealer','Net Dealer') and h.xshipcode='Vehicle' 
 group by o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xproprietor,o.xmobile, o.xthana,o.xdistrict,o.xaddress,o.bkash_no,o.xmfstatus,
 o.relation_bkash,o.name_bkash,o.nagad_no,o.xmfstatusnagod,o.relation_nagad,o.name_nagad

select CONVERT(date,getdate()-1),o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xproprietor, o.xmobile,o.xthana,o.xdistrict,o.xaddress,o.bkash_no,
o.xmfstatus,o.relation_bkash,o.name_bkash,o.nagad_no,o.xmfstatusnagod,o.relation_nagad,o.name_nagad,'' "Correction_Made/Required",sum(d.xqty) DeliveryQty,
case --when o.xzone in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(d.xqty) between 100 and 299 then sum(d.xqty)*5
	 when  sum(d.xqty) between 100 and 199 then sum(d.xqty)*5
	 when  sum(d.xqty) between 200 and 299 then sum(d.xqty)*5.5
	 when  sum(d.xqty) between 300 and 399 then sum(d.xqty)*6.67
	 when  sum(d.xqty) between 400 and 499 then sum(d.xqty)*7.50
	 when  sum(d.xqty) between 500 and 599 then sum(d.xqty)*8
	 when  sum(d.xqty) between 600 and 799 then sum(d.xqty)*8.33
	 when  sum(d.xqty) between 800 and 999 then sum(d.xqty)*8.75
	 when  sum(d.xqty)>=1000 then sum(d.xqty)*10 else 0 end,'' "Comment from Marketting",
	 '' "Comment from Account",'' "Comment from Audit"		
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate=CONVERT(date,getdate()-1) and
c.xsimcardno in ('Dhaka','Out Dhaka') and o.xzone not in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and  
 c.xgcus  in ('Retailer','Dealer','Net Dealer') and h.xshipcode='Vessel' 
 group by o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xproprietor, o.xmobile,o.xthana,o.xdistrict,o.xaddress,o.bkash_no,o.xmfstatus,
 o.relation_bkash,o.name_bkash,o.nagad_no,o.xmfstatusnagod,o.relation_nagad,o.name_nagad



-----------------NCML--------------------------------
select CONVERT(date,getdate()-1),o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xproprietor,o.xmobile, o.xthana,o.xdistrict,o.xaddress,
o.bkash_no,o.xmfstatus,o.relation_bkash,o.name_bkash,
o.nagad_no,o.xmfstatusnagod,o.relation_nagad,o.name_nagad,'' "Correction_Made/Required",sum(d.xqtychl) DeliveryQty,
case when  sum(d.xqtychl) between 100 and 199 then sum(d.xqtychl)*5
	 when  sum(d.xqtychl) between 200 and 299 then sum(d.xqtychl)*5.5
	 when  sum(d.xqtychl) between 300 and 399 then sum(d.xqtychl)*6.67
	 when  sum(d.xqtychl) between 400 and 499 then sum(d.xqtychl)*7.50
	 when  sum(d.xqtychl) between 500 and 599 then sum(d.xqtychl)*8
	 when  sum(d.xqtychl) between 600 and 799 then sum(d.xqtychl)*8.33
	 when  sum(d.xqtychl) between 800 and 999 then sum(d.xqtychl)*8.75
	 when  sum(d.xqtychl)>=1000 then sum(d.xqtychl)*10 else 0 end,'' "Comment from Marketting",
	 '' "Comment from Account",'' "Comment from Audit"		
from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutletctg o on h.zid=o.zid and h.xordernum=o.xid
where  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))= CONVERT(date,getdate()-1) and
c.xsimcardno<>'Corporate' --and 
-- c.xgcus  in ('Retailer','Dealer') and h.xshipcode='Vehicle' 
 group by o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xproprietor,o.xmobile,  o.xthana,o.xdistrict,o.xaddress,
 o.bkash_no,o.xmfstatus,o.relation_bkash,o.name_bkash,
o.nagad_no,o.xmfstatusnagod,o.relation_nagad,o.name_nagad

-------------------------------------Overall Offer Detail---------------------------------------------------------------------------------------------------------
with retail as (
select o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt, 
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between  '2021-09-01' and CONVERT(date,getdate()-1) and
c.xgcus  in ('Retailer','Dealer','Net Dealer') and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' --and d.xqtychl<1000
 union all
 select o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, xconfirmt,
 DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,d.xqty total
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2021-09-01' and CONVERT(date,getdate()-1)  and 
c.xgcus  in ('Retailer','Dealer','Net Dealer') and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AI_ID,(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name,sum(total) total from retail a  
--and a.xid in (select xid from retailtargetraw where Criteria_3<=200)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana


with retail as (
select o.xzone,c.xgcus,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,xconfirmt, 
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutletctg o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-09-01' and CONVERT(date,getdate()-1) and
c.xsimcardno <>'Corporate'
)
select xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,
xdistrict,xthana,a.xriid RI_ID,(select xname from pcmlapp.ERPonTheNet.dbo.prmst where xemp=a.xriid) RI_Name,
(select xtsoid from pcmlapp.ERPonTheNet.dbo.cacushrc where xriid=a.xriid) xtsoid,
(select xname from pcmlapp.ERPonTheNet.dbo.prmst where xemp=(select xtsoid from pcmlapp.ERPonTheNet.dbo.cacushrc where xriid=a.xriid)) AINAME,
(select xname from pcmlapp.ERPonTheNet.dbo.prmst where xemp=(select xziid from pcmlapp.ERPonTheNet.dbo.cacushrc where xriid=a.xriid)) ZINAME,
sum(total) total from retail a 
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana




----------------------------------------------------------For Update MFS Number -----------------------------------------------------------------------
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