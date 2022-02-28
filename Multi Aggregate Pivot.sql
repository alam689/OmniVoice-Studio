with OPCBAG as 
(
	select xsimcardno ,
	format((CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))),'yyyyMM') yrpr,
	case when d.xitem='02-01-001-0002' and d.xtypecat not like '%Bulk%' then d.xqtychl else 0 end OPC_BAG
	from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join cacus c on h.zid=c.zid and h.xcus=c.xcus
	where CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) >='2017-01-01' 
),BMBAG as 
(
	select xsimcardno ,
	format((CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt))),'yyyyMM') yrpr,
	case when d.xitem='02-01-001-0005' and d.xtypecat not like '%Bulk%' then d.xqtychl else 0 end BM_BAG
	from opchallan h join opchalland d on h.zid=d.zid and h.xchlnum=d.xchlnum join cacus c on h.zid=c.zid and h.xcus=c.xcus
	where CONVERT(date,DATEADD(HOUR,-6,h.xconfirmt)) >='2017-01-01'
),OPCBAG_agg as
(
	select p1.xsimcardno,
		p1.[2021701],p1.[2021702],p1.[2021703],p1.[2021704],p1.[2021705],p1.[2021706],p1.[2021707],p1.[2021708],p1.[2021709],p1.[20217010],p1.[20217011],p1.[20217012]
	from OPCBAG 
	pivot(sum(OPC_BAG)
		 for yrpr in ([2021701],[2021702],[2021703],[2021704],[2021705],[2021706],[2021707],[2021708],[2021709],[20217010],[20217011],[20217012])
		 ) p1
),BMBAG_agg as
(
	select p2.xsimcardno,
		p2.[2021701],p2.[2021702],p2.[2021703],p2.[2021704],p2.[2021705],p2.[2021706],p2.[2021707],p2.[2021708],p2.[2021709],p2.[20217010],p2.[20217011],p2.[20217012]
	from BMBAG 
	pivot(sum(BM_BAG)
		 for yrpr in ([2021701],[2021702],[2021703],[2021704],[2021705],[2021706],[2021707],[2021708],[2021709],[20217010],[20217011],[20217012])
		 ) p2

)
select pa1.xsimcardno,pa1.[2021701],pa1.[2021702],pa1.[2021703],pa1.[2021704],pa1.[2021705],pa1.[2021706],pa1.[2021707],pa1.[2021708],pa1.[2021709],pa1.[20217010],pa1.[20217011],pa1.[20217012],
	    pa2.[2021701],pa2.[2021702],pa2.[2021703],pa2.[2021704],pa2.[2021705],pa2.[2021706],pa2.[2021707],pa2.[2021708],pa2.[2021709],pa2.[20217010],pa2.[20217011],pa2.[20217012]
from OPCBAG_agg pa1 inner join BMBAG_agg pa2 on pa1.xsimcardno=pa2.xsimcardno



---------------- Dynamic Pivot------------------------------
DECLARE @sprdElements AS NVARCHAR(MAX) --comma separated, delimited, distinct list of product attributes
        ,@tSql AS NVARCHAR(MAX)        --query text
        ,@ObjectName VARCHAR(255);     --specific product name

SET @ObjectName = NULL -- 'BMC Road Bike' --specific product

--comma separated list of attributes for a product
;WITH dsitSpreadElList AS
(
    SELECT DISTINCT Attribute
    FROM Products
    WHERE ObjectName = @ObjectName
        OR @ObjectName IS NULL
)
SELECT @sprdElements = COALESCE(@sprdElements+', ','')+'['+ CAST( Attribute AS NVARCHAR(255))+']'
--SELECT @sprdElements = STRING_AGG('['+Attribute+']',',') --Available in SQL2017+
FROM dsitSpreadElList;

--print @sprdElements

SET @tSql =N';WITH TabExp AS
             (
                SELECT ObjectName -- grouping element
                      ,Attribute  -- spreading element
                      ,[Value]    -- aggregating element
                FROM dbo.Products
                WHERE ObjectName = @ObjName
                  OR @ObjName IS NULL
	     )
             SELECT ObjectName,'+@sprdElements +N'
             FROM TabExp
             PIVOT (
                    MAX([Value])
                    FOR Attribute IN (' + @sprdElements +N') 
                    ) AS pvt';

 EXEC sys.sp_executesql
     @stmt = @tSql
    ,@params = N'@ObjName VARCHAR(255)'
    ,@ObjName = @ObjectName;


------------ Dynaminic Pivot 2 -------------------------
DECLARE 
    @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';

-- select the category names
SELECT 
    @columns+=QUOTENAME(category_name) + ','
FROM 
    production.categories
ORDER BY 
    category_name;

-- remove the last comma
SET @columns = LEFT(@columns, LEN(@columns) - 1);

-- construct dynamic SQL
SET @sql ='
SELECT * FROM   
(
    SELECT 
        category_name, 
        model_year,
        product_id 
    FROM 
        production.products p
        INNER JOIN production.categories c 
            ON c.category_id = p.category_id
) t 
PIVOT(
    COUNT(product_id) 
    FOR category_name IN ('+ @columns +')
) AS pivot_table;';

-- execute the dynamic SQL
EXECUTE sp_executesql @sql;






















