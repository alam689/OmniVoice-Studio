with retail as (
select o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,o.bkash_no, o.nagad_no, 
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between  '2021-08-01' and '2021-08-31' and
c.xgcus  in ('Retailer','Dealer','Net Dealer') and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' --and d.xqtychl<1000
 union all
 select o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, o.bkash_no, o.nagad_no, 
 DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,d.xqty total
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2021-08-01' and '2021-08-31'  and 
c.xgcus  in ('Retailer','Dealer','Net Dealer') and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,bkash_no, nagad_no, 
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AI_ID,(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name,sum(total) total,
case when a.xzone in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(total) between 100 and 299 then sum(total)*5
	 when a.xzone not in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(total) between 200 and 299 then sum(total)*5
	 when  sum(total) between 300 and 399 then sum(total)*6.67
	 when sum(total) between 400 and 499 then sum(total)*7.50
	 when  sum(total) between 500 and 599 then sum(total)*8
	 when  sum(total) between 600 and 799 then sum(total)*8.33
	 when  sum(total) between 800 and 999 then sum(total)*8.75
	 when  sum(total)>=1000 then sum(total)*10 else 0 end Incentiveamount into August2021Cashincentive
from retail a  
--and a.xid in (select xid from retailtargetraw where Criteria_3<=200)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana,bkash_no, nagad_no


select * from August2021Cashincentive

SELECT        Zone_Name, Dealer_ID, Dealer_Name, Retail_ID, Retail_Name, xdistrict, xthana, bkash_no, nagad_no, RI_ID, RI_Name, AI_ID, AI_Name, ZI_Name, total, Incentiveamount
FROM            August2021Cashincentive

SELECT bkash_no,STUFF((SELECT ', ' + Retail_ID FROM August2021Cashincentive WHERE (bkash_no = c.bkash_no)
FOR XML PATH ('')) ,1,2,'') AS Retail_ID into BkashNo
FROM August2021Cashincentive c where bkash_no<>'' GROUP BY bkash_no


SELECT nagad_no,STUFF((SELECT ', ' + Retail_ID FROM August2021Cashincentive WHERE (nagad_no = c.nagad_no)
FOR XML PATH ('')) ,1,2,'') AS Retail_ID into nagadNo
FROM August2021Cashincentive c where nagad_no<>'' GROUP BY nagad_no

select  Zone_Name, Dealer_ID, Dealer_Name,  xdistrict, xthana,  RI_ID, RI_Name, AI_ID, AI_Name, ZI_Name, xmobile, 
bkash_no, nagad_no,total, Incentiveamount,Retail_Name,Retail_ID, case when Retail_ID<> 
case when  bkash_no<>'' then (select Retail_ID from BkashNo where bkash_no=August2021Cashincentive.bkash_no )
     when  nagad_no<>'' then (select Retail_ID from nagadNo where nagad_no=August2021Cashincentive.nagad_no ) end 
	 then case when  bkash_no<>'' then (select Retail_ID from BkashNo where bkash_no=August2021Cashincentive.bkash_no )
     when  nagad_no<>'' then (select Retail_ID from nagadNo where nagad_no=August2021Cashincentive.nagad_no ) end else '' end ,
(select sum(xamount) from cashdisbursement where xmobile=August2021Cashincentive.bkash_no and xtype='Bkash'),
(select sum(xamount) from cashdisbursement where xmobile=August2021Cashincentive.nagad_no and xtype='Nagad') 
from August2021Cashincentive where
case when  bkash_no<>'' then (select Retail_ID from BkashNo where bkash_no=August2021Cashincentive.bkash_no )
     when  nagad_no<>'' then (select Retail_ID from nagadNo where nagad_no=August2021Cashincentive.nagad_no ) end is not null

---------------NCML------------------------------------
with retail as (
select o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,o.bkash_no, o.nagad_no, 
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,o.xmobile,(d.xqtychl) total
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutletctg o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between  '2021-08-07' and '2021-08-31' and
c.xsimcardno <>'Corporate' --and d.xqtychl<1000
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,bkash_no, nagad_no, 
a.xriid RI_ID,(select xname from PCMLAPP.ERPonTheNet.dbo.prmst where xemp=a.xriid) RI_Name,
(select xtsoid from PCMLAPP.ERPonTheNet.dbo.cacushrc where xriid=a.xriid) AI_ID,
(select xname from PCMLAPP.ERPonTheNet.dbo.prmst where xemp=(select xtsoid from PCMLAPP.ERPonTheNet.dbo.cacushrc where xriid=a.xriid)) AI_Name,
(select xname from PCMLAPP.ERPonTheNet.dbo.prmst where xemp=(select xziid from PCMLAPP.ERPonTheNet.dbo.cazone where xzone=a.xzone)) ZI_Name,a.xmobile,sum(total) total,
case when a.xzone in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(total) between 100 and 299 then sum(total)*5
	 when a.xzone not in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(total) between 200 and 299 then sum(total)*5
	 when  sum(total) between 300 and 399 then sum(total)*6.67
	 when sum(total) between 400 and 499 then sum(total)*7.50
	 when  sum(total) between 500 and 599 then sum(total)*8
	 when  sum(total) between 600 and 799 then sum(total)*8.33
	 when  sum(total) between 800 and 999 then sum(total)*8.75
	 when  sum(total)>=1000 then sum(total)*10 else 0 end Incentiveamount into August2021Cashincentive
from retail a -- where a.xid='SYL-00454' 
--and a.xid in (select xid from retailtargetraw where Criteria_3<=200)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana,bkash_no, nagad_no,a.xmobile

--select * from August2021Cashincentive where Retail_ID='SYL-00454'

--drop table August2021Cashincentive




select  Zone_Name, Dealer_ID, Dealer_Name,  xdistrict, xthana,  RI_ID, 
(select xname from PCMLAPP.ERPonTheNet.dbo.prmst where xemp=August2021Cashincentive.RI_ID),xmobile, 
bkash_no, nagad_no,total, Incentiveamount,Retail_Name,Retail_ID, case when Retail_ID<> 
case when  bkash_no<>'' then (select Retail_ID from BkashNo where bkash_no=August2021Cashincentive.bkash_no )
     when  nagad_no<>'' then (select Retail_ID from nagadNo where nagad_no=August2021Cashincentive.nagad_no ) end 
	 then case when  bkash_no<>'' then (select Retail_ID from BkashNo where bkash_no=August2021Cashincentive.bkash_no )
     when  nagad_no<>'' then (select Retail_ID from nagadNo where nagad_no=August2021Cashincentive.nagad_no ) end else '' end ,
(select sum(xamount) from PCMLAPP.ERPonTheNet.dbo.cashdisbursement where xmobile=August2021Cashincentive.bkash_no and xtype='Bkash' and xcode='NCML'),
(select sum(xamount) from PCMLAPP.ERPonTheNet.dbo.cashdisbursement where xmobile=August2021Cashincentive.nagad_no and xtype='Nagod' and xcode='NCML') 
from August2021Cashincentive 


---------------AUGUST SEPTEMBER--------------------------------
with retail as (
select o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,o.bkash_no, o.nagad_no,o.xmobile, 
month(DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt)))) xper,(d.xqtychl) total
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between  '2021-08-07' and '2021-09-30' and
c.xgcus  in ('Retailer','Dealer','Net Dealer') and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' --and d.xqtychl<1000
 union all
 select o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid, o.bkash_no, o.nagad_no, o.xmobile, 
month(d.xdate) xper,d.xqty total
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2021-08-07' and '2021-09-30'  and 
c.xgcus  in ('Retailer','Dealer','Net Dealer') and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,bkash_no, nagad_no, 
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
(select xtsoid from cacushrc where xriid=a.xriid) AI_ID,(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
sum(total) total,sum(case when xper=8 then total else 0 end) AUGSALES,sum(case when xper=9 then total else 0 end) SEPSALES,
case when a.xzone in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(case when xper=8 then total else 0 end) between 100 and 299 then sum(case when xper=8 then total else 0 end)*5
	 when a.xzone not in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(case when xper=8 then total else 0 end) between 200 and 299 then sum(case when xper=8 then total else 0 end)*5
	 when  sum(case when xper=8 then total else 0 end) between 300 and 399 then sum(case when xper=8 then total else 0 end)*6.67
	 when sum(case when xper=8 then total else 0 end) between 400 and 499 then sum(case when xper=8 then total else 0 end)*7.50
	 when  sum(case when xper=8 then total else 0 end) between 500 and 599 then sum(case when xper=8 then total else 0 end)*8
	 when  sum(case when xper=8 then total else 0 end) between 600 and 799 then sum(case when xper=8 then total else 0 end)*8.33
	 when  sum(case when xper=8 then total else 0 end) between 800 and 999 then sum(case when xper=8 then total else 0 end)*8.75
	 when  sum(case when xper=8 then total else 0 end)>=1000 then sum(case when xper=8 then total else 0 end)*10 else 0 end IncentiveamountAUG,
	 case --when o.xzone in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(d.xqtychl) between 100 and 299 then sum(d.xqtychl)*5
	 when  sum(case when xper=9 then total else 0 end) between 100 and 199 then sum(case when xper=9 then total else 0 end)*5
	 when  sum(case when xper=9 then total else 0 end) between 200 and 299 then sum(case when xper=9 then total else 0 end)*5.5
	 when  sum(case when xper=9 then total else 0 end) between 300 and 399 then sum(case when xper=9 then total else 0 end)*6.67
	 when  sum(case when xper=9 then total else 0 end) between 400 and 499 then sum(case when xper=9 then total else 0 end)*7.50
	 when  sum(case when xper=9 then total else 0 end) between 500 and 599 then sum(case when xper=9 then total else 0 end)*8
	 when  sum(case when xper=9 then total else 0 end) between 600 and 799 then sum(case when xper=9 then total else 0 end)*8.33
	 when  sum(case when xper=9 then total else 0 end) between 800 and 999 then sum(case when xper=9 then total else 0 end)*8.75
	 when  sum(case when xper=9 then total else 0 end)>=1000 then sum(case when xper=9 then total else 0 end)*10 else 0 end IncentiveamountSEP into Cashincentive
from retail a  
--and a.xid in (select xid from retailtargetraw where Criteria_3<=200)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana,bkash_no, nagad_no


select *,(select total from August2021Cashincentive where  Dealer_ID=Cashincentive.Dealer_ID and Retail_ID=Cashincentive.Retail_ID),
(select Incentiveamount from August2021Cashincentive where Dealer_ID=Cashincentive.Dealer_ID and Retail_ID=Cashincentive.Retail_ID),
(select total from Sep2021Cashincentive where  Dealer_ID=Cashincentive.Dealer_ID and Retail_ID=Cashincentive.Retail_ID),
(select Incentiveamount from Sep2021Cashincentive where Dealer_ID=Cashincentive.Dealer_ID and Retail_ID=Cashincentive.Retail_ID)
from Cashincentive where Retail_ID='SYL-00544'
select Incentiveamount from August2021Cashincentive where Retail_ID='SYL-00544'



------------------------NCML---------------------------
with retail as (
select o.xzone,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,o.bkash_no, o.nagad_no,o.xmobile, 
month(DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt)))) xper,(d.xqtychl) total
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutletctg o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between  '2021-08-07' and '2021-10-06' and
c.xsimcardno<>'Corporate' --and d.xqtychl<1000
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,bkash_no, nagad_no, 
a.xriid RI_ID,(select xname from prmst where xemp=a.xriid) RI_Name,
sum(total) total,sum(case when xper=8 then total else 0 end) AUGSALES,
sum(case when xper=9 then total else 0 end) SEPSALES,sum(case when xper=10 then total else 0 end) OCTSALES,
case when a.xzone in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(case when xper=8 then total else 0 end) between 100 and 299 then sum(case when xper=8 then total else 0 end)*5
	 when a.xzone not in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(case when xper=8 then total else 0 end) between 200 and 299 then sum(case when xper=8 then total else 0 end)*5
	 when  sum(case when xper=8 then total else 0 end) between 300 and 399 then sum(case when xper=8 then total else 0 end)*6.67
	 when sum(case when xper=8 then total else 0 end) between 400 and 499 then sum(case when xper=8 then total else 0 end)*7.50
	 when  sum(case when xper=8 then total else 0 end) between 500 and 599 then sum(case when xper=8 then total else 0 end)*8
	 when  sum(case when xper=8 then total else 0 end) between 600 and 799 then sum(case when xper=8 then total else 0 end)*8.33
	 when  sum(case when xper=8 then total else 0 end) between 800 and 999 then sum(case when xper=8 then total else 0 end)*8.75
	 when  sum(case when xper=8 then total else 0 end)>=1000 then sum(case when xper=8 then total else 0 end)*10 else 0 end IncentiveamountAUG,
	 case --when o.xzone in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') and sum(d.xqtychl) between 100 and 299 then sum(d.xqtychl)*5
	 when  sum(case when xper=9 then total else 0 end) between 100 and 199 then sum(case when xper=9 then total else 0 end)*5
	 when  sum(case when xper=9 then total else 0 end) between 200 and 299 then sum(case when xper=9 then total else 0 end)*5.5
	 when  sum(case when xper=9 then total else 0 end) between 300 and 399 then sum(case when xper=9 then total else 0 end)*6.67
	 when  sum(case when xper=9 then total else 0 end) between 400 and 499 then sum(case when xper=9 then total else 0 end)*7.50
	 when  sum(case when xper=9 then total else 0 end) between 500 and 599 then sum(case when xper=9 then total else 0 end)*8
	 when  sum(case when xper=9 then total else 0 end) between 600 and 799 then sum(case when xper=9 then total else 0 end)*8.33
	 when  sum(case when xper=9 then total else 0 end) between 800 and 999 then sum(case when xper=9 then total else 0 end)*8.75
	 when  sum(case when xper=9 then total else 0 end)>=1000 then sum(case when xper=9 then total else 0 end)*10 else 0 end IncentiveamountSEP,
	 case 
	 when  sum(case when xper=10 then total else 0 end) between 100 and 199 then sum(case when xper=10 then total else 0 end)*5
	 when  sum(case when xper=10 then total else 0 end) between 200 and 299 then sum(case when xper=10 then total else 0 end)*5.5
	 when  sum(case when xper=10 then total else 0 end) between 300 and 399 then sum(case when xper=10 then total else 0 end)*6.67
	 when  sum(case when xper=10 then total else 0 end) between 400 and 499 then sum(case when xper=10 then total else 0 end)*7.50
	 when  sum(case when xper=10 then total else 0 end) between 500 and 599 then sum(case when xper=10 then total else 0 end)*8
	 when  sum(case when xper=10 then total else 0 end) between 600 and 799 then sum(case when xper=10 then total else 0 end)*8.33
	 when  sum(case when xper=10 then total else 0 end) between 800 and 999 then sum(case when xper=10 then total else 0 end)*8.75
	 when  sum(case when xper=10 then total else 0 end)>=1000 then sum(case when xper=10 then total else 0 end)*10 else 0 end IncentiveamountOCT  into Cashincentive
