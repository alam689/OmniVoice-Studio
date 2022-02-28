with retail as (
select c.xbloodgrp xzone,c.xgcus,c.xorg,xconfirmt, 
DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) todate,(d.xqtychl) total,
case when  year( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2020 and 
month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqtychl else  0 end  "JUN20",
case when year( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2020 and 
month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=7 then d.xqtychl else  0 end  "JUL20",
 case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=08 then d.xqtychl else  0 end "AUG20",
 case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=09 then d.xqtychl else  0 end "SEP20",
 case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=10 then d.xqtychl else  0 end "OCT20",
 case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=11 then d.xqtychl else  0 end "NOV20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=12 then d.xqtychl else  0 end "DEC20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=1 then d.xqtychl else  0 end "JAN21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2 then d.xqtychl else  0 end  "FEB21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3 then d.xqtychl else  0 end  "MAR21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=4 then d.xqtychl else  0 end  "APR21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=5 then d.xqtychl else  0 end  "MAY21",
case when  year( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2021 and 
month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqtychl else  0 end  "JUN21",
case when year( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2021 and 
month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=7 then d.xqtychl else  0 end  "JUL21"
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus 
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) between '2020-06-01' and '2021-07-31'  and
c.xsimcardno in ('Dhaka','Out Dhaka')  )
select xzone,sum(JUN20)/20 JUN20,sum(JUL20)/20 JUL20,sum(AUG20)/20 AUG20,sum(SEP20)/20 SEP20,sum(OCT20)/20 OCT20,
sum(NOV20)/20 NOV20,sum(DEC20)/20 DEC20,sum(JAN21)/20 JAN21 ,sum(FEB21)/20 FEB21,sum(MAR21)/20 MAR21,
sum(APR21)/20 APR21,sum(MAY21)/20 MAY21,sum(JUN21)/20 JUN21,sum(JUL21)/20 JUL21 from retail
group by xzone

