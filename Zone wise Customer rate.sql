select xbloodgrp "Zone",xcus "Dealer ID",xorg "Dealer Name",xaccar "Dealer Account" ,xcrlimit "Credit Limit",xqtygrn "Approved Credit Limit",
xamount "Bank Guarantee Amount",xsales "Security Cheque Amount" ,'' "Balance for DO", 
xoffadd "Office Add",xfphone "Contact No",xsp "Sales Person",'' "General Commission/Volume Commission" ,
'' "Realistic Target Commission/Special Target Commission",'' "Retail Commission",
'' "Lifting/Delivery commissions",'' "Cash Discount offer/ Spot Discount offer",
'' "Free Bags Cost",  '' "Free Bags Commission)",'' "Yearly Commission",
 '' "Free Bag%",'' "Cash Party?", '' "Promotional Offer"
from cacus where xcus in (select xcus from opchallan where xconfirmt>='2019-01-01')

select xcus,xitem,xnetrate,xrem from cacuscemrate where xcus in (select xcus from cacus where  xbloodgrp in ('CHITTAGONG','CHITTAGONG-01','CHITTAGONG-02') )
select xcus,xitem,xnetrate,xrem from cacusrate where xcus in (select xcus from cacus where  xbloodgrp in ('CHITTAGONG','CHITTAGONG-01','CHITTAGONG-02') )
select xcus,xitem,xnetrate,xrem from cacuscemrate where xcus in (select xcus from cacus where  xbloodgrp in ('NARAYANGONJ','DHAKA MIDDLE','DHAKA NORTH','NOAKHALI','COMILLA','SYLHET','JESSORE','KHULNA','BARISAL'))
select xcus,xitem,xnetrate,xrem from cacusrate where xcus in (select xcus from cacus where  xbloodgrp in ('NARAYANGONJ','DHAKA MIDDLE','DHAKA NORTH','NOAKHALI','COMILLA','SYLHET','JESSORE','KHULNA','BARISAL'))
select xcus,xitem,xnetrate,xrem from cacuscemrate where xcus in (select xcus from cacus where  xbloodgrp in ('KUSHTIA','GAZIPUR','FARIDPUR','MYMENSINGH') )
select xcus,xitem,xnetrate,xrem from cacusrate where xcus in (select xcus from cacus where   xbloodgrp in ('KUSHTIA','GAZIPUR','FARIDPUR','MYMENSINGH') )
select xcus,xitem,xnetrate,xrem from cacuscemrate where xcus in (select xcus from cacus where  xbloodgrp in ('BOGRA','RAJSHAHI','RANGPUR','NILPHAMARI') )
select xcus,xitem,xnetrate,xrem from cacusrate where xcus in (select xcus from cacus where  xbloodgrp in ('BOGRA','RAJSHAHI','RANGPUR','NILPHAMARI') )