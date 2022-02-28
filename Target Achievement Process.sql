select xemp,xempnew,xqty,xtotamt,(select sum(xqtychl)/20 from opchallandt where xdatecom between  '2020-10-01' and '2020-10-11' and xteam=opritargetdt.xemp),xdayscom 
from update opritargetdt set xtotamt=(select sum(xqtychl)/20 from opchallandt where xdatecom between  '2020-10-01' and '2020-10-11' and xteam=opritargetdt.xemp) ,xdayscom=11
where xyear=2020 and xper=10

select  d.xdiv,d.xzone,d.xcus,d.xorg,sum(case when c.xitemold='OPC' then (xqtyord-xqtychl)/20 else 0 end) OPC,
sum(case when c.xitemold='PCC-AM' then (xqtyord-xqtychl)/20 else 0 end) "PCC-AM" ,
sum(case when c.xitemold='PCC-BM' then (xqtyord-xqtychl)/20 else 0 end) "PCC-BM",
sum(case when c.xitemold='PPC' then  (xqtyord-xqtychl)/20 else 0 end) "PPC",sum(xqtyord-xqtychl)/20
from opdorddt d join caitem c on d.zid=c.zid and d.xitem=c.xitem
where xstatusdor not in ('C-Cancelled','5-Challaned') and d.xdiv<>'Bag Plant' -- and xcus='CUS-000041'
group by d.xdiv,d.xzone,d.xcus,d.xorg