from retail a  
--and a.xid in (select xid from retailtargetraw where Criteria_3<=200)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana,bkash_no, nagad_no





--select o.zone_name,o.nagad_no MFS,(select max(bkash_no) from Cashincentive where nagad_no=o.nagad_no),
--sum(o.AUGSALES) AUGSALES,sum(o.SEPSALES) SEPSALES,sum(o.OCTSALES) OCTSALES,
--sum(o.IncentiveamountAUG) IncentiveamountAUG,sum(o.IncentiveamountSEP) IncentiveamountSEP,
--sum(o.IncentiveamountOCT) IncentiveamountOCT  from Cashincentive o where o.nagad_no<>'' and o.bkash_no<>''
--and o.nagad_no<>o.bkash_no
--group by o.zone_name,o.nagad_no



select o.zone_name,o.nagad_no MFS,(select max(bkash_no) from Cashincentive where nagad_no=o.nagad_no),
(select retail_id from nagadNo where nagad_no=o.nagad_no) ,
sum(o.AUGSALES) AUGSALES,sum(o.SEPSALES) SEPSALES,
(select total from  OCT21Cashincentive where mfs=o.nagad_no) OCTSALES,
sum(o.IncentiveamountAUG) IncentiveamountAUG,sum(o.IncentiveamountSEP) IncentiveamountSEP,
(select Incentiveamount from  OCT21Cashincentive where mfs=o.nagad_no) IncentiveamountOCT,
(select sum(xamount) from  cashdisbursement where xmobile=o.nagad_no and xtype='Bkash' and xcode='PCML') Bkash,
(select sum(xamount) from  cashdisbursement where xmobile=o.nagad_no and xtype='Nagod' and xcode='PCML') Nagod from 
Cashincentive o where o.nagad_no<>'' and o.bkash_no<>'' and o.nagad_no=o.bkash_no
group by o.zone_name,o.nagad_no


