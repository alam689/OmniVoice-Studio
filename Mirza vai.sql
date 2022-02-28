select distinct xwh  from opchallandt where xzone in ('Comilla','Noakhali') and xyear=2021 and xper in (10,11,12)

select xcus,xorg,xdestin,xdelpoint, 
sum(case when xwh='Bagra Ghat' and xdelivery='Company' then xqtychl else 0 end)/20 Bagra_Company,
sum(case when xwh='Bagra Ghat' and xdelivery<>'Company' then xqtychl else 0 end)/20 Bagra_Customer,
sum(case when xwh='Daudkandi Ghat' and xdelivery='Company' then xqtychl else 0 end)/20 Daudkandi_Company,
sum(case when xwh='Daudkandi Ghat' and xdelivery<>'Company' then xqtychl else 0 end)/20 Daudkandi_Customer,
sum(case when xwh like 'Keroshin Ghat' and xdelivery='Company' then xqtychl else 0 end)/20 Keroshin_Company,
sum(case when xwh like 'Keroshin Ghat' and xdelivery<>'Company' then xqtychl else 0 end)/20 Keroshin_Customer,
sum(case when xwh like '%FINISHED%' and xdelivery='Company' then xqtychl else 0 end)/20 Factory_Company,
sum(case when xwh like '%FINISHED%' and xdelivery<>'Company' then xqtychl else 0 end)/20 Factory_Customer
 from opchallandt where  xzone in ('Comilla','Noakhali') and xyear=2021 and xper in (10,11,12)
group by xcus,xorg,xdestin,xdelpoint
order by xcus,xorg,xdestin,xdelpoint


select xcus,xorg,xdestin,xdelpoint, 
sum(case when xwh='Ashugonj Ghat' and xdelivery='Company' then xqtychl else 0 end)/20 Ashugonj_Company,
sum(case when xwh='Ashugonj Ghat' and xdelivery<>'Company' then xqtychl else 0 end)/20 Ashugonj_Customer,
sum(case when xwh='Shunamgonj Ghat' and xdelivery='Company' then xqtychl else 0 end)/20 Shunamgonj_Company,
sum(case when xwh='Shunamgonj Ghat' and xdelivery<>'Company' then xqtychl else 0 end)/20 Shunamgonj_Customer,
sum(case when xwh like '%FINISHED%' and xdelivery='Company' then xqtychl else 0 end)/20 Factory_Company,
sum(case when xwh like '%FINISHED%' and xdelivery<>'Company' then xqtychl else 0 end)/20 Factory_Customer
 from opchallandt where xzone='Sylhet' and xyear=2021 and xper in (7,8,9)
group by xcus,xorg,xdestin,xdelpoint
order by xcus,xorg,xdestin,xdelpoint