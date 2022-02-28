
insert into opritarget
SELECT        getdate(), zutime, zid, replace(xordernum,'2103','2104'), 2021, 4, xstatusord,
zemail, xemail, '2021-04-01', 30, xdayscom, xzone, xqtychl, xemp
FROM            opritarget
WHERE        (xyear = 2021) AND (xper = 3)

select xordernum,xzone, xsimcardno,(select xdiv from cazone where xzone=opritargetdt.xzone),
xemp, xempnew, xziid, xempf from
update opritargetdt set xsimcardno=(select xdiv from cazone where xzone=opritargetdt.xzone) where xyear=2021 and xper=01 
and xziid not in (select xemp from prmst)


select xzone,xqtychl,(select sum(xqty) from  opritargetdt
WHERE xyear = 2021 AND xper = 01 and xordernum=opritarget.xordernum) from 
update opritarget set xqtychl=(select sum(xqty) from  opritargetdt
WHERE xyear = 2021 AND xper = 01 and xordernum=opritarget.xordernum) where xyear=2021 and xper=01

SELECT        xordernum, xzone, xsimcardno,'9' + substring(xemp, 2, len(xemp)-1),
                             (SELECT        xdiv
                               FROM            cazone
                               WHERE        (xzone = opritargetdt.xzone)) AS Expr1, xemp, xempnew, xziid, xempf
FROM          update  opritargetdt set xemp='9' + substring(xemp, 2, len(xemp)-1)
WHERE        (xyear = 2021) AND (xper = 05) AND (xemp NOT IN
                             (SELECT        xemp
                               FROM            prmst
                               WHERE        (xdept = 'Marketing & sales') OR
                                                         (xdept = 'Corporate Sales'))) and xsimcardno is not null