select o.zone_name,o.nagad_no MFS,(select max(bkash_no) from Cashincentive where nagad_no=o.nagad_no),
(select retail_id from nagadNo where nagad_no=o.nagad_no ) ,
sum(o.AUGSALES) AUGSALES,sum(o.SEPSALES) SEPSALES,
(select total from  OCT21Cashincentive where mfs=o.nagad_no) OCTSALES,
sum(o.IncentiveamountAUG) IncentiveamountAUG,sum(o.IncentiveamountSEP) IncentiveamountSEP,
(select Incentiveamount from  OCT21Cashincentive where mfs=o.nagad_no) IncentiveamountOCT,
(select sum(xamount) from  cashdisbursement where xmobile=o.nagad_no and xtype='Bkash' and xcode='PCML') Bkash,
(select sum(xamount) from  cashdisbursement where xmobile=o.nagad_no and xtype='Nagod' and xcode='PCML') Nagod from 
Cashincentive o where o.nagad_no<>'' and o.bkash_no<>'' and o.nagad_no<>o.bkash_no
group by o.zone_name,o.nagad_no


select o.zone_name,o.bkash_no MFS,(select max(nagad_no) from Cashincentive where bkash_no=o.bkash_no),
(select retail_id from BkashNo where bkash_no=o.bkash_no ) ,
sum(o.AUGSALES) AUGSALES,sum(o.SEPSALES) SEPSALES,
(select total from  OCT21Cashincentive where mfs=o.bkash_no) OCTSALES,
sum(o.IncentiveamountAUG) IncentiveamountAUG,sum(o.IncentiveamountSEP) IncentiveamountSEP,
(select Incentiveamount from  OCT21Cashincentive where mfs=o.bkash_no) IncentiveamountOCT,
(select sum(xamount) from  cashdisbursement where xmobile=o.bkash_no and xtype='Bkash' and xcode='PCML') Bkash,
(select sum(xamount) from  cashdisbursement where xmobile=o.bkash_no and xtype='Nagod' and xcode='PCML') Nagod from 
Cashincentive o where o.nagad_no<>'' and o.bkash_no<>'' and o.nagad_no<>o.bkash_no
group by o.zone_name,o.bkash_no

