with cte as (
 select h.zid, h.xcus,o.xzone, h.xconfirmt,  CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) xdate ,
 year(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))) xyear ,
 month(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))) xper ,
 h.xordernum xid,o.xoutletname,o.xproprietor,h.xsitemobile,h.xdelsite,o.xriid, h.xteam xteams,
d.xqtychl ,
case when month(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)))=11 then d.xqtychl else 0 end Nov2020,
case when month(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)))=2 then d.xqtychl else 0 end Feb2021
 from   opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum 
 join cacus c on c.zid=h.zid and c.xcus=h.xcus  join caoutlet o on h.zid=o.zid and h.xordernum=o.xid
where o.xcus<>'NA' and CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-09-01' and '2021-04-30' 
   and  h.xdiv in ('Dhaka','Out Dhaka')and coalesce(h.xdornum,'')<>'Allocated'
 union all
 select h.zid, h.xcus,o.xzone, h.xconfirmt,  CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) xdate ,
 year(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))) xyear ,
 month(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))) xper ,
 d.xid,o.xoutletname,o.xproprietor,h.xsitemobile,h.xdelsite, o.xriid, d.xriid xteams, 
d.xqty xqtychl,case when month(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)))=11 then d.xqty else 0 end Nov2020,
case when month(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)))=2 then d.xqty else 0 end Feb2021
from     opchallan h join opchallanalc d on h.zid=d.zid and h.xchlnum=d.xchlnum             
 join caoutlet o  on h.zid=o.zid and h.xordernum=o.xid where o.xcus<>'NA' and  
CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-09-01' and '2021-04-30'  
 and  h.xdiv in ('Dhaka','Out Dhaka') and coalesce(h.xdornum,'')='Allocated')
select xzone,xcus,xid,xoutletname,xriid,xyear,xper,sum(xqtychl) Total,sum(xqtychl)/8 AVGSales,sum(Nov2020) Nov2020,sum(Feb2021) Feb2021  
into outlettargetmax
from cte group by xzone,xcus,xid,xoutletname,xriid,xyear,xper
select  xzone,xcus,(select xorg from cacus where xcus=outlettarget.xcus) xorg,xid,xoutletname,xriid,
(select xname from prmst where xemp=outlettarget.xriid) xname,Total,AVGSales,
(select max(total) from outlettargetmax where xcus=outlettarget.xcus and xid=outlettarget.xid) maxSales
,Nov2020, Feb2021 into outlettargetf from outlettarget

select xzone,xcus,xorg,xid,xoutletname,xriid,
 xname,Total,AVGSales,maxSales,Nov2020, Feb2021,
 case when AVGSales<250 then 'Slab_200' when AVGSales between 250 and 349 then 'Slab_300'
  when AVGSales between 350 and 449 then 'Slab_400'  when AVGSales between 450 and 549 then 'Slab_500'
  when AVGSales between 550 and 699 then 'Slab_600'  when AVGSales between 700 and 849 then 'Slab_800'
  when AVGSales between 850 and 1049 then 'Slab_900'  when AVGSales between 1050 and 1349 then 'Slab_1200'
  when AVGSales between 1350 and 1649 then 'Slab_1500'  when AVGSales between 1650 and 2149 then 'Slab_1800'
  when AVGSales between 2150 and 2749 then 'Slab_2500'  when AVGSales between 2750 and 3499 then 'Slab_3000'
  when AVGSales between 3500 and 4499 then 'Slab_4000'  when AVGSales between 4500 and 5499 then 'Slab_5000'
   when AVGSales>5499 then 'Slab_6000' else '' end
 from outlettargetf 

