
 DROP TABLE TRANSACCION CASCADE CONSTRAINTS;
 DROP TABLE DEPARTAMENTO  CASCADE CONSTRAINTS;
 DROP TABLE EMPLEADO  CASCADE CONSTRAINTS;
 DROP TABLE EMPRESA  CASCADE CONSTRAINTS;
 DROP TABLE INDIVIDUO  CASCADE CONSTRAINTS;
 DROP TABLE OFICINA  CASCADE CONSTRAINTS;
 DROP TABLE PRODUCTO  CASCADE CONSTRAINTS;
 DROP TABLE TIPOPRODUCTO  CASCADE CONSTRAINTS;
 DROP TABLE AUTORIZADO CASCADE CONSTRAINTS;
 DROP TABLE CLIENTE CASCADE CONSTRAINTS;
 DROP TABLE CUENTA CASCADE CONSTRAINTS;

  DROP SEQUENCE SEQ_COD_DEPARTAMENTO;
  DROP SEQUENCE SEQ_COD_OFICINA; 
  DROP SEQUENCE SEQ_COD_EMPLEADO;
  DROP SEQUENCE SEQ_COD_CLIENTE;
  DROP SEQUENCE SEQ_COD_AUTORIZADO;
  DROP SEQUENCE SEQ_COD_CUENTA;
  DROP SEQUENCE SEQ_COD_TRANSACCION;

  
  CREATE SEQUENCE  SEQ_COD_DEPARTAMENTO  
  MINVALUE 1 MAXVALUE 9999 
  INCREMENT BY 1 START WITH 1 
  NOCACHE  ORDER  NOCYCLE;
  
  CREATE SEQUENCE  SEQ_COD_OFICINA  
  MINVALUE 1 MAXVALUE 9999 
  INCREMENT BY 1 START WITH 1 
  NOCACHE  ORDER  NOCYCLE;

  CREATE SEQUENCE  SEQ_COD_EMPLEADO
  MINVALUE 1 MAXVALUE 9999 
  INCREMENT BY 1 START WITH 1 
  NOCACHE  ORDER  NOCYCLE;
  
  CREATE SEQUENCE  SEQ_COD_CLIENTE
  MINVALUE 1 MAXVALUE 9999 
  INCREMENT BY 1 START WITH 1 
  NOCACHE  ORDER  NOCYCLE;
  
  CREATE SEQUENCE  SEQ_COD_AUTORIZADO
  MINVALUE 1 MAXVALUE 9999 
  INCREMENT BY 1 START WITH 1 
  NOCACHE  ORDER  NOCYCLE;
  
  CREATE SEQUENCE  SEQ_COD_CUENTA
  MINVALUE 1 MAXVALUE 9999 
  INCREMENT BY 1 START WITH 1 
  NOCACHE  ORDER  NOCYCLE;
  
  CREATE SEQUENCE  SEQ_COD_TRANSACCION
  MINVALUE 1 MAXVALUE 9999 
  INCREMENT BY 1 START WITH 1 
  NOCACHE  ORDER  NOCYCLE;



create table departamento (
  codigo smallint not null,
  nombre varchar(20) not null,
  constraint pk_departamento primary key (codigo)
 );

create table oficina
 (codigo smallint not null,
  nombre varchar(20) not null,
  direccion varchar(30),
  ciudad varchar(20),
  estado varchar(2),
  cp varchar(12),
  constraint pk_oficina primary key (codigo)
 );

create table empleado
 (codigo smallint not null,
  nombre varchar(20) not null,
  apellidos varchar(20) not null,
  fecha_alta date not null,
  fecha_baja date,
  codigo_superior smallint,
  codigo_departamento smallint,
  titulo varchar(20),
  codigo_oficina smallint,
  constraint fk_emp_empleado 
    foreign key (codigo_superior) references empleado (codigo),
  constraint fk_emp_departamento
  foreign key (codigo_departamento) references departamento (codigo),
  constraint fk_emp_oficina
    foreign key (codigo_oficina) references oficina (codigo),
  constraint pk_empleado primary key (codigo)
 );

create table tipoproducto
 (codigo varchar(10) not null,
  nombre varchar(50) not null,
  constraint pk_tipoproducto primary key (codigo)
 );