with cte as (
select zone_name,bkash_no MFS,sum(AUGSALES) AUGSALES,sum(SEPSALES) SEPSALES,sum(OCTSALES) OCTSALES,
sum(IncentiveamountAUG) IncentiveamountAUG,sum(IncentiveamountSEP) IncentiveamountSEP,
sum(IncentiveamountOCT) IncentiveamountOCT from Cashincentive where bkash_no<>'' and nagad_no=''
group by zone_name,bkash_no
union all
select zone_name,nagad_no MFS,sum(AUGSALES) AUGSALES,sum(SEPSALES) SEPSALES,sum(OCTSALES) OCTSALES,
sum(IncentiveamountAUG) IncentiveamountAUG,sum(IncentiveamountSEP) IncentiveamountSEP,
sum(IncentiveamountOCT) IncentiveamountOCT  from Cashincentive where nagad_no<>'' and bkash_no=''
group by zone_name,nagad_no
union all
select zone_name,nagad_no MFS,sum(AUGSALES) AUGSALES,sum(SEPSALES) SEPSALES,sum(OCTSALES) OCTSALES,
sum(IncentiveamountAUG) IncentiveamountAUG,sum(IncentiveamountSEP) IncentiveamountSEP,
sum(IncentiveamountOCT) IncentiveamountOCT  from Cashincentive where nagad_no<>'' and bkash_no<>''
and nagad_no=bkash_no
group by zone_name,nagad_no
)
select zone_name,MFS,case when (select retail_id from BkashNo where bkash_no=cte.mfs) is null then 
(select retail_id from nagadNo where nagad_no=cte.mfs) else (select retail_id from BkashNo where bkash_no=cte.mfs) end,
(select xoutletname from caoutletctg where xid =(case when (select retail_id from BkashNo where bkash_no=cte.mfs) is null then 
(select retail_id from nagadNo where nagad_no=cte.mfs) else (select retail_id from BkashNo where bkash_no=cte.mfs) end)),
sum(AUGSALES) AUGSALES,sum(SEPSALES) SEPSALES,sum(OCTSALES) OCTSALES,sum(IncentiveamountAUG) IncentiveamountAUG,
sum(IncentiveamountSEP) IncentiveamountSEP,sum(IncentiveamountOCT) IncentiveamountOCT,0,
(select sum(xamount) from  PCMLAPP.ERPonTheNet.dbo.cashdisbursement where xmobile=cte.MFS and xtype='Bkash' and xcode='NCML') Bkash,
(select sum(xamount) from  PCMLAPP.ERPonTheNet.dbo.cashdisbursement where xmobile=cte.MFS and xtype='Nagod' and xcode='NCML') Nagod
from cte --where MFS='01688044077' or  MFS='01688044077' 
group by zone_name,MFS 

