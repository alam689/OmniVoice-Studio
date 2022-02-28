select  h.zid,xbloodgrp xzone ,CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) xdate,year(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) )xyear,
month(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) ) xper,
sum(case when convert(varchar,h.xconfirmt,8) between '06:00:00' and '13:59:59'  then d.xqtychl else 0 end)/20 A_Shift,
sum(case when convert(varchar,h.xconfirmt,8) between '14:00:00' and '21:59:59'  then d.xqtychl else 0 end)/20 B_Shift,
sum(case when convert(varchar,h.xconfirmt,8) not between '06:00:00' and '21:59:59'  then d.xqtychl else 0 end)/20 C_Shift,
sum(xqtychl)/20 Total from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on h.zid=c.zid and h.xcus=c.xcus where  c.xsimcardno<>'Bag Plant' -- and CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))='2021-06-19'
group by h.zid,xbloodgrp ,CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)),year(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) ),month(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) ) 