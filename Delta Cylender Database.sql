insert into cylinderdb SELECT CURRENT_TIMESTAMP(6),101,'D'||CAST(2021 AS text)||LPAD( CAST(8 AS text),2,'0')||'-'||LPAD(CAST(generate_series(1, 200) as text),5,'0'),CURRENT_DATE ,CURRENT_DATE +5000,25,'t' select * from cylinderdb

---------------------January 2022---------------------------Cylinder Database
insert into cylinderdb 
SELECT CURRENT_TIMESTAMP(6),101,'D'||CAST(2022 AS text)||LPAD( CAST(01 AS text),2,'0')||'-'||LPAD(CAST(generate_series(1, 30000) as text),5,'0'),CURRENT_DATE ,CURRENT_DATE +5000,25,'t'