create table producto
 (codigo varchar(10) not null,
  nombre varchar(50) not null,
  codigo_tipo varchar(10) not null,
  fecha_inicio date,
  fecha_fin date,
  constraint fk_prod_tipoprod foreign key (codigo_tipo) 
    references tipoproducto (codigo),
  constraint pk_producto primary key (codigo)
 );

create table cliente
 (codigo integer not null,
  id varchar(12) not null,
  tipo_cliente varchar(1) not null,
  direccion varchar(30),
  ciudad varchar(20),
  estado varchar(20),
  cp varchar(10),
  constraint pk_customer primary key (codigo)
 );

create table individuo
 (codigo integer not null,
  nombre varchar(30) not null,
  apellidos varchar(30) not null,
  fecha_nacimiento date,
  constraint fk_individuo_cliente foreign key (codigo)
    references cliente (codigo),
  constraint pk_individuo primary key (codigo)
 );

create table empresa
 (codigo integer not null,
  nombre varchar(40) not null,
  estado varchar(10) not null,
  FECHA_CONSTITUCION date,
  constraint fk_emp_cod_cliente foreign key (codigo)
    references cliente (codigo),
  constraint pk_empresa primary key (codigo)
 );

create table autorizado
 (codigo smallint not null,
  codigo_empresa integer not null,
  nombre varchar(30) not null,
  apellidos varchar(30) not null,
  titulo varchar(20),
  fecha_inicio date not null,
  fecha_fin date,
  constraint fk_aut_cod_empresa foreign key (codigo_empresa)
    references empresa (codigo),
  constraint pk_autorizado primary key (codigo)
 );

create table CUENTA
 (numero integer not null,
  estado varchar2(10),
  fecha_apertura date not null,
  fecha_cierre date,
  fecha_ultima_operacion date,
  saldo number (10,2),
  saldo_disponible number (10,2),
  codigo_producto varchar(10) not null,
  codigo_cliente integer  not null,
  codigo_oficina smallint ,
  codigo_empleado smallint ,
  constraint fk_CUENTA_prod foreign key (codigo_producto)
    references producto (codigo),
  constraint fk_CUENTA_cliente foreign key (codigo_cliente)
    references cliente (codigo),
  constraint fk_CUENTA_oficina foreign key (codigo_oficina)
    references oficina (codigo),
  constraint fk_CUENTA_empelado foreign key (codigo_empleado)
    references empleado (codigo),
  constraint pk_CUENTA primary key (numero)
 );

create table TRANSACCION
 (codigo integer not null,
  fecha_transaccion date not null,
  codigo_CUENTA integer not null,
  tipo_operacion varchar(3),
  cantidad number(10,2) not null,
  codigo_empleado smallint,
  codigo_oficina smallint,
  fecha_disponibilidad date,
  constraint fk_tran_CUENTA foreign key (codigo_CUENTA)
    references CUENTA (numero),
  constraint fk_tran_empleado foreign key (codigo_empleado)
    references empleado (codigo),
  constraint fk_tran_oficina foreign key (codigo_oficina)
    references oficina (codigo),
  constraint pk_transaccion primary key (codigo)
 );


insert into DEPARTAMENTO (CODIGO, NOMBRE)
values (SEQ_COD_DEPARTAMENTO.nextval, 'Operaciones');
insert into DEPARTAMENTO (CODIGO, NOMBRE)
values (SEQ_COD_DEPARTAMENTO.nextval, 'Prestamos');
insert into DEPARTAMENTO (CODIGO, NOMBRE)
values (SEQ_COD_DEPARTAMENTO.nextval, 'Administracion');


