select top 10 * from monthWiseSales order by xqtychl desc
select * from monthWiseSales where xyear=2022 and xper=3
select avg(xqtychl) from DayWiseSales where xyear=2022 and xper=2 and xday<28
select * from DayWiseSales where xyear=2022 and xper=3 order by xday desc


