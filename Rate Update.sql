select xsimcardno,xbloodgrp,count(*) from cacus where xsimcardno in ('Corporate','Out Dhaka','Dhaka') and xcus like 'NCUS%'
group by xsimcardno,xbloodgrp
order  by xsimcardno,xbloodgrp

select xcus,xitem,xnetrate,xnetrate+10,xrem,zutime,getdate()  from cacusrate where xcus not like '%NCUS%'
 and xcus in (select xcus from cacus where xsimcardno in ('Out Dhaka','Dhaka') and  xbloodgrp not in ('CHITTAGONG METRO','CHITTAGONG SOUTH','CHITTAGONG NORTH','CHITTAGONG-01')) 
 order by xcus

 --pdate cacusrate set xnetrate=xnetrate+10,xrem=xnetrate,zutime=getdate()  where xcus not like '%NCUS%'
 --and xcus in (select xcus from cacus where xsimcardno in ('Out Dhaka','Dhaka') and  xbloodgrp not in ('CHITTAGONG METRO','CHITTAGONG SOUTH','CHITTAGONG NORTH','CHITTAGONG-01')) 

 select xcus,xitem,xnetrate,xnetrate+10,xrem,zutime,getdate()   from cacusrate where  xcus in (select xcus from cacus where xsimcardno ='Corporate' ) 
 order by xcus

 --pdate cacusrate set xnetrate=xnetrate+5,xrem=xnetrate,zutime=getdate() where  xcus in (select xcus from cacus where xsimcardno ='Corporate' ) 
 --nsert into cacuscemrate
 select getdate(), zutime, zid, xcus, 'PCMLCRT-2203-00000'+
 cast(ROW_NUMBER() OVER(PARTITION BY xcus ORDER BY xcus) AS varchar(10)), xwh, xitem, xrate, xnetrate+10, xbonus, xcomm, xnetrate, '', '', zemail, xemail, zactive, xdesc
 from cacuscemrate  where xcus not like '%NCUS%'
 and xcus in (select xcus from cacus where xsimcardno in ('Out Dhaka','Dhaka') and  xbloodgrp not in ('CHITTAGONG METRO','CHITTAGONG SOUTH','CHITTAGONG NORTH','CHITTAGONG-01')) 

--nsert into cacuscorrt
SELECT         getdate(),  getdate(), zid, 2+ROW_NUMBER() OVER(PARTITION BY xcus ORDER BY xcus), xcus, xitem, xdestin, xrate, xcomm, xnetrate, '2022-03-06', 
zactive, zemail, xemail, xwh, xcghdel, xnetrate+5, xdistrict, xlandcost, xdesc FROM            cacuscorrt


select xcus,xitem,xnetrate,xnetrate+20,xrem,zutime,getdate()  from cacuscemrate where xcus not like '%NCUS%'
 and xcus in (select xcus from cacus where  xbloodgrp  in ('NOAKHALI','SYLHET','COMILLA','DHAKA MIDDLE','DHAKA NORTH','DHAKA SOUTH',
 'GAZIPUR','MYMENSINGH','NARAYANGONJ')) 
 order by zutime desc

--pdate cacuscemrate set xnetrate=xnetrate+20,xrem=xnetrate,zutime=getdate()  where xcus not like '%NCUS%'
 and xcus in (select xcus from cacus where  xbloodgrp  in ('NOAKHALI','SYLHET','COMILLA','DHAKA MIDDLE','DHAKA NORTH','DHAKA SOUTH',
 'GAZIPUR','MYMENSINGH','NARAYANGONJ')) 

 select xcus,xitem,xnetrate,xnetrate+25,xrem,zutime,getdate()  from cacuscemrate where xcus not like '%NCUS%'
 and xcus in (select xcus from cacus where  xbloodgrp  in ('FARIDPUR','KUSHTIA','BARISAL','JESSORE', 'KHULNA',
 'NILPHAMARI','RAJSHAHI','RANGPUR','BOGRA')) 
 order by xcus

 --pdate cacuscemrate set xnetrate=xnetrate+25,xrem=xnetrate,zutime=getdate() where xcus not like '%NCUS%'
 and xcus in (select xcus from cacus where  xbloodgrp  in ('FARIDPUR','KUSHTIA','BARISAL','JESSORE', 'KHULNA',
 'NILPHAMARI','RAJSHAHI','RANGPUR','BOGRA')) 
 


 --nsert into cacuscemrate
 select zutime, '', zid, xcus, 'PCMLCRT-2203-00000'+
 cast(11+ROW_NUMBER() OVER(PARTITION BY xcus ORDER BY xcus) AS varchar(10)), xwh, xitem, xrate, xnetrate, xbonus, xcomm, xrem, '2022-03-10', '', zemail, xemail, zactive, xdesc
 from cacusrate  where xcus not like '%NCUS%'
 and xcus in (select xcus from cacus 
 where xbloodgrp  in ('NOAKHALI','SYLHET','COMILLA','DHAKA MIDDLE','DHAKA NORTH','DHAKA SOUTH',
 'GAZIPUR','MYMENSINGH','NARAYANGONJ','FARIDPUR','KUSHTIA','BARISAL','JESSORE', 'KHULNA',
 'NILPHAMARI','RAJSHAHI','RANGPUR','BOGRA')) 


