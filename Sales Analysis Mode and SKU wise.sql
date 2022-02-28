select xdestin,xdelpoint,
SUM(case when xitem='02-01-001-0005' and xdelivery='Company' and xshipcode='Vessel' then (xqtychl)/20 else 0 end) BM_Vessel,
SUM(case when xitem='02-01-001-0005' and xdelivery='Company' and xshipcode='Vehicle' and xtypecat  like '%Bulk%' then (xqtychl)/20 else 0 end) BM_Bulk,
SUM(case when xitem='02-01-001-0005' and xdelivery='Company' and xshipcode='Vehicle' and xtypecat  not like '%Bulk%' then (xqtychl)/20 else 0 end) BM_Truck,
SUM(case when xitem='02-01-001-0005' and xdelivery='Customer' and xshipcode='Vessel' then (xqtychl)/20 else 0 end) BM_Vessel,
SUM(case when xitem='02-01-001-0005' and xdelivery='Customer' and xshipcode='Vehicle' and xtypecat  like '%Bulk%' then (xqtychl)/20 else 0 end) BM_Bulk,
SUM(case when xitem='02-01-001-0005' and xdelivery='Customer' and xshipcode='Vehicle' and xtypecat  not like '%Bulk%' then (xqtychl)/20 else 0 end) BM_Truck,

SUM(case when xitem='02-01-001-0003' and xdelivery='Company' and xshipcode='Vessel' then (xqtychl)/20 else 0 end) AM_Vessel,
SUM(case when xitem='02-01-001-0003' and xdelivery='Company' and xshipcode='Vehicle' and xtypecat  like '%Bulk%' then (xqtychl)/20 else 0 end) AM_Bulk,
SUM(case when xitem='02-01-001-0003' and xdelivery='Company' and xshipcode='Vehicle' and xtypecat  not like '%Bulk%' then (xqtychl)/20 else 0 end) AM_Truck,
SUM(case when xitem='02-01-001-0003' and xdelivery='Customer' and xshipcode='Vessel' then (xqtychl)/20 else 0 end) AM_Vessel,
SUM(case when xitem='02-01-001-0003' and xdelivery='Customer' and xshipcode='Vehicle' and xtypecat  like '%Bulk%' then (xqtychl)/20 else 0 end) AM_Bulk,
SUM(case when xitem='02-01-001-0003' and xdelivery='Customer' and xshipcode='Vehicle' and xtypecat  not like '%Bulk%' then (xqtychl)/20 else 0 end) AM_Truck,

SUM(case when xitem='02-01-001-0002' and xdelivery='Company' and xshipcode='Vessel' then (xqtychl)/20 else 0 end) OPC_Vessel,
SUM(case when xitem='02-01-001-0002' and xdelivery='Company' and xshipcode='Vehicle' and xtypecat  like '%Bulk%' then (xqtychl)/20 else 0 end) OPC_Bulk,
SUM(case when xitem='02-01-001-0002' and xdelivery='Company' and xshipcode='Vehicle' and xtypecat  not like '%Bulk%' then (xqtychl)/20 else 0 end) OPC_Truck,
SUM(case when xitem='02-01-001-0002' and xdelivery='Customer' and xshipcode='Vessel' then (xqtychl)/20 else 0 end) OPC_Vessel,
SUM(case when xitem='02-01-001-0002' and xdelivery='Customer' and xshipcode='Vehicle' and xtypecat  like '%Bulk%' then (xqtychl)/20 else 0 end) OPC_Bulk,
SUM(case when xitem='02-01-001-0002' and xdelivery='Customer' and xshipcode='Vehicle' and xtypecat  not like '%Bulk%' then (xqtychl)/20 else 0 end) OPC_Truck,

SUM(case when xitem='02-01-001-0008' and xdelivery='Company' and xshipcode='Vessel' then (xqtychl)/20 else 0 end) PPC_Vessel,
SUM(case when xitem='02-01-001-0008' and xdelivery='Company' and xshipcode='Vehicle' and xtypecat  like '%Bulk%' then (xqtychl)/20 else 0 end) PPC_Bulk,
SUM(case when xitem='02-01-001-0008' and xdelivery='Company' and xshipcode='Vehicle' and xtypecat  not like '%Bulk%' then (xqtychl)/20 else 0 end) PPC_Truck,
SUM(case when xitem='02-01-001-0008' and xdelivery='Customer' and xshipcode='Vessel' then (xqtychl)/20 else 0 end) PPC_Vessel,
SUM(case when xitem='02-01-001-0008' and xdelivery='Customer' and xshipcode='Vehicle' and xtypecat  like '%Bulk%' then (xqtychl)/20 else 0 end) PPC_Bulk,
SUM(case when xitem='02-01-001-0008' and xdelivery='Customer' and xshipcode='Vehicle' and xtypecat  not like '%Bulk%' then (xqtychl)/20 else 0 end) PPC_Truck,

