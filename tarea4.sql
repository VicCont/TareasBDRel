select customer_id , avg(dife) from (select customer_id ,payment_date-lag (payment_date,1) over (partition by customer_id order by payment_id) as dife from payment p) as aux
join customer c using (customer_id)
group by c.customer_id  ;

with benford_freqs as (
select grupo,count(*) freq from (select customer_id , floor( EXTRACT(epoch FROM avg(dife))/(3600*24)) grupo from (select customer_id ,payment_date-lag (payment_date,1) over (partition by customer_id order by payment_id) as dife from payment p) as aux
join customer c using (customer_id)
group by c.customer_id ) as sub1 group  by grupo 
),
benford_totals as (
	select sum(freq) as tot from benford_freqs 
)
select bf.grupo , bf.freq , round((bf.freq /bt.tot) * 100, 2) as frequencia,
round((exp(grupo )-(bf.freq /bt.tot))) as distancia
from benford_freqs bf, benford_totals bt;

select avg(sb1."avg"-sb2."avg") from (select customer_id , avg(dife) from (select customer_id ,payment_date-lag (payment_date,1) over (partition by customer_id order by payment_id) as dife from payment p) as aux
join customer c using (customer_id)
group by c.customer_id) sb1
join (
select customer_id , avg(dife) from (select customer_id ,r.rental_date -lag (rental_date ,1) over (partition by customer_id order by r.rental_id) as dife from rental r) as aux
join customer c using (customer_id)
group by c.customer_id) sb2 on sb2.customer_id =sb1.customer_id ;