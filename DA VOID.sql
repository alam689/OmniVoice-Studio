
select xadvnum,xqtysms,xqtychl,xqtysms-xqtychl,xqtycut,xchkt,xstatusadvmach,xstatustrn
--,(select sum(xqtychl) from opchallandt where xadvnum=opadvice.xadvnum ) 
from opadvice where xadvnum in (
select tr from tr where tr not in ('PCMLDOA-0821-004444','PCMLDOA-0821-006178','PCMLDOA-0821-003481','PCMLDOA-0821-006991'))
and xstatusadvmach<>'4-Mached' 
--and xadvnum in  (select xadvnum from opmachadviced where xmachnum in (select xmachnum from opmachadv
--where xstatusmach in ('1-Open','2-Confirmed','3-Loading')))

update opadvice set xqtycut=xqtysms-xqtychl,xstatusadvmach='5-Voided',xstatustrn='Void By IT',xchkt=getdate() where xadvnum in (
select tr from tr where tr not in ('PCMLDOA-0821-004444','PCMLDOA-0821-006178','PCMLDOA-0821-003481','PCMLDOA-0821-006991'))
and xstatusadvmach<>'4-Mached' 


with cte as (
select xadvnum,xqtysms,xqtychl,xqtysms-xqtychl dd,xqtycut,
case when xqtysms=xqtycut then 1 else 0 end FullVoid,
case when xqtysms<>xqtycut and xqtycut between 1 and 50 then 1 else 0 end Bellow51Void,
case when xqtysms<>xqtycut and xqtycut between 51 and 100 then 1 else 0 end Bellow101Void,
case when xqtysms<>xqtycut and xqtycut between 101 and 150 then 1 else 0 end Bellow151Void,
case when xqtysms<>xqtycut and xqtycut> 150 then 1 else 0 end above150Void
from opadvice where xstatusadvmach='5-Voided'
)
select sum(FullVoid) FullVoid,sum(Bellow51Void) Bellow51Void,sum(Bellow101Void) Bellow101Void ,
sum(Bellow151Void) Bellow151Void,sum(above150Void) above150Void from cte 
