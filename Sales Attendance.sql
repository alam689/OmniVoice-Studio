select xdate,FORMAT (xintime, 'HH:mm:ss'),FORMAT (xouttime, 'HH:mm:ss'),
xatdstat,xattype from pratd where xemp='002681' and xdate>='2021-08-26'
order by xdate


select 100000 zid,(select xzone from cacushrc where xriid=outletcalllog.xriid) xzone,xriid,
(select xname from prmst where xemp=outletcalllog.xriid) xname,xdate, year(xdate) xyear, MONTH(xdate) xper,
FORMAT ((xintime), 'HH:mm:ss') xintime1,FORMAT ((xouttime), 'HH:mm:ss') xouttime,
xintime,xouttime,(case when LEAD(xintime) OVER (PARTITION BY xriid,xdate ORDER BY xriid,xintime) is null then xouttime else  LEAD(xintime,1) OVER (PARTITION BY xriid,xdate ORDER BY xriid,xintime ) end) next_intime,
DATEDIFF(MINUTE,xintime,(case when LEAD(xintime) OVER (PARTITION BY xriid,xdate ORDER BY xriid,xintime) is null then xouttime else  LEAD(xintime,1) OVER (PARTITION BY xriid,xdate ORDER BY xriid,xintime ) end)) diff,
case when FORMAT ((xintime), 'HH:mm')>'09:30' then 'Late' else '' end xstatus, 
case when FORMAT ((xouttime), 'HH:mm')<'18:30' then 'Early Leave' else '' end xstatusmove, 0 No_of_Retail_Call,
CONVERT(varchar, DATEADD(second, DATEDIFF(ss, (xintime), (xouttime)), 0), 108) Working_Hour  from outletcalllog
where  xriid='002490' and (xdate) ='2021-09-01'
order by xriid,xdate,xintime

select xzone,xriid,xname,sum(case when xstatus='Late' then 1 else 0 end) Late,
sum(case when xstatusmove='Early Leave' then 1 else 0 end) EarlyLeave,
sum(case when xstatusmove='Early Leave' and xstatus='Late' then 1 else 0 end) LateEarlyLeave,
avg(coalesce(mintimdiff,0)) mintimdiff,avg((coalesce(maxtimdiff,0))) maxtimdiff,avg((coalesce(avgtimdiff,0))) avgtimdiff,
avg(No_of_Retail_Call) No_of_Retail_Call,(select sum(xqtychl) from DatewiseRiSales where xriid=SalesAttendanceRi.xriid and 
xdate between '2021-09-01' and  '2021-09-20'),
sum(xqtychl) xqtychl,sum(xqtychl)/20,avg(xqtychl),count(*) No_of_days from [SalesAttendanceRi] 
where xyear=2021 and xper=09 and xdate<'2021-09-21' and xriid='000763' 
group by xzone,xriid,xname

select (select xzone from cacushrc where xriid=DatewiseRiSales.xriid),xriid,sum(xqtychl) from [DatewiseRiSales] 
where xdate between  '2021-09-01' and  '2021-09-20' and 
(select xzone from cacushrc where xriid=DatewiseRiSales.xriid)='NARAYANGONJ'
group by xriid
select (select xzone from cacushrc where xriid=opchallandt.xteam),xteam,sum(xqtychl) from opchallandt
where xdatecom between  '2021-09-01' and  '2021-09-20' and 
(select xzone from cacushrc where xriid=opchallandt.xteam)='NARAYANGONJ'
group by xteam

--------------------------------RI Attendance--------------------------------
select xzone,xriid,a.xname,
max(case when day(a.xdate)=1 then xintime else '' end),max(case when day(a.xdate)=1 then xstatus else '' end),
max(case when day(a.xdate)=1 then xouttime else '' end),max(case when day(a.xdate)=1 then xstatusmove else '' end),
max(case when day(a.xdate)=1 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=1 then Working_Hour else '' end),
max(case when day(a.xdate)=1 then mintimdiff else 0 end),max(case when day(a.xdate)=1 then maxtimdiff else 0 end),
max(case when day(a.xdate)=1 then avgtimdiff else 0 end),--max(case when day(a.xdate)=1 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=1 and xriid=a.xriid),

max(case when day(a.xdate)=2 then xintime else '' end),max(case when day(a.xdate)=2 then xstatus else '' end),
max(case when day(a.xdate)=2 then xouttime else '' end),max(case when day(a.xdate)=2 then xstatusmove else '' end),
max(case when day(a.xdate)=2 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=2 then Working_Hour else '' end),
max(case when day(a.xdate)=2 then mintimdiff else 0 end),max(case when day(a.xdate)=2 then maxtimdiff else 0 end),
max(case when day(a.xdate)=2 then avgtimdiff else 0 end),--max(case when day(a.xdate)=2 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=2 and xriid=a.xriid),

max(case when day(a.xdate)=3 then xintime else '' end),max(case when day(a.xdate)=3 then xstatus else '' end),
max(case when day(a.xdate)=3 then xouttime else '' end),max(case when day(a.xdate)=3 then xstatusmove else '' end),
max(case when day(a.xdate)=3 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=3 then Working_Hour else '' end),
max(case when day(a.xdate)=3 then mintimdiff else 0 end),max(case when day(a.xdate)=3 then maxtimdiff else 0 end),
max(case when day(a.xdate)=3 then avgtimdiff else 0 end),--max(case when day(a.xdate)=3 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=3 and xriid=a.xriid),

max(case when day(a.xdate)=4 then xintime else '' end),max(case when day(a.xdate)=4 then xstatus else '' end),
max(case when day(a.xdate)=4 then xouttime else '' end),max(case when day(a.xdate)=4 then xstatusmove else '' end),
max(case when day(a.xdate)=4 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=4 then Working_Hour else '' end),
max(case when day(a.xdate)=4 then mintimdiff else 0 end),max(case when day(a.xdate)=4 then maxtimdiff else 0 end),
max(case when day(a.xdate)=4 then avgtimdiff else 0 end),--max(case when day(a.xdate)=4 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=4 and xriid=a.xriid),

