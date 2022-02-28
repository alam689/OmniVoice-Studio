
select xintime,xid,skipreason,
case when skipreason like '%Order will be placed next 2 week%' then xintime+14
     when skipreason like '%Order will be placed next 3 week%' then xintime+21
	 when skipreason like '%Order will be placed next week%' then xintime+7 else 0 end,
	 DATEDIFF(day,getdate(),case when skipreason like '%Order will be placed next 2 week%' then xintime+14
     when skipreason like '%Order will be placed next 3 week%' then xintime+21
	 when skipreason like '%Order will be placed next week%' then xintime+7 else 0 end)
from outletcalllog where skipreason like '%week%'
and  DATEDIFF(day,getdate(),case when skipreason like '%Order will be placed next 2 week%' then xintime+14
     when skipreason like '%Order will be placed next 3 week%' then xintime+21
	 when skipreason like '%Order will be placed next week%' then xintime+7 else 0 end)>0

with cte as(
select xintime,xid,skipreason, 
case when skipreason like '%Order will be placed next 2 week%' then xintime+14
     when skipreason like '%Order will be placed next 3 week%' then xintime+21
	 when skipreason like '%Order will be placed next week%' then xintime+7 else 0 end ttt,
case when Substring (skipreason, PATINDEX('%Order will be placed next 2 week%', skipreason), Len('Order will be placed next 2 week')) ='Order will be placed next 2 week'
then Substring (skipreason, PATINDEX('%Order will be placed next 2 week%', skipreason), Len('Order will be placed next 2 week')) else '' end+''+
case when Substring (skipreason, PATINDEX('%Order will be placed next week%', skipreason), Len('Order will be placed next week')) ='Order will be placed next week'
then Substring (skipreason, PATINDEX('%Order will be placed next week%', skipreason), Len('Order will be placed next week')) else '' end+''+
case when Substring (skipreason, PATINDEX('%Order will be placed next 3 week%', skipreason), Len('Order will be placed next 3 week')) ='Order will be placed next 3 week'
then Substring (skipreason, PATINDEX('%Order will be placed next 3 week%', skipreason), Len('Order will be placed next 3 week')) else '' end skipr
from outletcalllog where skipreason like '%week%'
)
select * from cte where skipr='Order will be placed next 2 weekOrder will be placed next week'


