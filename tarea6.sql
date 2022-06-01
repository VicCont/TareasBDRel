with pagos_por_mes as (select  date_trunc('month', orderdate) ano_mes , custid, sum(unitprice*qty ) total  from orderdetail o join salesorder s using (orderid)
group by custid , date_trunc('month', orderdate))
, diferencias as (
select custid ,ceil(EXTRACT(epoch FROM ano_mes -lag(ano_mes,1) over (partition by custid order by ano_mes))/(60*60*24*30)) as tiempo
,total-lag(total,1) over (partition by custid order by ano_mes) as delta from pagos_por_mes p
),
cuentas as (
select custid, sum(delta) as suma_delta, sum(tiempo) as tot_tiemp from diferencias group by custid 
)
select custid,suma_delta /tot_tiemp  ,case when (suma_delta/tot_tiemp)<0 then 'malo'
 when (suma_delta/tot_tiemp) between 0 and 100 then 'regular' 
 when tot_tiemp is null then 'indefinido'
else 'bueno' end from cuentas  cue;
