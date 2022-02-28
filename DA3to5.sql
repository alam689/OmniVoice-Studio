cahome.page should be replace by new one (DreamApps 5)

Select * from zbusiness where zid<100010
Select * from ERPonNCML.dbo.zbusiness 
Select * from pxsites where zid<100010
Select * from ERPonNCML.dbo.pxsites 
Select * from pxsiteskins where zid<100010
Select * from ERPonNCML.dbo.pxsiteskins 
Select * from pxskins where zid<100010
Select * from ERPonNCML.dbo.pxskins 

insert into zxroles
select * from ERPonNCML.dbo.zxroles

insert into pxsiteskins
select * from ERPonNCML.dbo.pxsiteskins


SELECT name, [modify_date] FROM sys.tables where name='zbusiness'
SELECT OBJECT_NAME(OBJECT_ID) AS TableName, last_user_update,* FROM sys.dm_db_index_usage_stats WHERE OBJECT_ID=OBJECT_ID('zbusiness')


alter table zbusiness add xselfcustom varchar(100) NULL,xtheme varchar(100) NULL
alter table pxsites add xpageslogin varchar(500) NULL,xactivation varchar(1) NULL,xsupemail varchar(1) NULL,xsupsms varchar(1) NULL,xsupdir varchar(1) NULL
alter table pxskins add xcustom varchar(500) NULL,xmenupage varchar(1) NULL
alter table cadef add  [xnoautocus] [varchar](100) NULL,	[xnoautosup] [varchar](100) NULL,	[xbatchformat] [varchar](250) NULL,	[xsuppressdesc] [varchar](100) NULL
alter table cadocs add  [xcontext] [varchar](250) NULL
alter table xcur add [xshort] [varchar](100) NULL
alter table zhistory add [zactive] [varchar](1) NULL
alter table zlogin add  [xipadr] [varchar](100) NULL,	[xsite] [varchar](100) NULL,	[zid] [int] NULL,	[xsessionid] [varchar](100) NULL
alter table [zxjob] add  [xkey] [varchar](100) NULL
alter table zxlimits add  [xpage] [varchar](100) NULL,[xfield] [varchar](100) NULL
alter table zxusers add  [xques] [varchar](100) NULL,[xans] [varchar](100) NULL,[xcustom] [varchar](500) NULL,[xaccessloc] [varchar](100) NULL,[xselfcustom] [varchar](100) NULL
alter table zusers add  [zchanged] [varchar](1) NULL


select xfeatured,xsupemail,xsitemobile,xseq,xsupsms,zid from pxsites		
select xfeatured,xsupemail,xsitemobile,xseq,xsupsms,zid from ERPonNCML.dbo.pxsites 	
select xnote,xcriteria,zid from pxsiteskins		
select xnote,xcriteria,zid from ERPonNCML.dbo.pxsiteskins 	

update pxsites set xfeatured=' ' where zid=9
update pxsites set xsupemail='0' where zid >9
update pxsites set xsitemobile='ERP',xseq='01',xsupsms=0 where zid >9
update pxsites set xfeatured=1 where  zid >9
update pxsiteskins set xnote=' ',xcriteria=' ' where zid >9
update pxskins set xtemplatelogin=' ',xcartembedded=' ' where zid >9
update pxskins set xlogin='caerp', xmenupage='1' where xskin='ERP'
update zbusiness set zactive=1 where zid=1

