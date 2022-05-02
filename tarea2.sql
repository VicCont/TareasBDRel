create table tarea2 (
id_art int generated always as identity,
nombre varchar (60), 
email varchar (120), 
primary key (id_art)
);

insert into tarea2 (nombre, email) values 
('Wanda Maximoff','wanda.maximoff@avengers.org'),
('Pietro Maximoff','pietro@mail.sokovia.ru'),
('Erik Lensherr','fuck_you_charles@brotherhood.of.evil.mutants.space'),
('Charles Xavier','i.am.secretely.filled.with.hubris@xavier-school-4-gifted-youngste.'),
('Anthony Edward Stark','iamironman@avengers.gov'),
('Steve Rogers','americas_ass@anti_avengers'),
('The Vision','vis@westview.sword.gov'),
('Clint Barton','bul@lse.ye'),
('Natasja Romanov','blackwidow@kgb.ru'),
('Thor','god_of_thunder-^_^@royalty.asgard.gov'),
('Logan','wolverine@cyclops_is_a_jerk.com'),
('Ororo Monroe','ororo@weather.co'),
('Scott Summers','o@x'),
('Nathan Summers','cable@xfact.or'),
('Groot','iamgroot@asgardiansofthegalaxyledbythor.quillsux'),
('Nebula','idonthaveelektras@complex.thanos'),
('Gamora','thefiercestwomaninthegalaxy@thanos.'),
('Rocket','shhhhhhhh@darknet.ru');



select t.email from tarea2 t
where  not t.email ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9._-]+[.][A-Za-z]+$'
; 


create table pto_extra(
id_sup int not null generated always as identity,
nombre varchar(60),
agencia varchar(60),
tiempo int,
primary key (id_sup)
);

insert into pto_extra (nombre,agencia,tiempo) values 
('Tony Stark','Avengers','10
'),('Wanda Maximoff','Avengers','5
'),('Wanda Maximoff','X Men','3
'),('Erik Lensherr','Acolytes','10
'),('Erik Lensherr','Brotherhood of Evil Mutants','12
'),('Natasja Romanov','KGB','8
'),('Natasja Romanov','Avengers','10');

select * from pto_extra pe ;
select pe.nombre , sum(pe.tiempo), string_agg(pe.agencia, ', ')  from pto_extra pe group by pe.nombre  ;


