insert into pcmlapp.ERPonTheNet.dbo.cacus(ztime, zutime, zid, xcus , xorg, xadd1, xadd2, xcity, xstate, xzip, xcountry, xsalute, xfirst, xmiddle, xlast, xtitle, xemail, xphone, xfax, xurl, xid, xtaxnum, xaccar, xgcus, xgprice, xsic, xtaxscope, xstatuscus, xcrlimit, xcrterms, 
                         xdisc, xagent, xcomm, xoffadd, xzone, xblock, xcell, xdistrict, zemail, xpassport, xfphone, xfadd, xdesig, xregion, xtr, xsp, xtrncus, xamount, xdate, xsimcardno, xbloodgrp, xdob, xspouse, xlicense, xsales, xremark, xphone1, 
                         xmobile, xemail1, xarea, xowner, xdtbirth, xdtmarr, xdateiss, xsex, xdateact, xqtygrn, xqtydel, xdesc01, xmstatus, xrecid1, xcomments, xpolicy, xmethodpay,  xbalance, xprbasicapp, xprpfapp, xprbonusapp, 
                         xpritaxapp, xprarrearapp, xprhrentapp, xprsuspapp, xprsubsistapp, xperc, xpartial, xqtydor, xnetpay, xprobe

)
SELECT        ztime, zutime, 100000, 'N'+xcus , xorg, xadd1, xadd2, xcity, xstate, xzip, xcountry, xsalute, xfirst, xmiddle, xlast, xtitle, xemail, xphone, xfax, xurl, xid, xtaxnum, xaccar, xgcus, xgprice, xsic, xtaxscope, xstatuscus, xcrlimit, xcrterms, 
                         xdisc, xagent, xcomm, xoffadd, xzone, xblock, xcell, xdistrict, zemail, xpassport, xfphone, xfadd, xdesig, xregion, xtr, xsp, xtrncus, xamount, xdate, xsimcardno, xbloodgrp, xdob, xspouse, xlicense, xsales, xremark, xphone1, 
                         xmobile, xemail1, xarea, xowner, xdtbirth, xdtmarr, xdateiss, xsex, xdateact, xqtygrn, xqtydel, xdesc01, xmstatus, xrecid1, xcomments, xpolicy, xmethodpay,  xbalance, xprbasicapp, xprpfapp, xprbonusapp, 
                         xpritaxapp, xprarrearapp, xprhrentapp, xprsuspapp, xprsubsistapp, xperc, xpartial, xqtydor, xnetpay, xprobe
FROM            cacus where 'N'+xcus not in (select xcus from pcmlapp.ERPonTheNet.dbo.cacus)


----------------------Sales Insert -------------------------------------

insert into ncmlsales( zid, xsimcardno, xbloodgrp, xcus, xorg, xchlnum, xline, xconfirmt, xstatuschl, xid, xdelpoint, xdestin, xdelsite, xteam, xdate, xitem, xtypecat, xdelivery, xshipcode, xadvnum, xsornum, xvehicle, xwh, xdornum, xordernum, 
                         xqtychl, xdtwotax, xchgdel, xlineamt)
select  100000,c.xsimcardno,c.xbloodgrp,'N'+c.xcus,c.xorg,h.xchlnum,d.xline,h.xconfirmt,h.xstatuschl,h.xordernum xid,h.xdelpoint, 
h.xdestin, h.xdelsite,h.xteam,DATEADD(D,0,DATEDIFF(D,0,DATEADD(HOUR,-6,xconfirmt))) xdate,d.xitem,
d.xtypecat,h.xdelivery,h.xshipcode,h.xadvnum,h.xsornum,h.xvehicle,h.xwh,d.xdornum,d.xordernum,
d.xqtychl,d.xdtwotax,d.xchgdel,d.xlineamt from NCMLERP.ERPonTheNet.dbo.opchallan h join NCMLERP.ERPonTheNet.dbo.opchalland d 
 on h.zid=d.zid and h.xchlnum=d.xchlnum join NCMLERP.ERPonTheNet.dbo.cacus c on c.zid=h.zid and c.xcus=h.xcus 
where   CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) >= DATEADD(D,-2,DATEDIFF(D,0,GETDATE()))
and xstatuschl='3-Invoiced' and h.xchlnum not in (select xchlnum from ncmlsales
where  CONVERT(date,DATEADD(HOUR,-6,xconfirmt)) >= DATEADD(D,-2,DATEDIFF(D,0,GETDATE())))