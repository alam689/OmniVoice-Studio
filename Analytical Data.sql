select year(xdatemo),xdatemo,sum(xqtyprd) from moord 
where xstatusmor='5-Completed' and xwh='FINISHED GOODS' and year(xdatemo)=2020
group by xdatemo
having sum(xqtyprd)>=7000
order by 3 desc

select top 5 year(xdatemo),xdatemo,sum(xqtyprd) from moord 
where xstatusmor='5-Completed' and xwh='FINISHED GOODS' and year(xdatemo)<2020
group by xdatemo
--having sum(xqtyprd)>=7000
order by 3 desc

select  month(xdatemo),sum(case when  year(xdatemo)=2020 then xqtyprd else 0 end),
sum(case when  year(xdatemo)=2019 then xqtyprd else 0 end) from moord 
where xstatusmor='5-Completed' and xwh='FINISHED GOODS' and year(xdatemo) in (2020,2019)
group by  month(xdatemo)
order by 1

select xper,sum(case when xyear=2020 then xqtychl else 0 end),
sum(case when  xyear=2019 then xqtychl else 0 end) from MonthWiseSales where xyear in (2020,2019)
group by xper

--statustor}<>"S-Shortage"
with cte as (
select xyear,xdatecom,sum(xqtychl)/20 xqtychl from opchallandt 
where xstatuschl='3-Invoiced' and xwh='FINISHED GOODS' and xyear=2020 and xshipcode='Vessel'
group by xyear,xdatecom
union all 

select year(CONVERT(date,DATEADD(HOUR,-6,d.ztime))) xyear,  CONVERT(date,DATEADD(HOUR,-6,d.ztime)) xdatecom,
sum(d.xqtyord) xqtychl from Imtor h join imtdt d on h.zid=d.zid and h.ximtor=d.ximtor
where xstatustor='5-Completed' and xfwh='FINISHED GOODS' and year(CONVERT(date,DATEADD(HOUR,-6,d.ztime)))=2020
--and xvehicle not like 'PCMLMOV-%'  
group by CONVERT(date,DATEADD(HOUR,-6,d.ztime))
)
select xdatecom ,sum(xqtychl) from cte
group by xdatecom
having sum(xqtychl)>=4000


--select sum(xqtyord) from imtdt where DATEADD(D,-0,DATEDIFF(D,0,ztime))='2020-11-05 00:00:00.000'
--select sum(xqtychl)/20 from opchallandt where xdatecom='2020-11-05 00:00:00.000'
--and xwh='FINISHED GOODS' and xyear=2020 and xshipcode='Vessel'

with cte as (
select xyear,xdatecom,sum(xqtychl)/20 xqtychl from opchallandt 
where xstatuschl='3-Invoiced' and xwh='FINISHED GOODS' and xyear=2020 and xshipcode='Vessel'
group by xyear,xdatecom
union all
select year(DATEADD(D,-0,DATEDIFF(D,0,xconfirmt))) xyear, DATEADD(D,-0,DATEDIFF(D,0,xconfirmt)) xdatecom,sum(xqtyord) xqtychl from Imtor 
where xstatustor='5-Completed' and xfwh='FINISHED GOODS' and year(DATEADD(D,-0,DATEDIFF(D,0,xconfirmt)))<2020
and xvehicle not like 'PCMLMOV-%'  and xtrnimto<>'Adjust'
group by  DATEADD(D,-0,DATEDIFF(D,0,xconfirmt))
)
select top 5 year(xdatecom),xdatecom ,sum(xqtychl) from cte
group by xdatecom
order by 3 desc