insert into OFICINA (CODIGO, NOMBRE, DIRECCION, CIUDAD, ESTADO, CP)
values (SEQ_COD_OFICINA.NEXTVAL, 'Headquarters', '3882 Main St.', 'Waltham', 'MA', '02451');
insert into OFICINA (CODIGO, NOMBRE, DIRECCION, CIUDAD, ESTADO, CP)
values (SEQ_COD_OFICINA.NEXTVAL, 'Woburn Branch', '422 Maple St.', 'Woburn', 'MA', '01801');
insert into OFICINA (CODIGO, NOMBRE, DIRECCION, CIUDAD, ESTADO, CP)
values (SEQ_COD_OFICINA.NEXTVAL, 'Quincy Branch', '125 Presidential Way', 'Quincy', 'MA', '02169');
insert into OFICINA (CODIGO, NOMBRE, DIRECCION, CIUDAD, ESTADO, CP)
values (SEQ_COD_OFICINA.NEXTVAL, 'So. NH Branch', '378 Maynard Ln.', 'Salem', 'NH', '03079');


insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.NEXTVAL, 'Michael', 'Smith', '22/06/2001', 
  (select codigo from departamento where nombre = 'Administracion'), 
  'President', 
  (select codigo from oficina where nombre = 'Headquarters'));
  
  insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Susan', 'Barker', '12/09/2002', 
  (select codigo from departamento where nombre = 'Administracion'), 
  'Vice President', 
  (select codigo from oficina where nombre = 'Headquarters'));
  
 insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Robert', 'Tyler', '09/02/2000',
  (select CODIGO from departamento where nombre = 'Administracion'), 
  'Treasurer', 
  (select codigo from oficina where nombre = 'Headquarters'));
  
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Susan', 'Hawthorne', to_date('2002-04-24','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Operations Manager', 
  (select codigo from oficina where nombre = 'Headquarters'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'John', 'Gooding', to_date('2003-11-14','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'PRESTAMOs'), 
  'PRESTAMO Manager', 
  (select codigo from oficina where nombre = 'Headquarters'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Helen', 'Fleming', to_date('2004-03-17','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Head Teller', 
  (select codigo from oficina where nombre = 'Headquarters'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Chris', 'Tucker', to_date('2004-09-15','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Teller', 
  (select codigo from oficina where nombre = 'Headquarters'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Sarah', 'Parker', to_date('2002-12-02','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Teller', 
  (select codigo from oficina where nombre = 'Headquarters'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Jane', 'Grossman', to_date('2002-05-03','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Teller', 
  (select codigo from oficina where nombre = 'Headquarters'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Paula', 'Roberts', to_date('2002-07-27','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Head Teller', 
  (select codigo from oficina where nombre = 'Woburn Branch'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Thomas', 'Ziegler', to_date('2000-10-23','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Teller', 
  (select codigo from oficina where nombre = 'Woburn Branch'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Samantha', 'Jameson', to_date('2003-01-08','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Teller', 
  (select codigo from oficina where nombre = 'Woburn Branch'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'John', 'Blake', to_date('2000-05-11','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Head Teller', 
  (select codigo from oficina where nombre = 'Quincy Branch'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Cindy', 'Mason', to_date('2002-08-09','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Teller', 
  (select codigo from oficina where nombre = 'Quincy Branch'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Frank', 'Portman', to_date('2003-04-01','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Teller', 
  (select codigo from oficina where nombre = 'Quincy Branch'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Theresa', 'Markham', to_date('2001-03-15','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Head Teller', 
  (select codigo from oficina where nombre = 'So. NH Branch'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Beth', 'Fowler', to_date('2002-06-29','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Teller', 
  (select codigo from oficina where nombre = 'So. NH Branch'));
insert into EMPLEADO (codigo, nombre, apellidos, fecha_alta, 
  codigo_departamento, titulo, codigo_oficina)
values (SEQ_COD_EMPLEADO.nextval, 'Rick', 'Tulman', to_date('2002-12-12','YYYY-MM-DD'), 
  (select codigo from departamento where nombre = 'Operaciones'), 
  'Teller', 
  (select codigo from oficina where nombre = 'So. NH Branch'));



create table emp_tmp as
select codigo, nombre, apellidos from empleado;

update empleado set codigo_superior =
 (select codigo from emp_tmp where apellidos = 'Smith' and nombre = 'Michael')
where ((apellidos = 'Barker' and nombre = 'Susan')
  or (apellidos = 'Tyler' and nombre = 'Robert'));
update empleado set codigo_superior =
 (select codigo from emp_tmp where apellidos = 'Tyler' and nombre = 'Robert')
where apellidos = 'Hawthorne' and nombre = 'Susan';
update empleado set codigo_superior =
 (select codigo from emp_tmp where apellidos = 'Hawthorne' and nombre = 'Susan')
where ((apellidos = 'Gooding' and nombre = 'John')
  or (apellidos = 'Fleming' and nombre = 'Helen')
  or (apellidos = 'Roberts' and nombre = 'Paula') 
  or (apellidos = 'Blake' and nombre = 'John') 
  or (apellidos = 'Markham' and nombre = 'Theresa')); 
update empleado set codigo_superior =
 (select codigo from emp_tmp where apellidos = 'Fleming' and nombre = 'Helen')
where ((apellidos = 'Tucker' and nombre = 'Chris') 
  or (apellidos = 'Parker' and nombre = 'Sarah') 
  or (apellidos = 'Grossman' and nombre = 'Jane'));  
update empleado set codigo_superior =
 (select codigo from emp_tmp where apellidos = 'Roberts' and nombre = 'Paula')
where ((apellidos = 'Ziegler' and nombre = 'Thomas')  
  or (apellidos = 'Jameson' and nombre = 'Samantha'));   
update empleado set codigo_superior =
 (select codigo from emp_tmp where apellidos = 'Blake' and nombre = 'John')
where ((apellidos = 'Mason' and nombre = 'Cindy')   
  or (apellidos = 'Portman' and nombre = 'Frank'));    
update empleado set codigo_superior =
 (select codigo from emp_tmp where apellidos = 'Markham' and nombre = 'Theresa')
where ((apellidos = 'Fowler' and nombre = 'Beth')   
  or (apellidos = 'Tulman' and nombre = 'Rick'));    

drop table emp_tmp;


/* tipos de productos */
insert into TIPOPRODUCTO (codigo, nombre)
values ('CUENTA','Cuentas de clientes');
insert into TIPOPRODUCTO (codigo, nombre)
values ('PRESTAMO','Prestamos individuales y de negocios');
insert into TIPOPRODUCTO (codigo, nombre)
values ('SEGURO','Ofertas de seguros');

/* productos */
insert into producto (codigo, nombre, codigo_tipo, fecha_inicio)
values ('CHK','Cuenta corriente','CUENTA',to_date('2000-01-01','YYYY-MM-DD'));
insert into producto (codigo, nombre, codigo_tipo, fecha_inicio)
values ('SAV','Cuenta ahorro','CUENTA',to_date('2000-01-01','YYYY-MM-DD'));
insert into producto (codigo, nombre, codigo_tipo, fecha_inicio)
values ('MM','Cuenta Negocio','CUENTA',to_date('2000-01-01','YYYY-MM-DD'));
insert into producto (codigo, nombre, codigo_tipo, fecha_inicio)
values ('CD','Deposito bancario','CUENTA',to_date('2000-01-01','YYYY-MM-DD'));
insert into producto (codigo, nombre, codigo_tipo, fecha_inicio)
values ('MRT','Prestamo vivienda','PRESTAMO',to_date('2000-01-01','YYYY-MM-DD'));
insert into producto (codigo, nombre, codigo_tipo, fecha_inicio)
values ('AUT','Prestamo coche','PRESTAMO',to_date('2000-01-01','YYYY-MM-DD'));
insert into producto (codigo, nombre, codigo_tipo, fecha_inicio)
values ('BUS','Linea de credito negocio','PRESTAMO',to_date('2000-01-01','YYYY-MM-DD'));
insert into producto (codigo, nombre, codigo_tipo, fecha_inicio)
values ('SBL','Prestamo pequeño negocio','PRESTAMO',to_date('2000-01-01','YYYY-MM-DD'));


DELETE FROM AUTORIZADO;
DELETE FROM EMPRESA;
DELETE FROM INDIVIDUO;
DELETE FROM CLIENTE;


insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '111-11-1111', 'I', '47 Mockingbird Ln', 'Lynnfield', 'MA', '01940');
insert into individuo (codigo, nombre, apellidos, fecha_nacimiento)
select codigo, 'James', 'Hadley', to_date('1972-04-22','YYYY-MM-DD') from cliente
where id = '111-11-1111';
insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '222-22-2222', 'I', '372 Clearwater Blvd', 'Woburn', 'MA', '01801');
insert into individuo (codigo, nombre, apellidos, fecha_nacimiento)
select codigo, 'Susan', 'Tingley', to_date('1968-08-15','YYYY-MM-DD') from cliente
where id = '222-22-2222';
insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '333-33-3333', 'I', '18 Jessup Rd', 'Quincy', 'MA', '02169');
insert into individuo (codigo, nombre, apellidos, fecha_nacimiento)
select codigo, 'Frank', 'Tucker', to_date('1958-02-06','YYYY-MM-DD') from cliente
where id = '333-33-3333';
insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '444-44-4444', 'I', '12 Buchanan Ln', 'Waltham', 'MA', '02451');
insert into individuo (codigo, nombre, apellidos, fecha_nacimiento)
select codigo, 'John', 'Hayward', to_date('1966-12-22','YYYY-MM-DD') from cliente
where id = '444-44-4444';
insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '555-55-5555', 'I', '2341 Main St', 'Salem', 'NH', '03079');
insert into individuo (codigo, nombre, apellidos, fecha_nacimiento)
select codigo, 'Charles', 'Frasier', to_date('1971-08-25','YYYY-MM-DD') from cliente
where id = '555-55-5555';
insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '666-66-6666', 'I', '12 Blaylock Ln', 'Waltham', 'MA', '02451');
insert into individuo (codigo, nombre, apellidos, fecha_nacimiento)
select codigo, 'John', 'Spencer', to_date('1962-09-14','YYYY-MM-DD') from cliente
where id = '666-66-6666';
insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '777-77-7777', 'I', '29 Admiral Ln', 'Wilmington', 'MA', '01887');
insert into individuo (codigo, nombre, apellidos, fecha_nacimiento)
select codigo, 'Margaret', 'Young', to_date('1947-03-19','YYYY-MM-DD') from cliente
where id = '777-77-7777';
insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '888-88-8888', 'I', '472 Freedom Rd', 'Salem', 'NH', '03079');
insert into individuo (codigo, nombre, apellidos, fecha_nacimiento)
select codigo, 'Louis', 'Blake', to_date('1977-07-01','YYYY-MM-DD') from cliente
where id = '888-88-8888';
insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '999-99-9999', 'I', '29 Maple St', 'Newton', 'MA', '02458');
insert into individuo (codigo, nombre, apellidos, fecha_nacimiento)
select codigo, 'Richard', 'Farley', to_date('1968-06-16','YYYY-MM-DD') from cliente
where id = '999-99-9999';

/* clientes de empresas */
insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '04-1111111', 'B', '7 Industrial Way', 'Salem', 'NH', '03079');
insert into empresa (codigo, nombre, estado, fecha_constitucion)
select codigo, 'Chilton Engineering', '12-345-678', to_date('1995-05-01','YYYY-MM-DD') from CLIENTE
where id = '04-1111111';
insert into autorizado (codigo, codigo_empresa, nombre, apellidos, 
titulo, fecha_inicio)
select SEQ_COD_AUTORIZADO.NEXTVAL, codigo, 'John', 'Chilton', 'President', to_date('1995-05-01','YYYY-MM-DD')
from CLIENTE
where id = '04-1111111';

insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '04-2222222', 'B', '287A Corporate Ave', 'Wilmington', 'MA', '01887');
insert into empresa (codigo, nombre, estado, fecha_constitucion)
select codigo, 'Northeast Cooling Inc.', '23-456-789', to_date('2001-01-01','YYYY-MM-DD') from CLIENTE
where id = '04-2222222';
insert into autorizado (codigo, codigo_empresa, nombre, apellidos, 
titulo, fecha_inicio)
select SEQ_COD_AUTORIZADO.NEXTVAL, codigo, 'Paul', 'Hardy', 'President', to_date('2001-01-01','YYYY-MM-DD')
from CLIENTE
where id = '04-2222222';

insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '04-3333333', 'B', '789 Main St', 'Salem', 'NH', '03079');
insert into empresa (codigo, nombre, estado, fecha_constitucion)
select codigo, 'Superior Auto Body', '34-567-890', to_date('2002-06-30','YYYY-MM-DD') from CLIENTE
where id = '04-3333333';
insert into autorizado (codigo, codigo_empresa, nombre, apellidos, 
titulo, fecha_inicio)
select SEQ_COD_AUTORIZADO.NEXTVAL, codigo, 'Carl', 'Lutz', 'President', to_date('2002-06-30','YYYY-MM-DD')
from CLIENTE
where id = '04-3333333';

insert into cliente (codigo, id, tipo_cliente, direccion, ciudad, estado, cp)
values (SEQ_COD_CLIENTE.NEXTVAL, '04-4444444', 'B', '4772 Presidential Way', 'Quincy', 'MA', '02169');
insert into empresa (codigo, nombre, estado, fecha_constitucion)
select codigo, 'AAA SEGURO Inc.', '45-678-901', to_date('1999-05-01','YYYY-MM-DD') from CLIENTE
where id = '04-4444444';
insert into autorizado (codigo, codigo_empresa, nombre, apellidos, 
titulo, fecha_inicio)
select SEQ_COD_AUTORIZADO.NEXTVAL, codigo, 'Stanley', 'Cheswick', 'President', to_date('1999-05-01','YYYY-MM-DD')
from CLIENTE
where id = '04-4444444';

/* residential CUENTA data */
insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Woburn' and rownum = 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2000-01-15','YYYY-MM-DD') open_date,  to_date('2005-01-04','YYYY-MM-DD') last_date,
    1057.75 avail, 1057.75 pend from dual union all
  select 'SAV' prod_cd,  to_date('2000-01-15','YYYY-MM-DD') open_date,  to_date('2004-12-19','YYYY-MM-DD') last_date,
    500.00 avail, 500.00 pend from dual union all
  select 'CD' prod_cd,  to_date('2004-06-30','YYYY-MM-DD') open_date,  to_date('2004-06-30','YYYY-MM-DD') last_date,
    3000.00 avail, 3000.00 pend from dual) a