max(case when day(a.xdate)=5 then xintime else '' end),max(case when day(a.xdate)=5 then xstatus else '' end),
max(case when day(a.xdate)=5 then xouttime else '' end),max(case when day(a.xdate)=5 then xstatusmove else '' end),
max(case when day(a.xdate)=5 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=5 then Working_Hour else '' end),
max(case when day(a.xdate)=5 then mintimdiff else 0 end),max(case when day(a.xdate)=5 then maxtimdiff else 0 end),
max(case when day(a.xdate)=5 then avgtimdiff else 0 end),--max(case when day(a.xdate)=5 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=5 and xriid=a.xriid),

max(case when day(a.xdate)=6 then xintime else '' end),max(case when day(a.xdate)=6 then xstatus else '' end),
max(case when day(a.xdate)=6 then xouttime else '' end),max(case when day(a.xdate)=6 then xstatusmove else '' end),
max(case when day(a.xdate)=6 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=6 then Working_Hour else '' end),
max(case when day(a.xdate)=6 then mintimdiff else 0 end),max(case when day(a.xdate)=6 then maxtimdiff else 0 end),
max(case when day(a.xdate)=6 then avgtimdiff else 0 end),--max(case when day(a.xdate)=6 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=6 and xriid=a.xriid),

max(case when day(a.xdate)=7 then xintime else '' end),max(case when day(a.xdate)=7 then xstatus else '' end),
max(case when day(a.xdate)=7 then xouttime else '' end),max(case when day(a.xdate)=7 then xstatusmove else '' end),
max(case when day(a.xdate)=7 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=7 then Working_Hour else '' end),
max(case when day(a.xdate)=7 then mintimdiff else 0 end),max(case when day(a.xdate)=7 then maxtimdiff else 0 end),
max(case when day(a.xdate)=7 then avgtimdiff else 0 end),--max(case when day(a.xdate)=7 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=7 and xriid=a.xriid),

max(case when day(a.xdate)=8 then xintime else '' end),max(case when day(a.xdate)=8 then xstatus else '' end),
max(case when day(a.xdate)=8 then xouttime else '' end),max(case when day(a.xdate)=8 then xstatusmove else '' end),
max(case when day(a.xdate)=8 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=8 then Working_Hour else '' end),
max(case when day(a.xdate)=8 then mintimdiff else 0 end),max(case when day(a.xdate)=8 then maxtimdiff else 0 end),
max(case when day(a.xdate)=8 then avgtimdiff else 0 end),--max(case when day(a.xdate)=8 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=8 and xriid=a.xriid),

max(case when day(a.xdate)=9 then xintime else '' end),max(case when day(a.xdate)=9 then xstatus else '' end),
max(case when day(a.xdate)=9 then xouttime else '' end),max(case when day(a.xdate)=9 then xstatusmove else '' end),
max(case when day(a.xdate)=9 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=9 then Working_Hour else '' end),
max(case when day(a.xdate)=9 then mintimdiff else 0 end),max(case when day(a.xdate)=9 then maxtimdiff else 0 end),
max(case when day(a.xdate)=9 then avgtimdiff else 0 end),--max(case when day(a.xdate)=9 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=9 and xriid=a.xriid),

max(case when day(a.xdate)=10 then xintime else '' end),max(case when day(a.xdate)=10 then xstatus else '' end),
max(case when day(a.xdate)=10 then xouttime else '' end),max(case when day(a.xdate)=10 then xstatusmove else '' end),
max(case when day(a.xdate)=10 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=10 then Working_Hour else '' end),
max(case when day(a.xdate)=10 then mintimdiff else 0 end),max(case when day(a.xdate)=10 then maxtimdiff else 0 end),
max(case when day(a.xdate)=10 then avgtimdiff else 0 end),--max(case when day(a.xdate)=10 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=10 and xriid=a.xriid),

max(case when day(a.xdate)=11 then xintime else '' end),max(case when day(a.xdate)=11 then xstatus else '' end),
max(case when day(a.xdate)=11 then xouttime else '' end),max(case when day(a.xdate)=11 then xstatusmove else '' end),
max(case when day(a.xdate)=11 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=11 then Working_Hour else '' end),
max(case when day(a.xdate)=11 then mintimdiff else 0 end),max(case when day(a.xdate)=11 then maxtimdiff else 0 end),
max(case when day(a.xdate)=11 then avgtimdiff else 0 end),--max(case when day(a.xdate)=11 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=11 and xriid=a.xriid),

max(case when day(a.xdate)=12 then xintime else '' end),max(case when day(a.xdate)=12 then xstatus else '' end),
max(case when day(a.xdate)=12 then xouttime else '' end),max(case when day(a.xdate)=12 then xstatusmove else '' end),
max(case when day(a.xdate)=12 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=12 then Working_Hour else '' end),
max(case when day(a.xdate)=12 then mintimdiff else 0 end),max(case when day(a.xdate)=12 then maxtimdiff else 0 end),
max(case when day(a.xdate)=12 then avgtimdiff else 0 end),--max(case when day(a.xdate)=12 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=12 and xriid=a.xriid),

max(case when day(a.xdate)=13 then xintime else '' end),max(case when day(a.xdate)=13 then xstatus else '' end),
max(case when day(a.xdate)=13 then xouttime else '' end),max(case when day(a.xdate)=13 then xstatusmove else '' end),
max(case when day(a.xdate)=13 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=13 then Working_Hour else '' end),
max(case when day(a.xdate)=13 then mintimdiff else 0 end),max(case when day(a.xdate)=13 then maxtimdiff else 0 end),
max(case when day(a.xdate)=13 then avgtimdiff else 0 end),--max(case when day(a.xdate)=13 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=13 and xriid=a.xriid),

