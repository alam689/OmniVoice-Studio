with cte as (
select c.xsimcardno Div,year(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))) xyear,
month(CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))) xper,d.xitem,d.xtypecat,
case when d.xitem='02-01-001-0002' and d.xtypecat not like '%Bulk%' then d.xqtychl else 0 end OPC_BAG,
case when d.xitem='02-01-001-0003' and d.xtypecat not like '%Bulk%' then d.xqtychl else 0 end AM_BAG,
case when d.xitem='02-01-001-0005' and d.xtypecat not like '%Bulk%' then d.xqtychl else 0 end BM_BAG,
case when d.xitem='02-01-001-0002' and d.xtypecat  like '%Bulk%' then d.xqtychl else 0 end OPC_Bulk,
case when d.xitem='02-01-001-0003' and d.xtypecat  like '%Bulk%' then d.xqtychl else 0 end AM_Bulk,
case when d.xitem='02-01-001-0005' and d.xtypecat  like '%Bulk%' then d.xqtychl else 0 end BM_Bulk,
d.xqtychl from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum
join cacus c on h.zid=c.zid and h.xcus=c.xcus
where CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) >='2017-01-01' 
)
select Div,xyear,xper,sum(OPC_BAG)/20 OPC_BAG,sum(AM_BAG)/20 AM_BAG,sum(BM_BAG)/20 BM_BAG,
sum(OPC_Bulk)/20 OPC_Bulk,sum(AM_Bulk)/20 AM_Bulk,sum(BM_Bulk)/20 BM_Bulk from cte
group by Div,xyear,xper
order by Div,xyear,xper

--select * from caitem where xitem in ('02-01-001-0002','02-01-001-0003','02-01-001-0005')




insert into cacuscorrt(ztime, zutime, zid, xblno, xcus, xitem, xdestin, xrate, xcomm, xrem, xdate, zactive, zemail, xemail, 
xwh, xcghdel, xnetrate, xdistrict, xlandcost, xdesc)
SELECT        getdate(), '', 100000, 1, tr1, tr2, tr, 0, 0, '', '2021-06-29', 1, '', '', '', 0, tr4, tr3, 0, 
(select xdesc from caitem where xitem=tr6.tr2 and zid=100000)
FROM            tr6 where tr1 not in (select xcus from cacuscorrt)

 insert into cacusrate( ztime, zutime, zid, xcus, xdistrict, xthana, xrow, xwh, xitem, xrate, xnetrate, xorate, xsrate, xbonus, xcomm, xrem, xdatefrom, 
 xdateto, zemail, xemail, zactive, xzone, xdesc)
 select 
 ztime, zutime, zid, xcus, xdistrict, xdestin, 1, 'NCML-Factory', xitem, xrate, xnetrate, 0, 0, 0, xcomm, xrem,
 '2021-06-29', '2999-12-31', zemail, xemail, zactive, (select xbloodgrp from cacus where xcus=cacuscorrt.xcus), xdesc
 from cacuscorrt where xcus not in (select xcus from cacusrate)