--select sum(total),sum(AUGSALES),sum(SEPSALES),sum(OCTSALES),
--sum(IncentiveamountAUG),sum(IncentiveamountSEP) ,sum(IncentiveamountOCT),count(*)  from Cashincentive
----621365.000	268905.000	309900.000	42560.000	2264592.900	2706213.700	299295.000



select zone_name,bkash_no MFS,
(select retail_id from BkashNo where bkash_no=Cashincentive.bkash_no) ,
(select xoutletname from caoutletctg where xid =(select retail_id from BkashNo where bkash_no=Cashincentive.bkash_no) ),
sum(AUGSALES) AUGSALES,sum(SEPSALES) SEPSALES,sum(OCTSALES) OCTSALES,
sum(IncentiveamountAUG) IncentiveamountAUG,sum(IncentiveamountSEP) IncentiveamountSEP,
sum(IncentiveamountOCT) IncentiveamountOCT,
(select sum(xamount) from  PCMLAPP.ERPonTheNet.dbo.cashdisbursement where xmobile=Cashincentive.bkash_no and xtype='Bkash' and xcode='NCML') Bkash
from Cashincentive where nagad_no<>'' and bkash_no<>''
and nagad_no<>bkash_no
group by zone_name,bkash_no


select zone_name,nagad_no MFS,
(select retail_id from nagadNo where nagad_no=Cashincentive.nagad_no) ,
(select xoutletname from caoutletctg where xid =(select retail_id from nagadNo where nagad_no=Cashincentive.nagad_no) ),
sum(AUGSALES) AUGSALES,sum(SEPSALES) SEPSALES,sum(OCTSALES) OCTSALES,
sum(IncentiveamountAUG) IncentiveamountAUG,sum(IncentiveamountSEP) IncentiveamountSEP,
sum(IncentiveamountOCT) IncentiveamountOCT,
(select sum(xamount) from  PCMLAPP.ERPonTheNet.dbo.cashdisbursement where xmobile=Cashincentive.nagad_no and xtype='Nagod' and xcode='NCML') Nagod
from Cashincentive where nagad_no<>'' and bkash_no<>''
and nagad_no<>bkash_no
group by zone_name,nagad_no



