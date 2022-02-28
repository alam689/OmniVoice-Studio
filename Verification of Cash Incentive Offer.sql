
select xzone,xriid,(select xname from prmst where xemp=o.xriid),bkash_no,
(select distinct replace(xremark,'B2C Salary Payout via WEB to','') from     cashdisbursement where xmobile=o.bkash_no ),
count(*),(select sum(xamount) from     cashdisbursement where xmobile=o.bkash_no ),
STUFF((SELECT '-- ' + xid + ' - ' + xoutletname + ' Pro: ' + xproprietor+' Cont 1: ' +xmobile+' Cont 2: ' +xcmobile+' ' +name_bkash+' '+relation_bkash FROM caoutlet 
WHERE (bkash_no = o.bkash_no) FOR XML PATH ('')) ,1,2,'') AS NameValues
from caoutlet o where bkash_no is not null 
group by xzone,xriid,bkash_no having count(*)>1
order by bkash_no

select xzone,xriid,(select xname from prmst where xemp=o.xriid),nagad_no,
(select distinct replace(xremark,'B2C Salary Payout via WEB to','') from     cashdisbursement where xmobile=o.nagad_no ),
count(*),(select sum(xamount) from     cashdisbursement where xmobile=o.nagad_no ),
STUFF((SELECT '-- ' + xid + ' - ' + xoutletname + ' Pro: ' + xproprietor+' Cont 1: ' +xmobile+' Cont 2: ' +xcmobile+' ' +name_nagad+' '+relation_nagad FROM caoutlet 
WHERE (nagad_no = o.nagad_no) FOR XML PATH ('')) ,1,2,'') AS NameValues
from caoutlet o where nagad_no is not null 
group by xzone,xriid,nagad_no having count(*)>1


select xzone,xriid,(select xname from prmst where xemp=o.xriid),bkash_no,
(select distinct replace(xremark,'B2C Salary Payout via WEB to','') from     cashdisbursement where xmobile=o.bkash_no ),
count(*),(select sum(xamount) from     cashdisbursement where xmobile=o.bkash_no ),
STUFF((SELECT '-- ' + xid + ' - ' + xoutletname + ' Pro: ' + xproprietor+' Cont 1: ' +xmobile+' Cont 2: ' +xcmobile+' ' +name_bkash+' '+relation_bkash FROM caoutlet 
WHERE (bkash_no = o.bkash_no) FOR XML PATH ('')) ,1,2,'') AS NameValues
from caoutlet o where bkash_no is not null 
group by xzone,xriid,bkash_no having count(*)>1
order by bkash_no


with retail as (
select o.xzone,c.xgcus,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,o.xmobile,o.xcmobile,o.xproprietor,
o.bkash_no, o.name_bkash,o.relation_bkash,o.xmfstatus,o.nagad_no,o.name_nagad,o.relation_nagad,o.xmfstatusnagod,
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-07' and '2021-08-31' and
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')<>'Allocated' and d.xqtychl<1000
 union all
 select o.xzone, c.xgcus,o.xcus,c.xorg,o.xid,o.xoutletname,o.xthana,o.xdistrict,o.xriid,o.xmobile,o.xcmobile,o.xproprietor, 
 o.bkash_no, o.name_bkash,o.relation_bkash,o.xmfstatus,o.nagad_no,o.name_nagad,o.relation_nagad,o.xmfstatusnagod,
 DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,d.xqty total
from opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and d.xid=o.xid
where  d.xdate  between '2021-08-07' and '2021-08-31'  and 
c.xsimcardno in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated' 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,a.xid Retail_ID,a.xoutletname Retail_Name,xdistrict,xthana,
a.xriid RI_ID, (select xname from prmst where xemp=a.xriid) RI_Name,xmobile,xcmobile,xproprietor,bkash_no, name_bkash,relation_bkash,
xmfstatus,nagad_no,name_nagad,relation_nagad,xmfstatusnagod,
(select xtsoid from cacushrc where xriid=a.xriid) AI_ID,(select xname from prmst where xemp=(select xtsoid from cacushrc where xriid=a.xriid)) AI_Name,
(select xname from prmst where xemp=(select xziid from cazone where xzone=a.xzone)) ZI_Name1,
sum(total) total from retail a  where a.xgcus  in ('Retailer','Dealer','Net Dealer')
--and a.xid in (select xid from retailtargetraw where Criteria_3<=200)
group by a.xzone,a.xcus,a.xorg,a.xid,a.xoutletname,a.xriid,xdistrict,xthana,xmobile,xcmobile,xproprietor,bkash_no, name_bkash,relation_bkash,
xmfstatus,nagad_no,name_nagad,relation_nagad,xmfstatusnagod