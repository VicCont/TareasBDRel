--Cómo obtenemos todos los nombres y correos de nuestros clientes canadienses para una campaña?
select c.first_name || ' ' || c.last_name ,c.email  from customer c join address a using (address_id)
join city c2 using (city_id) join country c3 using (country_id)
where c3.country='Canada';
--Qué cliente ha rentado más de nuestra sección de adultos?
select c.first_name || ' ' || c.last_name ,count(*) as cuenta from (select f.film_id  from film f where f.rating ='NC-17' or f.rating='R') 
as aux join inventory i using (film_id) 
join rental r using (inventory_id) join customer c using (customer_id)
group by customer_id 
order by 2 desc limit 1;
--Qué películas son las más rentadas en todas nuestras stores? R: las top 3 (o los empates en dado caso) por sucursal
select * from (select store_id ,title , rank() over ( partition by store_id order by cuenta desc) as lugar from(select store_id,film_id,title ,count(*) as cuenta from rental r join inventory i using (inventory_id) 
join store s using (store_id) join film f using (film_id)
group by store_id ,film_id ) as extra 
) as top
where lugar<=3;
--Cuál es nuestro revenue por store?
select store_id ,sum(amount) from rental r join inventory i using (inventory_id) 
join store s using (store_id) join payment p using (rental_id)
group  by store_id 
