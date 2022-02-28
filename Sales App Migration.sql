insert into cacusrii (ztime, zid, xcus, xriid, xzone, zemail, xorg, xname) as
select getdate(),100000,CustomerCode,EmployeeCode,xbloodgrp, 'khorshed@premiercement.com',xorg,(select xname from prmst where xemp=e.EmployeeCode) from pcml192.PremierCementOnline.dbo.salesperson s 
join pcml192.PremierCementOnline.dbo.customer c on s.CustomerID=c.CustomerID join pcml192.PremierCementOnline.dbo.employee e
on e.EmployeeID=s.SalesPersonID join cacus cc on c.CustomerCode=cc.xcus
where EmployeeCode  in (select xemp from prmst) and  xsimcardno in ('Dhaka','Out Dhaka')

insert into cacusrii (ztime, zid, xcus, xriid, xzone, zemail, xorg, xname) as
select getdate(),100000,xcus,xsp,xbloodgrp, 'khorshed@premiercement.com',xorg,(select xname from prmst where xemp=cacus.xsp) 
from cacus where xsimcardno in ('Dhakad','Out Dhakad','Corporate')

with cte as (
select CreatedAt,100000 zid,AdviceID,AdviceDate,( select customercode from PCML192.PremierCementOnline.dbo.customer where customerid= o.customerid) customercode,
(select xorg from cacus where xcus=( select customercode from PCML192.PremierCementOnline.dbo.customer where customerid= o.customerid)) xorg,
(select xid from caoutlet where xrow=o.shopno) xid,(select xoutletname from caoutlet where xrow=o.shopno) xoutletname,
(select thananame from PCML192.PremierCementOnline.dbo.thana where ThanaID=o.ThanaID) thananame,
(select warehousename from PCML192.PremierCementOnline.dbo.warehouse where WarehouseID=o.WarehouseID) warehousename,
(select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.RIID) employeecode,mobile,
(select CementTypeName from PCML192.PremierCementOnline.dbo.cementtype where cementtypeid=o.cementtypeid) CementTypeName,
(select bagtypename from PCML192.PremierCementOnline.dbo.bagtype where BagTypeID=o.bagtypeid) bagtypename,incentive,
cast(quantity as int) quantity,remarks,destination,
(select TearmsName from PCML192.PremierCementOnline.dbo.DeliveryTearms where Tearmsid=o.DeliveryTermsID) TearmsName,
(select TransportTypeName from PCML192.PremierCementOnline.dbo.transporttype where transporttypeid=o.transporttypeid) TransportTypeName,
(select advicestatusname from PCML192.PremierCementOnline.dbo.advicestatus where advicestatusid=o.advicestatus) advicestatusname,'' aa,CreatedAt ttt,'' dor,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.TSOID),'') TSOID,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.ZIID),'') ZIID,
case when RIID>0 then 1 else 0 end rr,case when TSOID>0 then 1 else 0 end tt,case when ZIID>0 then 1 else 0 end zz,'' yy,0 uu
from PCML192.PremierCementOnline.dbo.advice o where customerid in (select customerid from PCML192.PremierCementOnline.dbo.customer
where customercode in (select xcus from cacus where xbloodgrp in ('Dhaka North','Dhaka Middle')))
 and ShopNo not in ('Shop_No','Shop_No','NRY-00162','KST-00009','FN-00034','DNJ-00141','DHK-01854','CML-00019','BRS-00198'))

 select * into desiadvice from cte
  
 insert into opadviceapp
SELECT        CreatedAt, zid, AdviceID, AdviceDate, customercode, xorg, xid, xoutletname, thananame, warehousename, employeecode, mobile, 
CementTypeName, bagtypename, incentive, quantity, remarks, destination, TearmsName, 
                         TransportTypeName, advicestatusname, aa, ttt, dor, TSOID, ZIID, rr, tt, zz, yy, uu
FROM            desiadvice  where len(CementTypeName)<=20

select * from opadviceapp where xtrnnum  in (select xtrnnum from opadvice)

update  opadviceapp  set xstatus='Justified' where xtrnnum  in (select xtrnnum from opadvice)