SUM(case when xitem='02-01-001-0010' and xdelivery='Company' and xshipcode='Vessel' then (xqtychl)/20 else 0 end) PFC_Vessel,
SUM(case when xitem='02-01-001-0010' and xdelivery='Company' and xshipcode='Vehicle' and xtypecat  like '%Bulk%' then (xqtychl)/20 else 0 end) PFC_Bulk,
SUM(case when xitem='02-01-001-0010' and xdelivery='Company' and xshipcode='Vehicle' and xtypecat  not like '%Bulk%' then (xqtychl)/20 else 0 end) PFC_Truck,
SUM(case when xitem='02-01-001-0010' and xdelivery='Customer' and xshipcode='Vessel' then (xqtychl)/20 else 0 end) PFC_Vessel,
SUM(case when xitem='02-01-001-0010' and xdelivery='Customer' and xshipcode='Vehicle' and xtypecat  like '%Bulk%' then (xqtychl)/20 else 0 end) PFC_Bulk,
SUM(case when xitem='02-01-001-0010' and xdelivery='Customer' and xshipcode='Vehicle' and xtypecat  not like '%Bulk%' then (xqtychl)/20 else 0 end) PFC_Truck,
sum(xqtychl)/20 from opchallandt 
where xdatecom between '2021-01-01' and '2021-04-30' and xwh = 'FINISHED GOODS'	   and xdiv<>'Corporate'
group by xdestin,xdelpoint
order by xdestin
--select * from cadelpoint


select xzone,xcus,xorg,xdistrict,sum(xqtychl)/20,
sum(case when year(xdatecom)=2020 and month(xdatecom)=10 then xqtychl else 0 end)/20,
sum(case when year(xdatecom)=2020 and month(xdatecom)=11 then xqtychl else 0 end)/20,
sum(case when year(xdatecom)=2020 and month(xdatecom)=12 then xqtychl else 0 end)/20,
sum(case when year(xdatecom)=2021 and month(xdatecom)=01 then xqtychl else 0 end)/20,
sum(case when year(xdatecom)=2021 and month(xdatecom)=02 then xqtychl else 0 end)/20,
sum(case when year(xdatecom)=2021 and month(xdatecom)=03 then xqtychl else 0 end)/20,
sum(case when year(xdatecom)=2021 and month(xdatecom)=04 then xqtychl else 0 end)/20,
sum(case when year(xdatecom)=2021 and month(xdatecom)=05 then xqtychl else 0 end)/20,
sum(case when year(xdatecom)=2021 and month(xdatecom)=06 then xqtychl else 0 end)/20,
sum(case when year(xdatecom)=2021 and month(xdatecom)=07 then xqtychl else 0 end)/20,
sum(case when year(xdatecom)=2021 and month(xdatecom)=08 then xqtychl else 0 end)/20,
sum(case when year(xdatecom)=2021 and month(xdatecom)=09 then xqtychl else 0 end)/20
from opchallandt where xdatecom between '2020-10-01' and '2021-09-30' and 
xtypecat like '%BULK%' and xdiv='Corporate'
group by xzone,xcus,xorg,xdistrict



select  sum(xqtysms)/20,
sum(case when year(convert(date,xconfirmt))=2020 and month(convert(date,xconfirmt))=10 then xqtysms else 0 end)/20,
sum(case when year(convert(date,xconfirmt))=2020 and month(convert(date,xconfirmt))=11 then xqtysms else 0 end)/20,
sum(case when year(convert(date,xconfirmt))=2020 and month(convert(date,xconfirmt))=12 then xqtysms else 0 end)/20,
sum(case when year(convert(date,xconfirmt))=2021 and month(convert(date,xconfirmt))=01 then xqtysms else 0 end)/20,
sum(case when year(convert(date,xconfirmt))=2021 and month(convert(date,xconfirmt))=02 then xqtysms else 0 end)/20,
sum(case when year(convert(date,xconfirmt))=2021 and month(convert(date,xconfirmt))=03 then xqtysms else 0 end)/20,
sum(case when year(convert(date,xconfirmt))=2021 and month(convert(date,xconfirmt))=04 then xqtysms else 0 end)/20,
sum(case when year(convert(date,xconfirmt))=2021 and month(convert(date,xconfirmt))=05 then xqtysms else 0 end)/20,
sum(case when year(convert(date,xconfirmt))=2021 and month(convert(date,xconfirmt))=06 then xqtysms else 0 end)/20,
sum(case when year(convert(date,xconfirmt))=2021 and month(convert(date,xconfirmt))=07 then xqtysms else 0 end)/20,
sum(case when year(convert(date,xconfirmt))=2021 and month(convert(date,xconfirmt))=08 then xqtysms else 0 end)/20,
sum(case when year(convert(date,xconfirmt))=2021 and month(convert(date,xconfirmt))=09 then xqtysms else 0 end)/20
from opadvice join cacus on opadvice.xcus=cacus.xcus 
where convert(date,xconfirmt) between '2020-10-01' and '2021-09-30' and 
xsmstypecat like '%BULK%' and xsimcardno='Corporate' and xstatusadvmach='1-Open'

select xzone,sum(xqtychl)/20,
sum(case when xtypecat like '%BULK%'  then xqtychl else 0 end)/20
from opchallandt where xdatecom between '2021-06-01' and '2021-09-30' and  xdiv='Corporate'
group by xzone


select xdiv,xzone,xcus,xorg,( case when 
 Realistic_com='No'  and xprsubsistapp='No' and xprsuspapp='No'
 and xprarrearapp='No' and xpritaxapp='No' and xprbonusapp='No' and xprbasicapp='No' then 'CommissionLess'  else  'CommissionEligible' end
), sum(case when xdatecom between '2021-10-01' and '2021-10-31' then xqtychl else 0 end),
sum(case when xdatecom between '2021-11-01' and '2021-11-30' then xqtychl else 0 end)
from opchallandt where xdatecom between '2021-10-01' and '2021-11-30'
group by xdiv,xzone,xcus,xorg,( case when 
 Realistic_com='No' and  xprsubsistapp='No' and xprsuspapp='No'
 and xprarrearapp='No' and xpritaxapp='No' and xprbonusapp='No' and xprbasicapp='No' then 'CommissionLess'  else  'CommissionEligible' end
)