where c.id = '111-11-1111';


insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Woburn' and rownum = 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2001-03-12','YYYY-MM-DD') open_date, to_date('2004-12-27','YYYY-MM-DD') last_date,
    2258.02 avail, 2258.02 pend from dual union all
  select 'SAV' prod_cd, to_date('2001-03-12','YYYY-MM-DD') open_date, to_date('2004-12-11','YYYY-MM-DD') last_date,
    200.00 avail, 200.00 pend from dual) a
where c.id = '222-22-2222';


insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Quincy' and rownum = 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2002-11-23','YYYY-MM-DD') open_date, to_date('2004-11-30','YYYY-MM-DD') last_date,
    1057.75 avail, 1057.75 pend from dual union all
  select 'MM' prod_cd, to_date('2002-12-15','YYYY-MM-DD') open_date, to_date('2004-12-05','YYYY-MM-DD') last_date,
    2212.50 avail, 2212.50 pend from dual) a
where c.id = '333-33-3333';


insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Waltham' and rownum = 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2003-09-12','YYYY-MM-DD') open_date, to_date('2005-01-03','YYYY-MM-DD') last_date,
    534.12 avail, 534.12 pend from dual union all
  select 'SAV' prod_cd, to_date('2000-01-15','YYYY-MM-DD') open_date, to_date('2004-10-24','YYYY-MM-DD') last_date,
    767.77 avail, 767.77 pend from dual union all
  select 'MM' prod_cd, to_date('2004-09-30','YYYY-MM-DD') open_date, to_date('2004-11-11','YYYY-MM-DD') last_date,
    5487.09 avail, 5487.09 pend from dual) a