SELECT 'Bkash' xtype,bkash_no mfs_no,STUFF((SELECT ', ' + xid FROM bkashnagodlog WHERE (bkash_no = c.bkash_no)
FOR XML PATH ('')) ,1,2,'') AS Retail_ID 
FROM bkashnagodlog c where bkash_no<>'' and bkash_no='01715303038' GROUP BY bkash_no
union all
SELECT 'Nagod' xtype,nagad_no mfs_no,STUFF((SELECT ', ' + xid FROM bkashnagodlog WHERE (nagad_no = c.nagad_no)
FOR XML PATH ('')) ,1,2,'') AS Retail_ID 
FROM bkashnagodlog c where nagad_no<>'' and bkash_no='01715303038'  GROUP BY nagad_no

SELECT xid,STUFF((SELECT ', ' + bkash_no FROM bkashnagodlog WHERE (xid = c.xid)  and len(bkash_no)>9 
FOR XML PATH ('')) ,1,2,'') AS bkash_no 
FROM bkashnagodlog c where  xid='GZP-00329' GROUP BY xid 
--having len(STUFF((SELECT ', ' + bkash_no FROM bkashnagodlog WHERE (xid = c.xid  and len(bkash_no)>9 ) FOR XML PATH ('')) ,1,2,''))>10
union all
SELECT xid,STUFF((SELECT ', ' + nagad_no FROM bkashnagodlog WHERE (xid = c.xid) and len(nagad_no)>9 
FOR XML PATH ('')) ,1,2,'') AS nagad_no 
FROM bkashnagodlog c where  xid='GZP-00329' GROUP BY xid