insert into 
select * from oppaymentapp
select  CreatedAt,'',100000 zid,PaymentID,( select customercode from PCML192.PremierCementOnline.dbo.customer where customerid= o.customerid) customercode,
(select xorg from cacus where xcus=( select customercode from PCML192.PremierCementOnline.dbo.customer where customerid= o.customerid)) xorg,PaymentDate,
(select bankname from PCML192.PremierCementOnline.dbo.bank where bankID=o.bankID) bankname,Branch,amount,chequeno,'','',
case when PaymentTypeID=1 then 'Cash' when PaymentTypeID=2 then 'Cheque' else '' end  paymenttype,'',Remarks,CreatedAt,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.riid),'') riid,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.TSOID),'') TSOID,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.ZIID),'') ZIID,
case when RIID>0 then 1 else 0 end rr,case when TSOID>0 then 1 else 0 end tt,case when ZIID>0 then 1 else 0 end zz,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.ZIID),'') ZIID from 
PCML192.PremierCementOnline.dbo.payment o where customerid in (select customerid from PCML192.PremierCementOnline.dbo.customer
where customercode in (select xcus from cacus where xbloodgrp in ('Dhaka North','Dhaka Middle'))) 

select * from PCML192.PremierCementOnline.dbo.OrderInfo where FreeBag>0


select * from 
insert into oporderapp

select CreatedAt,'',100000 zid,OrderID,OrderDate,( select customercode from PCML192.PremierCementOnline.dbo.customer where customerid= o.customerid) customercode,
(select xorg from cacus where xcus=( select customercode from PCML192.PremierCementOnline.dbo.customer where customerid= o.customerid)) xorg,
(select CementTypeName from PCML192.PremierCementOnline.dbo.cementtype where cementtypeid=o.cementtypeid) CementTypeName,
(select CementCode from PCML192.PremierCementOnline.dbo.cementtype where cementtypeid=o.cementtypeid) CementCode,
(select bagtypename from PCML192.PremierCementOnline.dbo.bagtype where BagTypeID=o.bagtypeid) bagtypename,
coalesce((select name from PCML192.PremierCementOnline.dbo.Modifier where ModID=o.Modifierid),0) xratemodifier,
Quantity,Rate,carryingrate,IsIncentive, FreeBag, Quantity*Rate xlineamt, Quantity*(Rate-carryingrate) xamt,
(select warehousename from PCML192.PremierCementOnline.dbo.warehouse where WarehouseID=o.WarehouseID) warehousename,
(select thananame from PCML192.PremierCementOnline.dbo.thana where ThanaID=o.ThanaID) thananame,
(select TearmsName from PCML192.PremierCementOnline.dbo.DeliveryTearms where Tearmsid=o.DeliveryTermsID) xdelivery,'' xstatus,Remarks,
remarks xdelpoint,0 zactive,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.RIID),0) employeecode,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.TSOID),'') TSOID,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.ZIID),'') ZIID,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.RIID),0) employeecode,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.TSOID),'') TSOID,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.ZIID),'') ZIID,
coalesce((select employeecode from PCML192.PremierCementOnline.dbo.employee where employeeid=o.ZIID),'') ZII
from PCML192.PremierCementOnline.dbo.OrderInfo o where customerid in (select customerid from PCML192.PremierCementOnline.dbo.customer
where customercode in (select xcus from cacus where xbloodgrp in ('Dhaka North','Dhaka Middle')))

update oppaymentapp set xtrnnum=  'D'+''+xtrnnum


select xadvnum,xdate,xcus,xsp,xzonedel,xdiv,xdelpoint,xdestin,xwh,xid,xtrnnum,
(select xid from caoutlet where xrow=opadvice.xid) from
update opadvice set xid=(select xid from caoutlet where xrow=opadvice.xid)
where xdiv<>'Corporate' and xid>''  and xid not like '%-%'

select xadvnum,xdate,xcus,xordernum,xdiv,xdelpoint,xdestin,xwh,
(select xid from caoutlet where xrow=opchallan.xordernum) from
 update opchallan set xordernum=(select xid from caoutlet where xrow=opchallan.xordernum)
where xdiv<>'Corporate' and xordernum>''  and xordernum not like '%-%'