where c.id = '444-44-4444';


insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Salem' and rownum = 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2004-01-27','YYYY-MM-DD') open_date, to_date('2005-01-05','YYYY-MM-DD') last_date,
    2237.97 avail, 2897.97 pend from dual) a
where c.id = '555-55-5555';


insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Waltham' and rownum = 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2002-08-24','YYYY-MM-DD') open_date, to_date('2004-11-29','YYYY-MM-DD') last_date,
    122.37 avail, 122.37 pend from dual union all
  select 'CD' prod_cd, to_date('2004-12-28','YYYY-MM-DD') open_date, to_date('2004-12-28','YYYY-MM-DD') last_date,
    10000.00 avail, 10000.00 pend from dual) a
where c.id = '666-66-6666';


insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Woburn' and rownum = 1) e
  cross join
 (select 'CD' prod_cd, to_date('2004-01-12','YYYY-MM-DD') open_date, to_date('2004-01-12','YYYY-MM-DD') last_date,
    5000.00 avail, 5000.00 pend from dual) a
where c.id = '777-77-7777';


insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Salem' and rownum = 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2001-05-23','YYYY-MM-DD') open_date, to_date('2005-01-03','YYYY-MM-DD') last_date,
    3487.19 avail, 3487.19 pend from dual union all
  select 'SAV' prod_cd, to_date('2001-05-23','YYYY-MM-DD') open_date, to_date('2004-10-12','YYYY-MM-DD') last_date,
    387.99 avail, 387.99 pend from dual) a
