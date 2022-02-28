
select d.xvmcode,v.xmaxload,v.xvhcat,v.xregdate,datediff(year,v.xregdate,getdate()),
v.xmanufacturer,sum(case when xper=9 then xprime else 0 end) ,
sum(case when xper=10 then xprime else 0 end) ,sum(case when xper=11 then xprime else 0 end) ,sum(case when xper=12 then xprime else 0 end) 
from glheader h join gldetail d on h.zid=d.zid and h.xvoucher=d.xvoucher join vmvech v on d.zid=v.zid and d.xvmcode=v.xvehicle
where xyear=2020 and xper in (9,10,11,12) and d.xvmcode<>''
and d.xacc in ('411122010003','321101020014','321101020015')
group by d.xvmcode,v.xmaxload,v.xvhcat,v.xregdate,v.xlservdate,v.xmanufacturer