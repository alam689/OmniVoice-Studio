with retail as (
select c.xbloodgrp xzone,c.xcus,c.xorg,xconfirmt,h.xchlnum,(d.xqtychl) total,
case when year( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2020  and month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=7 then d.xqtychl else  0 end "JUL20",
case when year( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2020  and month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=8 then d.xqtychl else  0 end "AUG20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=9 then d.xqtychl else  0 end "SEP20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=10 then d.xqtychl else  0 end  "OCT20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=11 then d.xqtychl else  0 end  "NOV20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=12 then d.xqtychl else  0 end  "DEC20",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=1 then d.xqtychl else  0 end "JAN21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2 then d.xqtychl else  0 end  "FEB21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=3 then d.xqtychl else  0 end  "MAR21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=4 then d.xqtychl else  0 end  "APR21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=5 then d.xqtychl else  0 end  "MAY21",
case when month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=6 then d.xqtychl else  0 end  "JUN21",
case when year( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2021  and   month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=7 then d.xqtychl else  0 end  "JUL21",
case when  year( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2021  and  month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=8  then d.xqtychl else  0 end AUG21,
case when  year( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=2021  and  month( CONVERT(date,DATEADD(HOUR,-6,xconfirmt)))=9  then d.xqtychl else  0 end SEP21
 from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on c.zid=h.zid and c.xcus=h.xcus  
where  c.xsimcardno  in ('Dhaka','Out Dhaka') and  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) 
between '2020-07-01' and CONVERT(date,getdate()-1)  
 
)
select a.xzone Zone_Name,a.xcus Dealer_ID,a.xorg Dealer_Name,sum(JUL20) JUL20,sum(AUG20) AUG20,sum(SEP20) SEP20,sum(OCT20) OCT20,
sum(NOV20) NOV20,sum(DEC20) DEC20,SUM(JAN21) JAN21,sum(FEB21) FEB21,sum(MAR21) MAR21,sum(APR21) APR21,sum(MAY21) MAY21,sum(JUN21) JUN21,
sum(JUL21) JUL21,sum(AUG21) AUG21,sum(SEP21) SEP21 from retail a --where a.xid in (select xid from retailtargetraw where xqtychl>=juntarget+julytarget)
group by a.xzone,a.xcus,a.xorg

