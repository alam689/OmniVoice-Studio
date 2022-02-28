select xcus,xdistrict,xthana,xitem,xnetrate,(select xnetrate from cacuscorrt where xcus=cacusrate.xcus and xdistrict=cacusrate.xdistrict 
and xdestin=cacusrate.xthana and xitem=cacusrate.xitem) ,xzone,
(select sum(xqtychl) from opchallandt where xcus=cacusrate.xcus and xdistrict=cacusrate.xdistrict and xdatefrom>='2020-01-01')
from cacusrate where  xcus in (select xcus from cacus where xsimcardno='Corporate')
and xcus not like 'NCUS%'
and (select xnetrate from cacuscorrt where xcus=cacusrate.xcus and xdistrict=cacusrate.xdistrict 
and xdestin=cacusrate.xthana and xitem=cacusrate.xitem)  is null 

select xcus,xdistrict,xthana,xitem,xnetrate,(select xnetrate from cacuscemrate where xcus=cacusrate.xcus and xitem=cacusrate.xitem) ,xzone,
(select sum(xqtychl) from opchallandt where xcus=cacusrate.xcus and xdistrict=cacusrate.xdistrict and xdatefrom>='2020-01-01')
from cacusrate where  xcus in (select xcus from cacus where xsimcardno<>'Corporate')
and xcus not like 'NCUS%'
and (select xnetrate from cacuscemrate where xcus=cacusrate.xcus and xitem=cacusrate.xitem) is null 
