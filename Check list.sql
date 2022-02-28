select * from opchallan where xstatuschl='3-Invoiced' and xchlnum not in (select xref from glheader where xtrngl='INOP')
select * from glheader where xtrngl='INOP' and xref not in (select xchlnum from opchallan)
select xref,count(*) from glheader where xtrngl='INOP' group by xref having count(*)>1