

--contamos cuantas pelis tiene cada tienda y calculamos cuantos contenedores necesitan (en todos los contenedores de la tienda, excepto tal vez 1 estaran los 50kd de peliculas)
select store_id ,ceil (count(*)*.01)  from inventory i group by store_id ;


-- nos damos cuenta de la forma del contenedor que buscamos en realidad es la de una figura de n lados,
-- vamos a limitar la altura de los cilindros a 3 y medio metros (pensando que la tienda mide 4 metros)
-- por lo tanto a lo mucho va a poder conetener floor(n)=350/30 n=11 (usamos la medida más larga para reducir el posible diametro).
-- los cilindros deben de cargar dentro de ellos a lo más 50kg de pelis, si este fuera el caso, deben de cargar 100 peliculas cada uno
-- ya tenemos el contenedor que sabemos mide 330 cm de altura, y que debe de contener a lo mucho 100 peliculas, 
-- floor(100/11)=9 , por lo que nos queda un contenedor que almacena 99 pelis

-- nos vamos a quedar con un prisma que tiene base una figura de 9 lados de 21 cm, y a esta area deberemos de sumarle los 9 rectangulos de 8*21
-- entonces el volumen aproximado de cada uno de estos cilindros sera r+8 donde r es el radio del cilindro de 9 lados de 21
-- llevando esto a una función de postgres

-- ver formula https://www-formula.com/geometry/radius-circumcircle/radius-circumcircle-regular-polygon
-- Nota: sumarle la profundidad de la pelicula nos da un radio un poco mayor por eso es aproximado 




DO $$declare pels_niv int;
 pels_cont int;
 num_lados int;
 radio float  ;
med_pel_h float := 30 ; med_pel_l float := 21 ; med_pel_w float := 8 ; h_edif float := 350 ; weight_pel float := 500 ; weigh_cont float:= 50000;
BEGIN
select floor(h_edif/med_pel_h) into pels_niv  ;
select floor(weigh_cont/weight_pel) into pels_cont ;
select floor(pels_cont/pels_niv) into num_lados  ;
select med_pel_l/(2*sin(pi()/(2*num_lados))) into radio;
   raise notice 'altura del cilindro %', pels_niv *med_pel_l  ;
raise notice ' peliculas por cilindro %' ,pels_niv*num_lados ;
raise notice 'volumen total %', pi()*power (radio+med_pel_w,2);

END$$;
/*
drop function tarea5;
CREATE or replace function tarea5 (med_pel_h float , med_pel_l float , med_pel_w float , h_edif float , weight_pel float , weigh_cont float)
returns table (sucursal float, num_cin float, alto_cil float, pels_por_niv float, volumen float )
as $$ 
declare pels_niv int;
 pels_cont int;
 num_lados int;
 radio float  ;
begin
select floor(h_edif/med_pel_h) into pels_niv  ;
select floor(weigh_cont/weight_pel) into pels_cont ;
select floor(pels_cont/pels_niv) into num_lados  ;
select med_pel_l/(2*sin(pi()/(2*num_lados))) into radio;
return query
select store_id ,ceil(count(*)/(pels_niv*num_lados)),pels_niv*med_pel_h, num_lados,pi()*power(radio+med_pel_w,2)  from inventory i group by store_id ;
end;
$$ language plpgsql ;

select * from tarea5 (30::float,21::float,8::float ,350::float,500::float ,50000::float)
*/
