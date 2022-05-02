select s.company_name ,s.contact_name ,s.phone  from  suppliers s where s.contact_title='Sales Representative';

select s.company_name ,s.contact_name ,s.phone  from  suppliers s where s.contact_title!='Marketing Manager';

select o.order_id  from orders o where o.ship_country!='USA';

select distinct  p.product_id,p.product_name from orders o join order_details od using (order_id) join products p on p.product_id=od.product_id join categories c using (category_id) 
where c.category_id!=4 and o.shipped_date notnull;

select o.order_id, o.ship_country  from orders o where o.ship_country in ('France','Belgium');


select o.order_id, o.ship_country  from orders o where o.ship_country in ('México','Brazil','Argentina','Venezuela','');

select o.order_id, o.ship_country  from orders o where o.ship_country not in ('México','Brazil','Argentina','Venezuela','');

select concat(e.first_name,' ',e.last_name)  from employees e ;

select sum(p.unit_price*p.units_in_stock) from products p where p.units_in_stock >0;

select count(*) ,c.country  from customers c group by c.country ;

select age(e.birth_date) ,concat(e.first_name,' ',e.last_name) ,e.birth_date  from employees e;

select max(o.order_date), c.customer_id  from orders o join customers c  using (customer_id) group by c.customer_id ;

select contact_title ,count(*) from customers c group by contact_title ;

select count(*), p.category_id  from products p join categories c using (category_id) where  p.discontinued=0 group  by p.category_id  ;

#select * from (select count(*) as cuenta, o.customer_id  from orders o group  by o.customer_id ) s where s.cuenta >1;

select max(aux.vol) from (select  sum(od.quantity) as vol from  orders o join order_details od using (order_id) group  by o.order_id ) as aux;

