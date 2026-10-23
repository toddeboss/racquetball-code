-- Partner W/L report supporting table for IRT, LPRT doubles (put in to wrt for eeventual use)

create table partner_wl_rpt
(partner varchar(50),wins integer, losses integer);

insert into partner_wl_rpt values ('bob',2,null);
insert into partner_wl_rpt values ('bob',1,null);

insert into partner_wl_rpt values ('bob',null,1);

select * from partner_wl_rpt;

select partner,sum(wins),sum(losses) from partner_wl_rpt group by partner;