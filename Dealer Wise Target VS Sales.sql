select xcus,xorg,xzone,(select xqty  from dealerTarget where xcus=opchallandt.xcus ) ,
sum(xqtychl),(select sum(xqtyord-xqtychl)  from opundeldo where xcus=opchallandt.xcus )
from opchallandt where xdiv in ('Dhaka','Out Dhaka')
and xdatecom>='2021-08-01'
group by xcus,xorg,xzone
union all
select dealerTarget.xcus,xorg,xbloodgrp,dealerTarget.xqty,0,
(select sum(xqtyord-xqtychl)  from opundeldo where xcus=dealerTarget.xcus ) from dealerTarget join cacus on dealerTarget.xcus=cacus.xcus 
where  dealerTarget.xcus not in (select xcus from opchallandt where xdatecom>='2021-08-01' )

        