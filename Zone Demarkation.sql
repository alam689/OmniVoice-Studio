
select xcus,xorg,xriid,(select xname from prmst where xemp=cacusrii.xriid),
case when (select xzone from cacushrc  where xriid=cacusrii.xriid)<>xzone then 'Confict' else '' end
from cacusrii where  xzone='DHAKA MIDDLE'

select xcus,xorg,xid,xoutletname,xproprietor,xmobile, xriid,(select xname from prmst where xemp=caoutlet.xriid),
case when (select xzone from cacushrc  where xriid=caoutlet.xriid)<>xzone then 'Confict' else '' end,
(select max('RoutePlan') from routep  where xid=caoutlet.xid) 
from caoutlet where  xzone='DHAKA MIDDLE'
and xcus<>'NA'

select * from cazone where xzone='DHAKA SOUTH'

select * from cacus where xbloodgrp='DHAKA SOUTH'

select * from caoutlet where xzone='DHAKA SOUTH'
select * from routep where xzone='DHAKA SOUTH'
select * from aiziroutep  where xziid='004155'
select * from cacushrc where xzone='DHAKA SOUTH'
select * from cacusrii where xzone='DHAKA SOUTH'
select * from opritarget where xzone='DHAKA SOUTH'
select * from opritargetdt where xzone='DHAKA SOUTH'

select * from opadvice where xzonedel='DHAKA SOUTH'

select * from cadelpoint where xzone='DHAKA SOUTH'

select * from cacusrate where xzone='DHAKA SOUTH'
select * from cacustrrate where xzone='DHAKA SOUTH'