max(case when day(a.xdate)=14 then xintime else '' end),max(case when day(a.xdate)=14 then xstatus else '' end),
max(case when day(a.xdate)=14 then xouttime else '' end),max(case when day(a.xdate)=14 then xstatusmove else '' end),
max(case when day(a.xdate)=14 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=14 then Working_Hour else '' end),
max(case when day(a.xdate)=14 then mintimdiff else 0 end),max(case when day(a.xdate)=14 then maxtimdiff else 0 end),
max(case when day(a.xdate)=14 then avgtimdiff else 0 end),--max(case when day(a.xdate)=14 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=14 and xriid=a.xriid),

max(case when day(a.xdate)=15 then xintime else '' end),max(case when day(a.xdate)=15 then xstatus else '' end),
max(case when day(a.xdate)=15 then xouttime else '' end),max(case when day(a.xdate)=15 then xstatusmove else '' end),
max(case when day(a.xdate)=15 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=15 then Working_Hour else '' end),
max(case when day(a.xdate)=15 then mintimdiff else 0 end),max(case when day(a.xdate)=15 then maxtimdiff else 0 end),
max(case when day(a.xdate)=15 then avgtimdiff else 0 end),--max(case when day(a.xdate)=15 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=15 and xriid=a.xriid),

max(case when day(a.xdate)=16 then xintime else '' end),max(case when day(a.xdate)=16 then xstatus else '' end),
max(case when day(a.xdate)=16 then xouttime else '' end),max(case when day(a.xdate)=16 then xstatusmove else '' end),
max(case when day(a.xdate)=16 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=16 then Working_Hour else '' end),
max(case when day(a.xdate)=16 then mintimdiff else 0 end),max(case when day(a.xdate)=16 then maxtimdiff else 0 end),
max(case when day(a.xdate)=16 then avgtimdiff else 0 end),--max(case when day(a.xdate)=16 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=16 and xriid=a.xriid),


max(case when day(a.xdate)=17 then xintime else '' end),max(case when day(a.xdate)=17 then xstatus else '' end),
max(case when day(a.xdate)=17 then xouttime else '' end),max(case when day(a.xdate)=17 then xstatusmove else '' end),
max(case when day(a.xdate)=17 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=17 then Working_Hour else '' end),
max(case when day(a.xdate)=17 then mintimdiff else 0 end),max(case when day(a.xdate)=17 then maxtimdiff else 0 end),
max(case when day(a.xdate)=17 then avgtimdiff else 0 end),--max(case when day(a.xdate)=17 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=17 and xriid=a.xriid),


max(case when day(a.xdate)=18 then xintime else '' end),max(case when day(a.xdate)=18 then xstatus else '' end),
max(case when day(a.xdate)=18 then xouttime else '' end),max(case when day(a.xdate)=18 then xstatusmove else '' end),
max(case when day(a.xdate)=18 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=18 then Working_Hour else '' end),
max(case when day(a.xdate)=18 then mintimdiff else 0 end),max(case when day(a.xdate)=18 then maxtimdiff else 0 end),
max(case when day(a.xdate)=18 then avgtimdiff else 0 end),--max(case when day(a.xdate)=18 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=18 and xriid=a.xriid),

max(case when day(a.xdate)=19 then xintime else '' end),max(case when day(a.xdate)=19 then xstatus else '' end),
max(case when day(a.xdate)=19 then xouttime else '' end),max(case when day(a.xdate)=19 then xstatusmove else '' end),
max(case when day(a.xdate)=19 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=19 then Working_Hour else '' end),
max(case when day(a.xdate)=19 then mintimdiff else 0 end),max(case when day(a.xdate)=19 then maxtimdiff else 0 end),
max(case when day(a.xdate)=19 then avgtimdiff else 0 end),--max(case when day(a.xdate)=19 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=19 and xriid=a.xriid),

max(case when day(a.xdate)=20 then xintime else '' end),max(case when day(a.xdate)=20 then xstatus else '' end),
max(case when day(a.xdate)=20 then xouttime else '' end),max(case when day(a.xdate)=20 then xstatusmove else '' end),
max(case when day(a.xdate)=20 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=20 then Working_Hour else '' end),
max(case when day(a.xdate)=20 then mintimdiff else 0 end),max(case when day(a.xdate)=20 then maxtimdiff else 0 end),
max(case when day(a.xdate)=20 then avgtimdiff else 0 end),--max(case when day(a.xdate)=20 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=20 and xriid=a.xriid),

max(case when day(a.xdate)=21 then xintime else '' end),max(case when day(a.xdate)=21 then xstatus else '' end),
max(case when day(a.xdate)=21 then xouttime else '' end),max(case when day(a.xdate)=21 then xstatusmove else '' end),
max(case when day(a.xdate)=21 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=21 then Working_Hour else '' end),
max(case when day(a.xdate)=21 then mintimdiff else 0 end),max(case when day(a.xdate)=21 then maxtimdiff else 0 end),
max(case when day(a.xdate)=21 then avgtimdiff else 0 end),--max(case when day(a.xdate)=21 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=21 and day(xdate)=2 and xriid=a.xriid),

max(case when day(a.xdate)=22 then xintime else '' end),max(case when day(a.xdate)=22 then xstatus else '' end),
max(case when day(a.xdate)=22 then xouttime else '' end),max(case when day(a.xdate)=22 then xstatusmove else '' end),
max(case when day(a.xdate)=22 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=22 then Working_Hour else '' end),
max(case when day(a.xdate)=22 then mintimdiff else 0 end),max(case when day(a.xdate)=22 then maxtimdiff else 0 end),
max(case when day(a.xdate)=22 then avgtimdiff else 0 end),--max(case when day(a.xdate)=22 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=22 and xriid=a.xriid),

