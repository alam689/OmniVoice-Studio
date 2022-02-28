select * from glheader where xtrngl='ob--'
select * into glbalyear2018 from glbalyear where zid=100000 and xyear=2018  --order by xacc
select * from gldetail where xvoucher='OB--000009'  order by xrow desc

insert into gldetail 
(zid, xvoucher,xrow,xacc,xaccusage,xaccsource,xsub,xdiv,xsec,xproj,xcur,xexch,xprime,xbase,xlong,xicacc,xicsub,xacctype,zemail,xemail,xstatusrfp,xicdiv,xicsec,xicproj,xvmcode,xamount,xrem,xallocation,xcheque,xpaytype,xstatus,xtypegl) 
select b.zid,'OB--000009', ROW_NUMBER() OVER (ORDER BY b.xacc) AS New_Id ,
b.xacc,g.xaccusage,g.xaccsource,b.xsub,'','','','BDT',1.0,xlineamt,xlineamt,'','','',g.xacctype,'khorshed@premiercement.com','','','','','','',0,'',0,'','','',''
from glbalyear2020 b join glmst g on b.zid=g.zid and b.xacc=g.xacc
where b.xlineamt<>0 order by b.xacc, b.xsub

select sum(xprime*xexch) from gldetailview where zid=100000 and xyear=2020
and (xacctype='Income' or xacctype='Expenditure') --215101010001


select sum(xlineamt) from glbalyear2018 where xlineamt<>0
select sum(xlineamt) from glbalyear2019 where xlineamt<>0
select sum(xlineamt) from glbalyear2020 where xlineamt<>0
