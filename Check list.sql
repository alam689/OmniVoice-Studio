select * from opchallan where xstatuschl='3-Invoiced' and xchlnum not in (select xref from glheader where xtrngl='INOP')
select * from glheader where xtrngl='INOP' and xref not in (select xchlnum from opchallan)
select xref,count(*) from glheader where xtrngl='INOP' group by xref having count(*)>1

with cte as (
select h.xvoucher,h.xref,d.xqty,d.xprime,sum(xqtychl) xqtychl,sum(xlineamt) xlineamt from glheader h join gldetail d on h.zid=d.zid and h.xvoucher=d.xvoucher
join opchalland c on h.zid=c.zid and h.xref=c.xchlnum  
where xtrngl='INOP' and d.xaccusage='AR' --and  h.xref='PCMLCHL-1121-001948'
group by  h.xvoucher,h.xref,d.xqty,d.xprime
)
select * from cte where xprime=xlineamt


with cte as (
select c.xsimcardno,c.xbloodgrp ,c.xcus,c.xorg,sum(d.xlineamt) xlineamt,sum(d.xqtychl) xqtychl from opchallan h 
join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum  
join cacus c on h.zid=c.zid and h.xcus=c.xcus  
where xstatuschl='3-Invoiced'and c.xsimcardno<>'Bag Plant' --and  h.xref='PCMLCHL-1121-001948'
group by c.xsimcardno,c.xbloodgrp ,c.xcus,c.xorg
)
select * from cte 


with cte as (
select c.xsimcardno,sum(d.xlineamt) xlineamt,sum(d.xqtychl) xqtychl from opchallan h 
join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum  
join cacus c on h.zid=c.zid and h.xcus=c.xcus  
where xstatuschl='3-Invoiced'and c.xsimcardno<>'Bag Plant' --and  h.xref='PCMLCHL-1121-001948'
group by c.xsimcardno --,c.xbloodgrp --,c.xcus,c.xorg
)
select * from cte 


SELECT       xsimcardno, xbloodgrp,  xcus, xorg, xqtygrn, xcrlimit, xamount, xsales, 
xfdate First_Tr_date, xtdate Last_Tr_date,xbalance, xdate last_sales_date, xpaydate last_payment_date,
xduration With_Premier, xlayoff, xlayoffdel, xlayoffpay, xlineamt, xqtychl
FROM            cacusactvity WHERE        (xsimcardno <> 'Bag Plant')