max(case when day(a.xdate)=23 then xintime else '' end),max(case when day(a.xdate)=23 then xstatus else '' end),
max(case when day(a.xdate)=23 then xouttime else '' end),max(case when day(a.xdate)=23 then xstatusmove else '' end),
max(case when day(a.xdate)=23 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=23 then Working_Hour else '' end),
max(case when day(a.xdate)=23 then mintimdiff else 0 end),max(case when day(a.xdate)=23 then maxtimdiff else 0 end),
max(case when day(a.xdate)=23 then avgtimdiff else 0 end),--max(case when day(a.xdate)=23 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=23 and xriid=a.xriid),

max(case when day(a.xdate)=24 then xintime else '' end),max(case when day(a.xdate)=24 then xstatus else '' end),
max(case when day(a.xdate)=24 then xouttime else '' end),max(case when day(a.xdate)=24 then xstatusmove else '' end),
max(case when day(a.xdate)=24 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=24 then Working_Hour else '' end),
max(case when day(a.xdate)=24 then mintimdiff else 0 end),max(case when day(a.xdate)=24 then maxtimdiff else 0 end),
max(case when day(a.xdate)=24 then avgtimdiff else 0 end),--max(case when day(a.xdate)=24 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=24 and xriid=a.xriid),

max(case when day(a.xdate)=25 then xintime else '' end),max(case when day(a.xdate)=25 then xstatus else '' end),
max(case when day(a.xdate)=25 then xouttime else '' end),max(case when day(a.xdate)=25 then xstatusmove else '' end),
max(case when day(a.xdate)=25 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=25 then Working_Hour else '' end),
max(case when day(a.xdate)=25 then mintimdiff else 0 end),max(case when day(a.xdate)=25 then maxtimdiff else 0 end),
max(case when day(a.xdate)=25 then avgtimdiff else 0 end),--max(case when day(a.xdate)=25 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=25 and xriid=a.xriid),

max(case when day(a.xdate)=26 then xintime else '' end),max(case when day(a.xdate)=26 then xstatus else '' end),
max(case when day(a.xdate)=26 then xouttime else '' end),max(case when day(a.xdate)=26 then xstatusmove else '' end),
max(case when day(a.xdate)=26 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=26 then Working_Hour else '' end),
max(case when day(a.xdate)=26 then mintimdiff else 0 end),max(case when day(a.xdate)=26 then maxtimdiff else 0 end),
max(case when day(a.xdate)=26 then avgtimdiff else 0 end),--max(case when day(a.xdate)=26 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=26 and xriid=a.xriid),

max(case when day(a.xdate)=27 then xintime else '' end),max(case when day(a.xdate)=27 then xstatus else '' end),
max(case when day(a.xdate)=27 then xouttime else '' end),max(case when day(a.xdate)=27 then xstatusmove else '' end),
max(case when day(a.xdate)=27 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=27 then Working_Hour else '' end),
max(case when day(a.xdate)=27 then mintimdiff else 0 end),max(case when day(a.xdate)=27 then maxtimdiff else 0 end),
max(case when day(a.xdate)=27 then avgtimdiff else 0 end),--max(case when day(a.xdate)=27 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=27 and xriid=a.xriid),

max(case when day(a.xdate)=28 then xintime else '' end),max(case when day(a.xdate)=28 then xstatus else '' end),
max(case when day(a.xdate)=28 then xouttime else '' end),max(case when day(a.xdate)=28 then xstatusmove else '' end),
max(case when day(a.xdate)=28 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=28 then Working_Hour else '' end),
max(case when day(a.xdate)=28 then mintimdiff else 0 end),max(case when day(a.xdate)=28 then maxtimdiff else 0 end),
max(case when day(a.xdate)=28 then avgtimdiff else 0 end),--max(case when day(a.xdate)=28 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=28 and xriid=a.xriid),

max(case when day(a.xdate)=29 then xintime else '' end),max(case when day(a.xdate)=29 then xstatus else '' end),
max(case when day(a.xdate)=29 then xouttime else '' end),max(case when day(a.xdate)=29 then xstatusmove else '' end),
max(case when day(a.xdate)=29 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=29 then Working_Hour else '' end),
max(case when day(a.xdate)=29 then mintimdiff else 0 end),max(case when day(a.xdate)=29 then maxtimdiff else 0 end),
max(case when day(a.xdate)=29 then avgtimdiff else 0 end),--max(case when day(a.xdate)=29 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=29 and xriid=a.xriid),

max(case when day(a.xdate)=30 then xintime else '' end),max(case when day(a.xdate)=30 then xstatus else '' end),
max(case when day(a.xdate)=30 then xouttime else '' end),max(case when day(a.xdate)=30 then xstatusmove else '' end),
max(case when day(a.xdate)=30 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=30 then Working_Hour else '' end),
max(case when day(a.xdate)=30 then mintimdiff else 0 end),max(case when day(a.xdate)=30 then maxtimdiff else 0 end),
max(case when day(a.xdate)=30 then avgtimdiff else 0 end),--max(case when day(a.xdate)=30 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=30 and xriid=a.xriid),

max(case when day(a.xdate)=31 then xintime else '' end),max(case when day(a.xdate)=31 then xstatus else '' end),
max(case when day(a.xdate)=31 then xouttime else '' end),max(case when day(a.xdate)=31 then xstatusmove else '' end),
max(case when day(a.xdate)=31 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=31 then Working_Hour else '' end),
max(case when day(a.xdate)=31 then mintimdiff else 0 end),max(case when day(a.xdate)=31 then maxtimdiff else 0 end),
max(case when day(a.xdate)=31 then avgtimdiff else 0 end),--max(case when day(a.xdate)=31 then xqtychl else 0 end),
(select  xqtychl from DatewiseRiSales where   year(xdate)=2021 and month(xdate)=09 and day(xdate)=31 and xriid=a.xriid)

from SalesAttendanceri a join cadate d on a.zid=d.zid and a.xyear=d.xyear and a.xper=d.xper 
where   a.xyear=2021 and a.xper=09 --and a.xriid='000828'
group by  xzone,xriid,a.xname