where c.id = '888-88-8888';


insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Waltham' and rownum = 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2003-07-30','YYYY-MM-DD') open_date, to_date('2004-12-15','YYYY-MM-DD') last_date,
    125.67 avail, 125.67 pend from dual union all
  select 'MM' prod_cd, to_date('2004-10-28','YYYY-MM-DD') open_date, to_date('2004-10-28','YYYY-MM-DD') last_date,
    9345.55 avail, 9845.55 pend from dual union all
  select 'CD' prod_cd, to_date('2004-06-30','YYYY-MM-DD') open_date, to_date('2004-06-30','YYYY-MM-DD') last_date,
    1500.00 avail, 1500.00 pend from dual) a
where c.id = '999-99-9999';

insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Salem' and rownum = 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2002-09-30','YYYY-MM-DD') open_date, to_date('2004-12-15','YYYY-MM-DD') last_date,
    23575.12 avail, 23575.12 pend from dual union all
  select 'BUS' prod_cd, to_date('2002-10-01','YYYY-MM-DD') open_date, to_date('2004-08-28','YYYY-MM-DD') last_date,
    0 avail, 0 pend from dual ) a
where c.id = '04-1111111';


insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Woburn' and rownum = 1) e
  cross join
 (select 'BUS' prod_cd, to_date('2004-03-22','YYYY-MM-DD') open_date, to_date('2004-11-14','YYYY-MM-DD') last_date,
    9345.55 avail, 9345.55 pend from dual ) a
