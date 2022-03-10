select top 10 * from DayWiseSales order by xqtychl desc
select * from monthWiseSales where xyear=2022 and xper=3
select avg(xqtychl)*31 from DayWiseSales where xyear=2022 and xper=3 and xday<8
select * from DayWiseSales where xyear=2022 and xper=3 order by xday desc