--select xriid,xdate,count(*) from DatewiseRiSales where year(xdate)=2021 and month(xdate)=09 group by xriid,xdate having count(*)>1



--------------------------------AI Attendance--------------------------------
select xzone,xtsoid,a.xainame,
max(case when day(a.xdate)=1 then xintime else '' end),max(case when day(a.xdate)=1 then xstatus else '' end),
max(case when day(a.xdate)=1 then xouttime else '' end),max(case when day(a.xdate)=1 then xstatusmove else '' end),
max(case when day(a.xdate)=1 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=1 then Working_Hour else '' end),
max(case when day(a.xdate)=2 then xintime else '' end),max(case when day(a.xdate)=2 then xstatus else '' end),
max(case when day(a.xdate)=2 then xouttime else '' end),max(case when day(a.xdate)=2 then xstatusmove else '' end),
max(case when day(a.xdate)=2 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=2 then Working_Hour else '' end),
max(case when day(a.xdate)=3 then xintime else '' end),max(case when day(a.xdate)=3 then xstatus else '' end),
max(case when day(a.xdate)=3 then xouttime else '' end),max(case when day(a.xdate)=3 then xstatusmove else '' end),
max(case when day(a.xdate)=3 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=3 then Working_Hour else '' end),
max(case when day(a.xdate)=4 then xintime else '' end),max(case when day(a.xdate)=4 then xstatus else '' end),
max(case when day(a.xdate)=4 then xouttime else '' end),max(case when day(a.xdate)=4 then xstatusmove else '' end),
max(case when day(a.xdate)=4 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=4 then Working_Hour else '' end),
max(case when day(a.xdate)=5 then xintime else '' end),max(case when day(a.xdate)=5 then xstatus else '' end),
max(case when day(a.xdate)=5 then xouttime else '' end),max(case when day(a.xdate)=5 then xstatusmove else '' end),
max(case when day(a.xdate)=5 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=5 then Working_Hour else '' end),
max(case when day(a.xdate)=6 then xintime else '' end),max(case when day(a.xdate)=6 then xstatus else '' end),
max(case when day(a.xdate)=6 then xouttime else '' end),max(case when day(a.xdate)=6 then xstatusmove else '' end),
max(case when day(a.xdate)=6 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=6 then Working_Hour else '' end),
max(case when day(a.xdate)=7 then xintime else '' end),max(case when day(a.xdate)=7 then xstatus else '' end),
max(case when day(a.xdate)=7 then xouttime else '' end),max(case when day(a.xdate)=7 then xstatusmove else '' end),
max(case when day(a.xdate)=7 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=7 then Working_Hour else '' end),
max(case when day(a.xdate)=8 then xintime else '' end),max(case when day(a.xdate)=8 then xstatus else '' end),
max(case when day(a.xdate)=8 then xouttime else '' end),max(case when day(a.xdate)=8 then xstatusmove else '' end),
max(case when day(a.xdate)=8 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=8 then Working_Hour else '' end),
max(case when day(a.xdate)=9 then xintime else '' end),max(case when day(a.xdate)=9 then xstatus else '' end),
max(case when day(a.xdate)=9 then xouttime else '' end),max(case when day(a.xdate)=9 then xstatusmove else '' end),
max(case when day(a.xdate)=9 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=9 then Working_Hour else '' end),
max(case when day(a.xdate)=10 then xintime else '' end),max(case when day(a.xdate)=10 then xstatus else '' end),
max(case when day(a.xdate)=10 then xouttime else '' end),max(case when day(a.xdate)=10 then xstatusmove else '' end),
max(case when day(a.xdate)=10 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=10 then Working_Hour else '' end),
max(case when day(a.xdate)=11 then xintime else '' end),max(case when day(a.xdate)=11 then xstatus else '' end),
max(case when day(a.xdate)=11 then xouttime else '' end),max(case when day(a.xdate)=11 then xstatusmove else '' end),
max(case when day(a.xdate)=11 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=11 then Working_Hour else '' end),
max(case when day(a.xdate)=12 then xintime else '' end),max(case when day(a.xdate)=12 then xstatus else '' end),
max(case when day(a.xdate)=12 then xouttime else '' end),max(case when day(a.xdate)=12 then xstatusmove else '' end),
max(case when day(a.xdate)=12 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=12 then Working_Hour else '' end),
max(case when day(a.xdate)=13 then xintime else '' end),max(case when day(a.xdate)=13 then xstatus else '' end),
max(case when day(a.xdate)=13 then xouttime else '' end),max(case when day(a.xdate)=13 then xstatusmove else '' end),
max(case when day(a.xdate)=13 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=13 then Working_Hour else '' end),
max(case when day(a.xdate)=14 then xintime else '' end),max(case when day(a.xdate)=14 then xstatus else '' end),
max(case when day(a.xdate)=14 then xouttime else '' end),max(case when day(a.xdate)=14 then xstatusmove else '' end),
max(case when day(a.xdate)=14 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=14 then Working_Hour else '' end),
max(case when day(a.xdate)=15 then xintime else '' end),max(case when day(a.xdate)=15 then xstatus else '' end),
max(case when day(a.xdate)=15 then xouttime else '' end),max(case when day(a.xdate)=15 then xstatusmove else '' end),
max(case when day(a.xdate)=15 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=15 then Working_Hour else '' end),
max(case when day(a.xdate)=16 then xintime else '' end),max(case when day(a.xdate)=16 then xstatus else '' end),
max(case when day(a.xdate)=16 then xouttime else '' end),max(case when day(a.xdate)=16 then xstatusmove else '' end),
max(case when day(a.xdate)=16 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=16 then Working_Hour else '' end),
max(case when day(a.xdate)=17 then xintime else '' end),max(case when day(a.xdate)=17 then xstatus else '' end),
max(case when day(a.xdate)=17 then xouttime else '' end),max(case when day(a.xdate)=17 then xstatusmove else '' end),
max(case when day(a.xdate)=17 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=17 then Working_Hour else '' end),
max(case when day(a.xdate)=18 then xintime else '' end),max(case when day(a.xdate)=18 then xstatus else '' end),
max(case when day(a.xdate)=18 then xouttime else '' end),max(case when day(a.xdate)=18 then xstatusmove else '' end),
max(case when day(a.xdate)=18 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=18 then Working_Hour else '' end),
max(case when day(a.xdate)=19 then xintime else '' end),max(case when day(a.xdate)=19 then xstatus else '' end),
max(case when day(a.xdate)=19 then xouttime else '' end),max(case when day(a.xdate)=19 then xstatusmove else '' end),
max(case when day(a.xdate)=19 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=19 then Working_Hour else '' end),
max(case when day(a.xdate)=20 then xintime else '' end),max(case when day(a.xdate)=20 then xstatus else '' end),
max(case when day(a.xdate)=20 then xouttime else '' end),max(case when day(a.xdate)=20 then xstatusmove else '' end),
max(case when day(a.xdate)=20 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=20 then Working_Hour else '' end),
max(case when day(a.xdate)=21 then xintime else '' end),max(case when day(a.xdate)=21 then xstatus else '' end),
max(case when day(a.xdate)=21 then xouttime else '' end),max(case when day(a.xdate)=21 then xstatusmove else '' end),
max(case when day(a.xdate)=21 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=21 then Working_Hour else '' end),
max(case when day(a.xdate)=22 then xintime else '' end),max(case when day(a.xdate)=22 then xstatus else '' end),
max(case when day(a.xdate)=22 then xouttime else '' end),max(case when day(a.xdate)=22 then xstatusmove else '' end),
max(case when day(a.xdate)=22 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=22 then Working_Hour else '' end),
max(case when day(a.xdate)=23 then xintime else '' end),max(case when day(a.xdate)=23 then xstatus else '' end),
max(case when day(a.xdate)=23 then xouttime else '' end),max(case when day(a.xdate)=23 then xstatusmove else '' end),
max(case when day(a.xdate)=23 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=23 then Working_Hour else '' end),
max(case when day(a.xdate)=24 then xintime else '' end),max(case when day(a.xdate)=24 then xstatus else '' end),
max(case when day(a.xdate)=24 then xouttime else '' end),max(case when day(a.xdate)=24 then xstatusmove else '' end),
max(case when day(a.xdate)=24 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=24 then Working_Hour else '' end),
max(case when day(a.xdate)=25 then xintime else '' end),max(case when day(a.xdate)=25 then xstatus else '' end),
max(case when day(a.xdate)=25 then xouttime else '' end),max(case when day(a.xdate)=25 then xstatusmove else '' end),
max(case when day(a.xdate)=25 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=25 then Working_Hour else '' end),
max(case when day(a.xdate)=26 then xintime else '' end),max(case when day(a.xdate)=26 then xstatus else '' end),
max(case when day(a.xdate)=26 then xouttime else '' end),max(case when day(a.xdate)=26 then xstatusmove else '' end),
max(case when day(a.xdate)=26 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=26 then Working_Hour else '' end),
max(case when day(a.xdate)=27 then xintime else '' end),max(case when day(a.xdate)=27 then xstatus else '' end),
max(case when day(a.xdate)=27 then xouttime else '' end),max(case when day(a.xdate)=27 then xstatusmove else '' end),
max(case when day(a.xdate)=27 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=27 then Working_Hour else '' end),
max(case when day(a.xdate)=28 then xintime else '' end),max(case when day(a.xdate)=28 then xstatus else '' end),
max(case when day(a.xdate)=28 then xouttime else '' end),max(case when day(a.xdate)=28 then xstatusmove else '' end),
max(case when day(a.xdate)=28 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=28 then Working_Hour else '' end),
max(case when day(a.xdate)=29 then xintime else '' end),max(case when day(a.xdate)=29 then xstatus else '' end),
max(case when day(a.xdate)=29 then xouttime else '' end),max(case when day(a.xdate)=29 then xstatusmove else '' end),
max(case when day(a.xdate)=29 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=29 then Working_Hour else '' end),
max(case when day(a.xdate)=30 then xintime else '' end),max(case when day(a.xdate)=30 then xstatus else '' end),
max(case when day(a.xdate)=30 then xouttime else '' end),max(case when day(a.xdate)=30 then xstatusmove else '' end),
max(case when day(a.xdate)=30 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=30 then Working_Hour else '' end),
max(case when day(a.xdate)=31 then xintime else '' end),max(case when day(a.xdate)=31 then xstatus else '' end),
max(case when day(a.xdate)=31 then xouttime else '' end),max(case when day(a.xdate)=31 then xstatusmove else '' end),
max(case when day(a.xdate)=31 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=31 then Working_Hour else '' end)
from SalesAttendanceai a join cadate d on a.zid=d.zid and a.xyear=d.xyear and a.xper=d.xper where   a.xyear=2021 and a.xper=09 --and a.xtsoid='002491'
group by  xzone,xtsoid,a.xainame

