with retail as (
select c.xbloodgrp xzone,c.xcus,c.xorg,xconfirmt,h.xchlnum,(d.xqtychl) total,
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-01' and '2021-08-07'   then d.xqtychl else  0 end "Aug_1to7",
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-08' and '2021-08-15' and
c.xbloodgrp not in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA') then d.xqtychl else  0 end "Aug_8to15",
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt))  between '2021-08-08' and '2021-08-11' and 
c.xbloodgrp  in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA')   then d.xqtychl else  0 end "Aug_8to11",
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-12' and '2021-08-15' and 
c.xbloodgrp  in ('BARISAL','FARIDPUR','JESSORE','KHULNA','KUSHTIA')  then d.xqtychl else  0 end "Aug_12to15",
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-16' and '2021-08-21'   then d.xqtychl else  0 end "Aug_16to21",
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-22' and '2021-08-28'   then d.xqtychl else  0 end "Aug_22to28",
case when  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-29' and '2021-08-31'   then d.xqtychl else  0 end "Aug_29to31"
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2021-08-01' and '2021-08-30'  and xsimcardno in ('Dhaka','Out Dhaka')

)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,
(select sum(xqty) from cacomslab  where xtype='Realistic Commission' and xcus=a.xcus )/31 Aug_1Day_Traget,
sum(Aug_1to7) Aug_1to7,sum(Aug_8to15) Aug_8to15,sum(Aug_8to11) Aug_8to11,sum(Aug_12to15) Aug_12to15,
sum(Aug_16to21) Aug_16to21,sum(Aug_22to28) Aug_22to28,sum(Aug_29to31) Aug_29to31 
from retail a group by a.xzone,a.xcus,a.xorg