select xzone,xcus,xorg,xid,xoutletname,xriid,
 xname,Total,AVGSales,maxSales,Nov2020, Feb2021,
 case when AVGSales<250 then 'Slab_200' when AVGSales between 250 and 349 then 'Slab_300'
  when AVGSales between 350 and 449 then 'Slab_400'  when AVGSales between 450 and 549 then 'Slab_500'
  when AVGSales between 550 and 699 then 'Slab_600'  when AVGSales between 700 and 849 then 'Slab_800'
  when AVGSales between 850 and 1049 then 'Slab_900'  when AVGSales between 1050 and 1349 then 'Slab_1200'
  when AVGSales between 1350 and 1649 then 'Slab_1500'  when AVGSales between 1650 and 2149 then 'Slab_1800'
  when AVGSales between 2150 and 2749 then 'Slab_2500'  when AVGSales between 2750 and 3499 then 'Slab_3000'
  when AVGSales between 3500 and 4499 then 'Slab_4000'  when AVGSales between 4500 and 5499 then 'Slab_5000'
   when AVGSales>5499 then 'Slab_6000' else '' end basedonavgSales,
   case when maxSales<250 then 'Slab_200' when maxSales between 250 and 349 then 'Slab_300'
  when maxSales between 350 and 449 then 'Slab_400'  when maxSales between 450 and 549 then 'Slab_500'
  when maxSales between 550 and 699 then 'Slab_600'  when maxSales between 700 and 849 then 'Slab_800'
  when maxSales between 850 and 1049 then 'Slab_900'  when maxSales between 1050 and 1349 then 'Slab_1200'
  when maxSales between 1350 and 1649 then 'Slab_1500'  when maxSales between 1650 and 2149 then 'Slab_1800'
  when maxSales between 2150 and 2749 then 'Slab_2500'  when maxSales between 2750 and 3499 then 'Slab_3000'
  when maxSales between 3500 and 4499 then 'Slab_4000'  when maxSales between 4500 and 5499 then 'Slab_5000'
   when maxSales>5499 then 'Slab_6000' else '' end basedonmaxSales,
    case when Nov2020<250 then 'Slab_200' when Nov2020 between 250 and 349 then 'Slab_300'
  when Nov2020 between 350 and 449 then 'Slab_400'  when Nov2020 between 450 and 549 then 'Slab_500'
  when Nov2020 between 550 and 699 then 'Slab_600'  when Nov2020 between 700 and 849 then 'Slab_800'
  when Nov2020 between 850 and 1049 then 'Slab_900'  when Nov2020 between 1050 and 1349 then 'Slab_1200'
  when Nov2020 between 1350 and 1649 then 'Slab_1500'  when Nov2020 between 1650 and 2149 then 'Slab_1800'
  when Nov2020 between 2150 and 2749 then 'Slab_2500'  when Nov2020 between 2750 and 3499 then 'Slab_3000'
  when Nov2020 between 3500 and 4499 then 'Slab_4000'  when Nov2020 between 4500 and 5499 then 'Slab_5000'
   when Nov2020>5499 then 'Slab_6000' else '' end basedonNov2020,
       case when Feb2021<250 then 'Slab_200' when Feb2021 between 250 and 349 then 'Slab_300'
  when Feb2021 between 350 and 449 then 'Slab_400'  when Feb2021 between 450 and 549 then 'Slab_500'
  when Feb2021 between 550 and 699 then 'Slab_600'  when Feb2021 between 700 and 849 then 'Slab_800'
  when Feb2021 between 850 and 1049 then 'Slab_900'  when Feb2021 between 1050 and 1349 then 'Slab_1200'
  when Feb2021 between 1350 and 1649 then 'Slab_1500'  when Feb2021 between 1650 and 2149 then 'Slab_1800'
  when Feb2021 between 2150 and 2749 then 'Slab_2500'  when Feb2021 between 2750 and 3499 then 'Slab_3000'
  when Feb2021 between 3500 and 4499 then 'Slab_4000'  when Feb2021 between 4500 and 5499 then 'Slab_5000'
   when Feb2021>5499 then 'Slab_6000' else '' end basedonFeb2021
 from outlettargetf 


select xzone,
sum(case when xqtychl between 100 and 199 then 1 else 0 end)  xqty100Q,
sum(case when xqtychl between 100 and 199 then xqtychl else 0 end) xqty100,
sum(case when xqtychl between 200 and 299 then 1 else 0 end)  xqty200Q,
sum(case when xqtychl between 200 and 299 then xqtychl else 0 end) xqty200,
sum(case when xqtychl between 300 and 399 then 1 else 0 end)  xqty300Q,
sum(case when xqtychl between 300 and 399 then xqtychl else 0 end) xqty300,
sum(case when xqtychl between 400 and 499 then 1 else 0 end)  xqty400Q,
sum(case when xqtychl between 400 and 499 then xqtychl else 0 end) xqty400,
sum(case when xqtychl between 500 and 500 then 1 else 0 end)  xqty500Q,
sum(case when xqtychl between 500 and 500 then xqtychl else 0 end) xqty500,
sum(case when xqtychl between 600 and 699 then 1 else 0 end)  xqty600Q,
sum(case when xqtychl between 600 and 699 then xqtychl else 0 end) xqty600,
sum(case when xqtychl between 700 and 799 then 1 else 0 end)  xqty700Q,
sum(case when xqtychl between 700 and 799 then xqtychl else 0 end) xqty700,
sum(case when xqtychl between 800 and 899 then 1 else 0 end)  xqty800Q,
sum(case when xqtychl between 800 and 899 then xqtychl else 0 end)  xqty800Q,
sum(case when xqtychl between 900 and 999 then 1 else 0 end) xqty900Q,
sum(case when xqtychl between 900 and 999 then xqtychl else 0 end) xqty900,
sum(case when xqtychl >=1000 then 1 else 0 end) xqty1000Q,
sum(case when xqtychl >=1000 then xqtychl else 0 end) xqty1000
from opchallandt where xdatecom between '2021-05-05' and '2021-05-21' and xdiv in ('Dhaka','Out Dhaka')
group by  xzone

    