--------------------------------ZI Attendance--------------------------------

select xzone,xziid,a.xziname,
max(case when day(a.xdate)=1 then xintime else '' end),max(case when day(a.xdate)=1 then xstatus else '' end),
max(case when day(a.xdate)=1 then xouttime else '' end),max(case when day(a.xdate)=1 then xstatusmove else '' end),
max(case when day(a.xdate)=1 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=1 then Working_Hour else '' end),
max(case when day(a.xdate)=2 then xintime else '' end),max(case when day(a.xdate)=2 then xstatus else '' end),
max(case when day(a.xdate)=2 then xouttime else '' end),max(case when day(a.xdate)=2 then xstatusmove else '' end),
max(case when day(a.xdate)=2 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=2 then Working_Hour else '' end),
max(case when day(a.xdate)=3 then xintime else '' end),max(case when day(a.xdate)=3 then xstatus else '' end),
max(case when day(a.xdate)=3 then xouttime else '' end),max(case when day(a.xdate)=3 then xstatusmove else '' end),
max(case when day(a.xdate)=3 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=3 then Working_Hour else '' end),
max(case when day(a.xdate)=4 then xintime else '' end),max(case when day(a.xdate)=4 then xstatus else '' end),
max(case when day(a.xdate)=4 then xouttime else '' end),max(case when day(a.xdate)=4 then xstatusmove else '' end),
max(case when day(a.xdate)=4 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=4 then Working_Hour else '' end),
max(case when day(a.xdate)=5 then xintime else '' end),max(case when day(a.xdate)=5 then xstatus else '' end),
max(case when day(a.xdate)=5 then xouttime else '' end),max(case when day(a.xdate)=5 then xstatusmove else '' end),
max(case when day(a.xdate)=5 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=5 then Working_Hour else '' end),
max(case when day(a.xdate)=6 then xintime else '' end),max(case when day(a.xdate)=6 then xstatus else '' end),
max(case when day(a.xdate)=6 then xouttime else '' end),max(case when day(a.xdate)=6 then xstatusmove else '' end),
max(case when day(a.xdate)=6 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=6 then Working_Hour else '' end),
max(case when day(a.xdate)=7 then xintime else '' end),max(case when day(a.xdate)=7 then xstatus else '' end),
max(case when day(a.xdate)=7 then xouttime else '' end),max(case when day(a.xdate)=7 then xstatusmove else '' end),
max(case when day(a.xdate)=7 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=7 then Working_Hour else '' end),
max(case when day(a.xdate)=8 then xintime else '' end),max(case when day(a.xdate)=8 then xstatus else '' end),
max(case when day(a.xdate)=8 then xouttime else '' end),max(case when day(a.xdate)=8 then xstatusmove else '' end),
max(case when day(a.xdate)=8 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=8 then Working_Hour else '' end),
max(case when day(a.xdate)=9 then xintime else '' end),max(case when day(a.xdate)=9 then xstatus else '' end),
max(case when day(a.xdate)=9 then xouttime else '' end),max(case when day(a.xdate)=9 then xstatusmove else '' end),
max(case when day(a.xdate)=9 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=9 then Working_Hour else '' end),
max(case when day(a.xdate)=10 then xintime else '' end),max(case when day(a.xdate)=10 then xstatus else '' end),
max(case when day(a.xdate)=10 then xouttime else '' end),max(case when day(a.xdate)=10 then xstatusmove else '' end),
max(case when day(a.xdate)=10 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=10 then Working_Hour else '' end),
max(case when day(a.xdate)=11 then xintime else '' end),max(case when day(a.xdate)=11 then xstatus else '' end),
max(case when day(a.xdate)=11 then xouttime else '' end),max(case when day(a.xdate)=11 then xstatusmove else '' end),
max(case when day(a.xdate)=11 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=11 then Working_Hour else '' end),
max(case when day(a.xdate)=12 then xintime else '' end),max(case when day(a.xdate)=12 then xstatus else '' end),
max(case when day(a.xdate)=12 then xouttime else '' end),max(case when day(a.xdate)=12 then xstatusmove else '' end),
max(case when day(a.xdate)=12 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=12 then Working_Hour else '' end),
max(case when day(a.xdate)=13 then xintime else '' end),max(case when day(a.xdate)=13 then xstatus else '' end),
max(case when day(a.xdate)=13 then xouttime else '' end),max(case when day(a.xdate)=13 then xstatusmove else '' end),
max(case when day(a.xdate)=13 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=13 then Working_Hour else '' end),
max(case when day(a.xdate)=14 then xintime else '' end),max(case when day(a.xdate)=14 then xstatus else '' end),
max(case when day(a.xdate)=14 then xouttime else '' end),max(case when day(a.xdate)=14 then xstatusmove else '' end),
max(case when day(a.xdate)=14 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=14 then Working_Hour else '' end),
max(case when day(a.xdate)=15 then xintime else '' end),max(case when day(a.xdate)=15 then xstatus else '' end),
max(case when day(a.xdate)=15 then xouttime else '' end),max(case when day(a.xdate)=15 then xstatusmove else '' end),
max(case when day(a.xdate)=15 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=15 then Working_Hour else '' end),
max(case when day(a.xdate)=16 then xintime else '' end),max(case when day(a.xdate)=16 then xstatus else '' end),
max(case when day(a.xdate)=16 then xouttime else '' end),max(case when day(a.xdate)=16 then xstatusmove else '' end),
max(case when day(a.xdate)=16 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=16 then Working_Hour else '' end),
max(case when day(a.xdate)=17 then xintime else '' end),max(case when day(a.xdate)=17 then xstatus else '' end),
max(case when day(a.xdate)=17 then xouttime else '' end),max(case when day(a.xdate)=17 then xstatusmove else '' end),
max(case when day(a.xdate)=17 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=17 then Working_Hour else '' end),
max(case when day(a.xdate)=18 then xintime else '' end),max(case when day(a.xdate)=18 then xstatus else '' end),
max(case when day(a.xdate)=18 then xouttime else '' end),max(case when day(a.xdate)=18 then xstatusmove else '' end),
max(case when day(a.xdate)=18 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=18 then Working_Hour else '' end),
max(case when day(a.xdate)=19 then xintime else '' end),max(case when day(a.xdate)=19 then xstatus else '' end),
max(case when day(a.xdate)=19 then xouttime else '' end),max(case when day(a.xdate)=19 then xstatusmove else '' end),
max(case when day(a.xdate)=19 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=19 then Working_Hour else '' end),
max(case when day(a.xdate)=20 then xintime else '' end),max(case when day(a.xdate)=20 then xstatus else '' end),
max(case when day(a.xdate)=20 then xouttime else '' end),max(case when day(a.xdate)=20 then xstatusmove else '' end),
max(case when day(a.xdate)=20 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=20 then Working_Hour else '' end),
max(case when day(a.xdate)=21 then xintime else '' end),max(case when day(a.xdate)=21 then xstatus else '' end),
max(case when day(a.xdate)=21 then xouttime else '' end),max(case when day(a.xdate)=21 then xstatusmove else '' end),
max(case when day(a.xdate)=21 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=21 then Working_Hour else '' end),
max(case when day(a.xdate)=22 then xintime else '' end),max(case when day(a.xdate)=22 then xstatus else '' end),
max(case when day(a.xdate)=22 then xouttime else '' end),max(case when day(a.xdate)=22 then xstatusmove else '' end),
max(case when day(a.xdate)=22 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=22 then Working_Hour else '' end),
max(case when day(a.xdate)=23 then xintime else '' end),max(case when day(a.xdate)=23 then xstatus else '' end),
max(case when day(a.xdate)=23 then xouttime else '' end),max(case when day(a.xdate)=23 then xstatusmove else '' end),
max(case when day(a.xdate)=23 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=23 then Working_Hour else '' end),
max(case when day(a.xdate)=24 then xintime else '' end),max(case when day(a.xdate)=24 then xstatus else '' end),
max(case when day(a.xdate)=24 then xouttime else '' end),max(case when day(a.xdate)=24 then xstatusmove else '' end),
max(case when day(a.xdate)=24 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=24 then Working_Hour else '' end),
max(case when day(a.xdate)=25 then xintime else '' end),max(case when day(a.xdate)=25 then xstatus else '' end),
max(case when day(a.xdate)=25 then xouttime else '' end),max(case when day(a.xdate)=25 then xstatusmove else '' end),
max(case when day(a.xdate)=25 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=25 then Working_Hour else '' end),
max(case when day(a.xdate)=26 then xintime else '' end),max(case when day(a.xdate)=26 then xstatus else '' end),
max(case when day(a.xdate)=26 then xouttime else '' end),max(case when day(a.xdate)=26 then xstatusmove else '' end),
max(case when day(a.xdate)=26 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=26 then Working_Hour else '' end),
max(case when day(a.xdate)=27 then xintime else '' end),max(case when day(a.xdate)=27 then xstatus else '' end),
max(case when day(a.xdate)=27 then xouttime else '' end),max(case when day(a.xdate)=27 then xstatusmove else '' end),
max(case when day(a.xdate)=27 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=27 then Working_Hour else '' end),
max(case when day(a.xdate)=28 then xintime else '' end),max(case when day(a.xdate)=28 then xstatus else '' end),
max(case when day(a.xdate)=28 then xouttime else '' end),max(case when day(a.xdate)=28 then xstatusmove else '' end),
max(case when day(a.xdate)=28 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=28 then Working_Hour else '' end),
max(case when day(a.xdate)=29 then xintime else '' end),max(case when day(a.xdate)=29 then xstatus else '' end),
max(case when day(a.xdate)=29 then xouttime else '' end),max(case when day(a.xdate)=29 then xstatusmove else '' end),
max(case when day(a.xdate)=29 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=29 then Working_Hour else '' end),
max(case when day(a.xdate)=30 then xintime else '' end),max(case when day(a.xdate)=30 then xstatus else '' end),
max(case when day(a.xdate)=30 then xouttime else '' end),max(case when day(a.xdate)=30 then xstatusmove else '' end),
max(case when day(a.xdate)=30 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=30 then Working_Hour else '' end),
max(case when day(a.xdate)=31 then xintime else '' end),max(case when day(a.xdate)=31 then xstatus else '' end),
max(case when day(a.xdate)=31 then xouttime else '' end),max(case when day(a.xdate)=31 then xstatusmove else '' end),
max(case when day(a.xdate)=31 then No_of_Retail_Call else 0 end),max(case when day(a.xdate)=31 then Working_Hour else '' end)
from SalesAttendancezi a join cadate d on a.zid=d.zid and a.xyear=d.xyear and a.xper=d.xper where   a.xyear=2021 and a.xper=09 --and a.xtsoid='002491'
group by  xzone,xziid,a.xziname



