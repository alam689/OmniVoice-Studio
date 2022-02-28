with cte as (
select xsub,xorg,xbloodgrp,xsp,(select xname from prmst where zid=100000 and xemp=c.xsp) xname, sum(case WHEN  H.xtrngl='INOP' and d.xaccusage='AR' and H.xdate>='2020-01-01 06:00:00.000' THEN d.xqty ELSE 0 END) Totalsales_qty ,
sum(case WHEN  H.xtrngl='INOP' and d.xaccusage='AR'  and H.xdate>='2020-01-01 06:00:00.000' THEN d.xprime ELSE 0 END) Totalsales_amt, SUM(xprime) balance
from  glheader H JOIN gldetail D ON H.zid=D.zid AND H.xvoucher=D.xvoucher JOIN cacus C ON D.zid=C.zid AND D.xsub=C.xcus WHERE  
H.xtrngl<>'ob--' --and d.xsub in (SELECT     tr FROM         tr3)
AND H.xdate<='2020-12-22 06:00:00.000' AND xpostflag='Posted' and xsimcardno='Corporate'
group by xsub,xbloodgrp,xorg,xsp
)
select * from cte

WITH opsalesdo (zid,xcus,DORemaining, tillsales, ondsales,DARemaining)
      AS(
select h.zid,h.xcus,sum(xqty-xqtychl)/20 DORemaining,0 tillsales,0 ondsales,0 DARemaining from opdor h join opddt
d on h.zid=d.zid and h.xdornum=d.xdornum where xstatusdor<>'C-Cancelled' and xdate<='2020-11-08' 
group by h.zid,h.xcus having sum(xqty-xqtychl)>0
union all
select h.zid,h.xcus,sum(xqtychl/20) DORemaining,0 tillsales,0 ondsales,0 DARemaining from opchallan h join 
opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum where xstatuschl='3-Invoiced' and 
CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>'2020-11-08' group by h.zid,h.xcus
union all
select h.zid,h.xcus,0 DORemaining,sum(xqtychl/20) tillsales,sum(case when CONVERT(date,DATEADD(HOUR,-6,xconfirmt))='2020-11-08'
then xqtychl/20 else 0 end) ondsales,0 DARemaining from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum 
where xstatuschl='3-Invoiced' and CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between   '2020-11-01' and '2020-11-08' group by h.zid,h.xcus
union all
select zid,xcus,0 DORemaining,0 tillsales,0 ondsales,sum(xqtysms-xqtychl)/20 from opadvice where 
xstatusadvmach not in ('5-Voided','1-Open') and CONVERT(date,DATEADD(HOUR,-6,xconfirmt))<='2020-11-08' group by zid,xcus 
union all
select h.zid,h.xcus,0 DORemaining,0 tillsales,0 ondsales,sum(xqtychl/20) DARemaining from opchallan h join opchalland d 
on h.zid=d.zid and h.xchlnum=d.xchlnum where xstatuschl='3-Invoiced' and CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>'2020-11-08' 
and xadvnum not in (select xadvnum from opadvice where CONVERT(date,DATEADD(HOUR,-6,xconfirmt))>'2020-11-08') group by h.zid,h.xcus
)
select xsimcardno,case when xsimcardno='Corporate' then xspouse else xbloodgrp end xbloodgrp, sum(DORemaining) DORemaining, 
sum(tillsales) tillsales, sum(ondsales) ondsales,sum(DARemaining) DARemaining from opsalesdo t join cacus c on t.zid=c.zid 
and t.xcus=c.xcus where xsimcardno<>'Bag Plant' group by xsimcardno,case when xsimcardno='Corporate' then xspouse else xbloodgrp end