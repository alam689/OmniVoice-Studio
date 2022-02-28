with cte as(
select xrow,xid,xoutletname,xcode,Xthana,xdistrict, xcus,xzone,xbloodgrp,(select xcode from cadistrict where xdistrict=caoutlet.xdistrict) cc,
(select xcode from cadistrict where xdistrict=caoutlet.xdistrict)+'-'+RIGHT('000000' +cast((select max(substring(xid,5,5)) from caoutlet where xcode=(select xcode from cadistrict 
where xdistrict=caoutlet.xdistrict))+ROW_NUMBER() OVER (ORDER BY xrow) as varchar),5) xidd from caoutlet  where xid<'BGR-00001' and xcus<>'NA'
)
select * from cte
--update cte set xid=xidd,xcode=cc
--select xid,count(*) from caoutlet group by xid having count (*)>1

select   caoutlet.xzone,caoutlet.xcus,cacus.xorg,xrow,caoutlet.xid,caoutlet.xoutletname,caoutlet.xproprietor ,caoutlet.xaddress
,caoutlet.xdistrict, caoutlet.Xthana ,caoutlet.xriid,(select xname from prmst where xemp=caoutlet.xriid),
(select xempnew from opritargetdt where xemp=caoutlet.xriid and xyear=2020 and xper=10 and xemp<>'') AIID,
(select xname from prmst where xemp=(select xempnew from opritargetdt where xemp=caoutlet.xriid and xyear=2020 and xper=10 and xemp<>'')) AIName
from caoutlet join cacus on caoutlet.xcus=cacus.xcus 

select   caoutlet.xzone,caoutlet.xcus,cacus.xorg,xrow,caoutlet.xid,caoutlet.xoutletname,
caoutlet.xdistrict, caoutlet.Xthana ,caoutlet.xriid,(select xname from prmst where xemp=caoutlet.xriid),
(select xempnew from opritargetdt where xemp=caoutlet.xriid and xyear=2020 and xper=10 and xemp<>'') AIID,
(select xname from prmst where xemp=(select xempnew from opritargetdt where xemp=caoutlet.xriid and xyear=2020 and xper=10 and xemp<>'')) AIName
from caoutlet join cacus on caoutlet.xcus=cacus.xcus  where caoutlet.xzone='Faridpur'



insert into caoutlet (ztime, zutime, zid, xrow, xoutletname, xid, xproprietor, xmobile, xaddress, Xthana, xcus, xriid, xzone, mob, xbloodgrp, xdistrict, xcode, xqtydel, xqtychl, xdiv)
SELECT        ztime, zutime, zid, xrow, xoutletname, xid, xproprietor, xmobile, xaddress, Xthana, xcus, xriid, xzone, mob, xbloodgrp, xdistrict, xcode, xqtydel, xqtychl, xdiv
FROM            caoutletbackup
WHERE        (xrow = '1052') AND (xcus = 'CUS-000060')

select max(xrow)+1 from caoutlet

with cte as (
select c.xbloodgrp, c.xcus,c.xorg,o.xrow,o.xid,o.xoutletname,o.xproprietor,o.xriid,h.xteam from 
caoutlet o join cacus c on c.zid=o.zid and c.xcus=o.xcus join opchallan h on h.zid=o.zid and h.xordernum=o.xrow
where o.xriid<>h.xteam and xconfirmt>'2020-09-01' 
)
update cte set xriid=xteam

insert into Outlet(     
OutletName, CustomerCode, xnamec, Phone, xnidc, xemailc, ShopNo, Address, xlat, xlong, xbazar, xdistrict, xthana,
 PostCode, xyeasno, xdesc, Note, xsalsvolume, xrate, 
xnamep, Mobile, xnidp, Email, xage, xdistricth, Addressr, xfamily, CustomerID, RouteID, OpeningDate, Active, CreatedAt, UserID
)
SELECT    xoutletname, xcus,  coalesce(xproprietor,''), xmobile, '','',xrow, coalesce(xaddress,''),1,1,'','',coalesce(Xthana,''),
'',1,'','',0,0, coalesce(xproprietor,''), xmobile,'','',1,'','','', (select CustomerID from Customer where CustomerCode= c.xcus),0,'2020-02-01',1,GETDATE(), 1
FROM          erp200.ERPonTheNet.dbo.caoutlet c where xrow='1052' 