where c.id = '04-2222222';


insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Salem' and rownum = 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2003-07-30','YYYY-MM-DD') open_date, to_date('2004-12-15','YYYY-MM-DD') last_date,
    38552.05 avail, 38552.05 pend from dual) a
where c.id = '04-3333333';


insert into CUENTA (numero, codigo_producto, codigo_cliente, fecha_apertura,
  fecha_ultima_operacion, estado, codigo_oficina, 
  codigo_empleado, saldo, saldo_disponible)
select SEQ_COD_CUENTA.nextval, a.prod_cd, c.CODIGO, a.open_date, a.last_date, 'ACTIVA',
  e.c_o, e.codigo, a.avail, a.pend
from CLIENTE c cross join 
 (select b.codigo as c_o, e.codigo 
  from OFICINA b inner join EMPLEADO e on e.codigo_oficina = b.codigo
  where b.ciudad = 'Quincy' and rownum = 1) e
  cross join
 (select 'SBL' prod_cd, to_date('2004-02-22','YYYY-MM-DD') open_date, to_date('2004-12-17','YYYY-MM-DD') last_date,
    50000.00 avail, 50000.00 pend from dual) a
where c.id = '04-4444444';


insert into TRANSACCION (codigo, fecha_transaccion, codigo_cuenta, tipo_operacion,
  cantidad, fecha_disponibilidad)
select SEQ_COD_TRANSACCION.NEXTVAL, a.fecha_apertura, a.numero, 'CDT', 100, a.fecha_apertura
from CUENTA a
where a.codigo_producto IN ('CHK','SAV','CD','MM');


