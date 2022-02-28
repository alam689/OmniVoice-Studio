Stock Status Correction :
select * from poodt where zid=101 and xitemext<>''
--update poodt set  xitemext=''  where zid=101 and xitemext<>''

SELECT * FROM opodtview where xordernum in ('CO--002022','CO--002023') 
select gldetail.xvoucher,abs(sum(xexch*xprime)) from gldetail join glheader on gldetail.xvoucher=glheader.xvoucher and gldetail.zid=glheader.zid where glheader.zid=101
group by gldetail.xvoucher  having abs(sum(xexch*xprime))<>0 

select ztime,xordernum,xitem,xqtyord,xstdcost,case when xqtyord=33 then 91.8485 else 87.8 end  from opqty where 
 xordernum in (select xordernum from opord  where xdate between '2021-09-01' and '2021-09-30' and zid=101) order by  xqtyord in (33,45)

update opqty set xstdcost=case when xqtyord=33 then 91.8485 else 87.8 end where xitem='10001' and 
 xordernum in (select xordernum from opord  where xdate between '2021-10-01' and '2021-10-31' and zid=101) and xqtyord in (33,45)

select l.xordernum,d.xitem,h.xqtyord,h.xstdcost,d.xitem,d.xrate,d.xprice,d.xqtyset from opodt d join opqty h on d.zid=h.zid and d.xordernum=h.xordernum 
join opord l on d.zid=l.zid and d.xordernum=l.xordernum 
where l.xdate between '2021-07-01' and '2021-07-31' and l.zid=101 order by xqtyord

select ztime,xordernum,xitem,(select xdesc from caitem where xitem=opqty.xitem and zid=opqty.zid),
xqtyord,xstdcost,xprice ,(select xrate from opodt where xordernum=opqty.xordernum)*(select xqtyset from opodt where xordernum=opqty.xordernum) from opqty 
where  xordernum in (select xordernum from opord  where xdate between '2021-09-01' and '2021-09-05' and zid=101) and xitem<>'10001'
--and xprice <>(select xrate from opodt where xordernum=opqty.xordernum)

select l.xordernum,d.xitem,d.xqtyset,d.xitem,d.xrate,d.xprice,d.xqtyset,d.xprice*d.xqtyset from opodt d join opord l on d.zid=l.zid and d.xordernum=l.xordernum 
where l.xdate between '2021-09-01' and '2021-09-30' and l.zid=101 
and l.xordernum not in (select xdocnum from glheader)

select zid,xvoucher,xdate,
case when extract(month from xdate)<7 then extract(year from xdate)-1 else extract(year from xdate) end yy,
case when extract(month from xdate)<7 then extract(month from xdate)+12-6 else extract(month from xdate)-6 end pp,
extract(year from xdate),extract(month from xdate),xyear,xper from glheader where xdate < '2022-01-31'
and case when extract(month from xdate)<7 then extract(year from xdate)-1 else extract(year from xdate) end<>xyear
and case when extract(month from xdate)<7 then extract(month from xdate)+12-6 else extract(month from xdate)-6 end <>xper
order by xdate

select zid,xvoucher,xdate,
case when extract(month from xdate)<7 then extract(year from xdate)-1 else extract(year from xdate) end yy,
case when extract(month from xdate)<7 then extract(month from xdate)+12-6 else extract(month from xdate)-6 end pp,
extract(year from xdate),extract(month from xdate),xyear,xper from glheader where xdate < '2022-01-31'
and case when extract(month from xdate)<7 then extract(year from xdate)-1 else extract(year from xdate) end=xyear
and case when extract(month from xdate)<7 then extract(month from xdate)+12-6 else extract(month from xdate)-6 end =xper

update glheader set xper=case when extract(month from xdate)<7 then extract(month from xdate)+12-6 else extract(month from xdate)-6 end
where xdate < '2022-01-31'
and case when extract(month from xdate)<7 then extract(year from xdate)-1 else extract(year from xdate) end=xyear
and case when extract(month from xdate)<7 then extract(month from xdate)+12-6 else extract(month from xdate)-6 end <>xper