select xrow,xoutletname,xid,xmobile,xriid,xzone,xcus,
(select employeecode from  pcml192.PremierCementOnline.dbo.employee where employeeid=
(select  employeeid from pcml192.PremierCementOnline.dbo.[user] where userid=
(select userid from  pcml192.PremierCementOnline.dbo.outlet where shopno=caoutlet.xrow))),
(select userid from  pcml192.PremierCementOnline.dbo.outlet where shopno=caoutlet.xrow)
from  
update caoutlet set xriid=(select employeecode from  pcml192.PremierCementOnline.dbo.employee where employeeid=
(select  employeeid from pcml192.PremierCementOnline.dbo.[user] where userid=
(select userid from  pcml192.PremierCementOnline.dbo.outlet where shopno=caoutlet.xrow)))
 where xcus in (select xcus from cacus) and xriid not in (select xemp from prmst)

select *,xcode+'-'+RIGHT('00000' + CAST(ROW_NUMBER () OVER (PARTITION BY xcode ORDER BY xcode) AS varchar), 5) as xid2 
into caoutletcc  from  caoutlet where xcus<>'NA' and xcus<>''  and xdistrict is not null
-------------------insert outlet from Dummy Table:
insert into caoutlet(ztime, zutime, zid, xrow, xoutletname,xid, 
 xproprietor, xmobile, xaddress, Xthana, xcus, xriid, xzone, mob, 
xbloodgrp, xdistrict, xcode)
select GETDATE(),GETDATE(),zid,(select MAX(xrow) from caoutlet)+ROW_NUMBER() OVER (ORDER BY xrow) xrow,xoutletname,
(select xcode from cadistrict where xdistrict=caoutletcc.xdistrict)+'-'+RIGHT('000000' +cast((select max(substring(xid,5,5)) from caoutlet where xcode=(select xcode from cadistrict 
where xdistrict=caoutletcc.xdistrict))+ROW_NUMBER() OVER (ORDER BY xrow) as varchar),5) xid,
xproprietor, xmobile, xaddress, Xthana, xcus, xriid, xzone, coalesce(mob,0), xzone, xdistrict,
(select xcode from cadistrict where xdistrict=caoutletcc.xdistrict) from caoutletcc

-----------------------------
insert into Outlet(     
OutletName, CustomerCode, xnamec, Phone, xnidc, xemailc, ShopNo, Address, xlat, xlong, xbazar, xdistrict, xthana,
 PostCode, xyeasno, xdesc, Note, xsalsvolume, xrate, 
xnamep, Mobile, xnidp, Email, xage, xdistricth, Addressr, xfamily, CustomerID, RouteID, OpeningDate, Active, CreatedAt, UserID
)
SELECT    xoutletname, xcus,  coalesce(xproprietor,''), xmobile, '','',xrow, coalesce(xaddress,''),1,1,'','',coalesce(Xthana,''),
'',1,'','',0,0, coalesce(xproprietor,''), xmobile,'','',1,'','','', (select CustomerID from Customer where CustomerCode= c.xcus),0,'2020-02-01',1,GETDATE(), 1
FROM          erp200.ERPonTheNet.dbo.caoutlet c where xcus<>'NA'  and 
xrow not in (select cast(ShopNo as int) from Outlet where ShopNo not in ('Shop_No','test') ) 


----------------------------------

select xrow,xid,(select xid2 from caoutletcc where xrow=caoutlet.xrow ) from 
update caoutlet set xid=(select xid2 from caoutletcc where xrow=caoutlet.xrow )
where xcus<>'NA' and xcus<>''  and xdistrict is not null