select h.xlocation,h.xemp,h.xname,h.xdesig,h.xsec,h.xdept,a.xdate, a.xintime,a.xouttime,
FORMAT ((xintime), 'HH:mm:ss') xintime1,FORMAT ((xouttime), 'HH:mm:ss') xouttime,
case when FORMAT ((xintime), 'HH:mm')>'09:35' then 'Late' else 'Present' end CheckIn, 
case when FORMAT ((xouttime), 'HH:mm')<'18:30' then 'Early Leave' else '' end  CheckOut,
CONVERT(varchar, DATEADD(second, DATEDIFF(ss, (xintime), (xouttime)), 0), 108) Working_Hour,
case when h.xsec='Route In-charge' then (select count(*) from OutletCallLog where xriid=h.xemp and xdate=a.xdate)
else (select count(*) from OutletCalllogaizi where created_by=h.xemp and xdate=a.xdate) end
from Salesattendancemgt a join prmst h on a.xemp=h.xemp   where xdate>='2022-03-01' and h.xemp='000046'
order by h.xemp

select xid,xdate,xriid,(select max(created_by)  from aiziroutep where xdate=OutletCalllog.xdate and xriid=OutletCalllog.xriid ) xziai,zi_call_status from 
OutletCalllog where xdate='2022-03-14' and xriid='001466' order by xriid

--(select created_by  from aiziroutep where xdate=OutletCalllog.xdate and xriid=OutletCalllog.xriid ) xziai,
create view OutletCalllogaizi as 
select 100000 zid,c.xid,c.xdate,c.xriid,c.zi_call_status,created_by from 
OutletCalllog c join aiziroutep r on r.xriid=c.xriid and r.xdate=c.xdate 

select xdate,xriid,count(*) from aiziroutep
group by xdate,xriid 
having count(*)>1
order by xdate desc

select * from  OutletCalllog where xdate='2022-03-12' order by xriid
select * from  aiziroutep where xdate='2022-03-12' order by xriid