insert into caoutlet( ztime, zutime, zid, xrow, xoutletname, xid, xproprietor, xmobile, xaddress, Xthana, xcus,
xriid, xzone,mob, xbloodgrp, xdistrict, xcode,xcname,xcmobile,
xcnid, xpnid, xbazar, xscat, xnote, xpcode, xhdistrict, xraddress, xfamily, xispremier, xcemail, xpemail, xroute, xage,
xlink, xlink1, xlink2, zactive, xsalsvolume, xrate,xolat, xolong, xulat, xulong,
xotp, xstatus, xtsoid, xziid, xtsoauth, xziauth, xriname, xtsoname, xziname, xcreatedby, xorg)
select GETDATE(),GETDATE(),zid,(select max(xrow) from caoutlet)+ROW_NUMBER() OVER (ORDER BY xcus),
xorg,xcus,'Dealer Own',substring((REPLACE(xfphone,'-','')),1,11),xoffadd,xdistrict,xcus,
coalesce((select xziid from cazone where xzone=cacus.xbloodgrp),''),xbloodgrp,'',xbloodgrp,xdistrict,'CUS','','',
'','','','','','','','','',0,'','','',0,
'','','',1,0,0,0,0,0,0,
'','',(select xziid from cazone where xzone=cacus.xbloodgrp),(select xziid from cazone where xzone=cacus.xbloodgrp),1,1,'','','','',xorg 
from cacus where xcus not in(
select xid from caoutlet)
and xsimcardno in ('Dhaka' ,'Out Dhaka')and xcus<>'CUS-0002' and xstatuscus<>'6-Held'



insert into Outlet(     
OutletName, CustomerCode, xnamec, Phone, xnidc, xemailc, ShopNo, Address, xlat, xlong, xbazar, xdistrict, xthana,
 PostCode, xyeasno, xdesc, Note, xsalsvolume, xrate, 
xnamep, Mobile, xnidp, Email, xage, xdistricth, Addressr, xfamily, CustomerID, RouteID, OpeningDate, Active, CreatedAt, UserID
)
SELECT    xoutletname, xcus,  coalesce(xproprietor,''), substring(xmobile,1,11), '','',xrow, coalesce(xaddress,''),1,1,'','',coalesce(Xthana,''),
'','True','','',0,0, coalesce(xproprietor,''),  substring(xmobile,1,11),'','',1,'','','', 
coalesce((select CustomerID from Customer where CustomerCode= c.xcus),0),0,'2020-02-01','True',GETDATE(), 1
FROM          erp200.ERPonTheNet.dbo.caoutlet c where xcus<>'NA'  and 
xrow not in (select ShopNo from Outlet  )-- and  (select CustomerID from Customer where CustomerCode= c.xcus) is null





select   ThanaID, DistrictID, ThanaName, CreatedAt, UserID
 from thana where ThanaName not in (select xthana from erp200.ERPonTheNet.dbo.cadelpoint)




insert into caoutlet(ztime,  zid, xrow, xoutletname, xid, xproprietor, xmobile, xaddress, Xthana, xcus, xriid, xzone, mob, xbloodgrp,
xdistrict, xcode, xqtydel, xqtychl, xdiv, xcname, xcmobile, xcnid, xpnid, xbazar, xscat, xnote, xpcode, xhdistrict, 
xraddress, xfamily, xispremier, xcemail, xpemail, xroute, xage, xlink, xlink1, xlink2, zactive, xsalsvolume, xrate,
xotp, xstatus, xtsoid, xziid, xtsoauth, xziauth, xriname, xtsoname, xziname, 
xcreatedby, xorg)
select getdate() ztime,100000 zid,(select MAX(xrow) from caoutlet)+ROW_NUMBER() OVER (ORDER BY xoutletname) xrow,
 xoutletname,'NA' xid,coalesce(xproprietor,'') xproprietor,coalesce(xmobile,''),xaddress,xthana,'NA' xcus, demori,xzone,0,xzone,
 xdistrict,'',0,0,'',coalesce(xproprietor,'') xcname,coalesce(xmobile,'') xcmobile,'','','','','','',xdistrict,
 xaddress,'',0,'','',0,0,'','',max(xname),0,0,0,'','','','',1,1,'','','','','' from routep1 
where  xid='NA' and xoutletname  is not null --7546
group by  xzone,xoutletname,xproprietor,xmobile,demori,xdistrict,xthana,xaddress
