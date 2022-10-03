--Entregado por Christian Santos y Sebastian Tarazona
CREATE DATABASE ParcialFinal;
CREATE USER 'admin'@'Localhost' IDENTIFIED BY '11223344';
GRANT select, insert on * . * TO 'admin';
 
GRANT ALL PRIVILEGES ON parcialbd.* TO 'admin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE USER 'consulta'@'Localhost' IDENTIFIED BY '111222';
GRANT select TO 'consulta';

sudo -u admin -p
sudo -u consulta -p

 USE 'ParcialFinal';

 CREATE TABLE Pedidos(
    id_pedido INT(4) NOT NULL AUTO_INCREMENT,
    fk_empleado INT(4) NOT NULL,
    fk_cliente INT(4) NOT NULL,
    fk_transportadora INT(4) NOT NULL,
    PRIMARY KEY (id_pedido)
    CONSTRAINT se encarga
        FOREIGN KEY (fk_empleado) REFERENCES Empleados(id_empleado)
    CONSTRAINT recibe
        FOREIGN KEY (fk_cliente) REFERENCES Cliente(id_cliente)
    CONSTRAINT envia
        FOREIGN KEY (fk_transportadora) REFERENCES Transportadoras(id_transaportadoras)
 )
 ENGINE = InnoDB;

 CREATE TABLE pedidos_productos(
    id_pedido_producto INT(4) NOT NULL AUTO_INCREMENT,
    fk_pp_pedido INT(4) NOT NULL,
    fk_producto INT(10)
    pp_unidades INT(5);
    pp_valor_unitario INT(10);
    PRIMARY KEY (id_pedido_producto)
    CONSTRAINT contiene
        FOREIGN KEY (fk_pp_pedido) REFERENCES Pedidos(id_pedido)
    CONSTRAINT contiene
        FOREIGN KEY (fk_producto) REFERENCES Productos(id_productos)    
 )
 ENGINE = InnoDB;

 CREATE TABLE pedidos_estados(
    id_pedido_estado INT(4) NOT NULL AUTO_INCREMENT,
    fk_pe_pedido INT(4) NOT NULL,
    fk_tipo_movimiento INT(10) NOT NULL,
    pe_observacion VARCHAR(20) NOT NULL,
    pe_fecha_hora_movimiento VARCHAR(40) NOT NULL,
    PRIMARY KEY (id_pedido_estado)
    CONSTRAINT contiene
        FOREIGN KEY (fk_pedido) REFERENCES Pedidos(id_pedido)
    CONSTRAINT contiene
        FOREIGN KEY (fk_tipo_movimiento) REFERENCES Tipos_movimiento(id_tipos_movimientos)
    
 )
ENGINE = InnoDB;


CREATE TABLE Cliente (
    id_cliente INT(4) NOT NULL AUTO_INCREMENT,
    cl_identificacion INT(10) NOT NULL,
    cl_nombre VARCHAR(160) NOT NULL,
    cl_direccion VARCHAR(80) NOT NULL,
    fk_municipio INT(10) NOT NULL,
    PRIMARY KEY (id_cliente)
    CONSTRAINT pertenecen
        FOREIGN KEY (fk_municipio) REFERENCES Municipio(id_municipio)    
)
CREATE CLUSTERED INDEX IDX_Cliente
ON Cliente (cl_nombre)

ENGINE = InnoDB;

CREATE TABLE Empleados(
    id_empleado INT(4) NOT NULL AUTO_INCREMENT,
    em_identificacion INT(10) NOT NULL,
    em_nombres VARCHAR(160) NOT NULL,
    PRIMARY KEY (id_empleado)
)

CREATE CLUSTERED INDEX IDX_Empleados
ON Empleados (em_nombres)

CREATE TABLE Facturas(
    id_factura INT(4) NOT NULL AUTO_INCREMENT,
    fk_pedido INT(6) NOT NULL,
    fc_fecha DATE NOT NULL,
    PRIMARY KEY (id_factura)
    CONSTRAINT se obtiene
        FOREIGN KEY (fk_pedido) REFERENCES Pedidos(id_pedido)
    
)
ENGINE = InnoDB;

CREATE TABLE Facturas_pagos(
    id_factura_pago INT (4) NOT NULL AUTO_INCREMENT,
    fk_factura INT(4) NOT NULL,
    fc_valor_pago INT(15) NOT NULL,
    fc_forma_de_pago VARCHAR (20) NOT NULL,
    fc_fecha_hora VARCHAR (20) NOT NULL,
    PRIMARY KEY (id_factura_pago)
    CONSTRAINT contiene
        FOREIGN KEY (fk_factura) REFERENCES Facturas(id_factura)
)
CREATE NONCLUSTERED INDEX IDX_FacturaPago
ON Cliente (fc_forma_de_pago)

CREATE TABLE transportadoras(
    id_transporadoras INT(6) NOT NULL AUTO_INCREMENT,
    tr_empresa VARCHAR(60) NOT NULL,
    tr_direccion VARCHAR(50) NOT NULL,
    fk_id_municipio INT(10) NOT NULL,
    PRIMARY KEY (id_transporadoras) 
    CONSTRAINT tiene
        FOREIGN KEY (fk_id_municipio) REFERENCES Municipios(id_municipio)  

)
ENGINE = InnoDB;

CREATE TABLE municipios(
    id_municipio INT (10) NOT NULL AUTO_INCREMENT,
    mu_municipio VARCHAR(60) NOT NULL,
    fk_id_departamento INT(10) NOT NULL,
    mu_capital VARCHAR (60) NOT NULL,
    mu_cod_divipola_municipio INT (5) NOT NULL, 
    PRIMARY KEY (id_municipio)
    CONSTRAINT tiene
        FOREIGN KEY (fk_id_departamento) REFERENCES Departamentos(id_departamento)
)
ENGINE = InnoDB;

CREATE TABLE departamentos(
    id_departamento INT (10) NOT NULL AUTO_INCREMENT,
    de_departamento VARCHAR (60) NOT NULL,
    de_cod_divipola_departamento FLOAT (7) NOT NULL,
    PRIMARY KEY (id_departamento)
)

CREATE TABLE bodegas(
    id_bodegas INT (10) NOT NULL AUTO_INCREMENT,
    bo_direccion VARCHAR (50) NOT NULL,
    fk_id_municipio INT(10) NOT NULL,
    PRIMARY KEY (id_bodegas)
)

ALTER TABLE bodegas
 ADD CONSTRAINT pertenece FOREIGN KEY (fk_id_municipio) REFERENCES bodegas(id_bodegas);
ENGINE = InnoDB;

CREATE TABLE bodegas_productos(
    id_bodegas_productos INT(10) NOT NULL AUTO_INCREMENT,
    fk_id_bodega INT(10) NOT NULL,
    fk_id_broductos INT(10) NOT NULL,
    bopr_cantidad INT(10) NOT NULL,
    PRIMARY KEY (id_bodegas_productos)
)
ENGINE = InnoDB;

ALTER TABLE bodegas_productos
 ADD CONSTRAINT pertenece FOREIGN KEY (fk_id_bodega) REFERENCES bodegas_productos(id_bodegas_productos);
 ADD CONSTRAINT cantidad FOREIGN KEY (fk_id_productos) REFERENCES bodegas_productos(id_bodegas_productos);

CREATE TABLE productos(
    id_productos INT (10) NOT NULL AUTO_INCREMENT,
    pro_productos VARCHAR(50) NOT NULL,
    pro_descripcion VARCHAR (50) NOT NULL,
    pro_valor INT (100) NOT NULL,
    PRIMARY KEY (id_productos)
)

CREATE TABLE productos_caracteristicas(
    id_productos_caracteristiacas INT (10) NOT NULL AUTO_INCREMENT,
    fk_id_productos INT (10) NOT NULL,
    proca_caraterisitacas VARCHAR (20) NOT NULL,
    proca_descripcion VARCHAR (20) NOT NULL,
    PRIMARY KEY (id_productos_caracteristiacas)
)

ENGINE = InnoDB;
ALTER TABLE productos_caracteristicas
 ADD CONSTRAINT pertenece FOREIGN KEY (fk_id_productos) REFERENCES productos_caracteristicas(id_productos_caracteristiacas);


CREATE TABLE tipos_movimiento(
    id_tipos_movimientos INT (10) NOT NULL AUTO_INCREMENT,
    timo_tipo_movimiento VARCHAR (20) NOT NULL,
    timo_descripcion VARCHAR (20) NOT NULL,
    PRIMARY KEY (id_tipos_movimientos)
) 

--INDEX
tos(id_productos);

 CREATE INDEX I__id_productos ON Facturas(id_productos);
 CREATE INDEX i_id_factura ON Facturas(fCREATE UNIQUE NONCLUSTERED INDEX i_id_factura
ON facturas(facp_id);

CREATE UNIQUE NONCLUSTERED INDEX I__id_productos
ON producacp_id);x

-- Pedidos
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'1','1','1');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'2','2','2');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'3','3','3');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'4','4','4');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'5','5','5');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'6','6','6');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'7','7','7');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'8','8','8');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'9','9','9');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'10','10','10');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'11','11','11');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'12','12','12');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'13','13','13');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'14','14','14');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'15','15','15');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'16','16','16');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'17','17','17');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'18','18','18');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'19','19','19');
INSERT INTO Pedidos (id_pedido, fk_empleado, fk_cliente, fk_transportadora)
VALUES (NULL,'20','20','20');

-- Pedidos productos
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'1','1','10','1000');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'2','2','12','1500');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'3','3','14','2000');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'4','4','16','2200');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'5','5','18','2500');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'6','6','20','3000');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'7','7','25','4000');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'8','8','30','5500');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'9','9','35','6000');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'10','10','42','10000');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'11','11','44','10200');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'12','12','45','10500');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'13','13','48','11000');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'14','14','50','11500');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'15','15','53','11800');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'16','16','55','12000');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'17','17','56','12200');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'18','18','58','13000');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'19','19','62','14000');
INSERT INTO pedidos_productos (id_pedido_producto, fk_pp_pedido, fk_producto, pp_unidades, pp_valor_unitario)
VALUES (NULL,'20','20','68','16000');

-- Pedidos estados
INSERT INTO pedidos_estados (id_pedido_estado, fk_pe_pedido, fk_tipo_movimiento, pe_observacion, pe_fecha_hora_movimiento)
VALUES (NULL,'1','1','1','delicado','2/10/2022');
INSERT INTO pedidos_estados (id_pedido_estado, fk_pe_pedido, fk_tipo_movimiento, pe_observacion, pe_fecha_hora_movimiento)
VALUES (NULL,'2','2','2','no delicado','2/09/2022');
INSERT INTO pedidos_estados (id_pedido_estado, fk_pe_pedido, fk_tipo_movimiento, pe_observacion, pe_fecha_hora_movimiento)
VALUES (NULL,'3','3','3','delicado','2/08/2022');
INSERT INTO pedidos_estados (id_pedido_estado, fk_pe_pedido, fk_tipo_movimiento, pe_observacion, pe_fecha_hora_movimiento)
VALUES (NULL,'4','4','4','delicado','8/09/2022');
INSERT INTO pedidos_estados (id_pedido_estado, fk_pe_pedido, fk_tipo_movimiento, pe_observacion, pe_fecha_hora_movimiento)
VALUES (NULL,'5','5','5','delicado','10/09/2022');
INSERT INTO pedidos_estados (id_pedido_estado, fk_pe_pedido, fk_tipo_movimiento, pe_observacion, pe_fecha_hora_movimiento)
VALUES (NULL,'6','6','6','no delicado','13/09/2022');
INSERT INTO pedidos_estados (id_pedido_estado, fk_pe_pedido, fk_tipo_movimiento, pe_observacion, pe_fecha_hora_movimiento)
VALUES (NULL,'7','7','7','no delicado','15/09/2022');
INSERT INTO pedidos_estados (id_pedido_estado, fk_pe_pedido, fk_tipo_movimiento, pe_observacion, pe_fecha_hora_movimiento)
VALUES (NULL,'8','8','8','no delicado','20/09/2022');
INSERT INTO pedidos_estados (id_pedido_estado, fk_pe_pedido, fk_tipo_movimiento, pe_observacion, pe_fecha_hora_movimiento)
VALUES (NULL,'9','9','9','no delicado','22/09/2022');INSERT INTO pedidos_estados (id_pedido_estado, fk_pe_pedido, fk_tipo_movimiento, pe_observacion, pe_fecha_hora_movimiento)
VALUES (NULL,'10','10','10','delicado','26/09/2022');

-- Cliente
INSERT INTO Cliente (id_cliente, cl_identificacion, cl_nombre, cl_direccion, fk_municipio)
VALUES (NULL,'1097489764','Ana Quintero','Calle 200','1');
INSERT INTO Cliente (id_cliente, cl_identificacion, cl_nombre, cl_direccion, fk_municipio)
VALUES (NULL,'1097489323','Valentina Serrano','Calle 200','2');
INSERT INTO Cliente (id_cliente, cl_identificacion, cl_nombre, cl_direccion, fk_municipio)
VALUES (NULL,'1076589764','Daniel Carrillo','Calle 45','3');
INSERT INTO Cliente (id_cliente, cl_identificacion, cl_nombre, cl_direccion, fk_municipio)
VALUES (NULL,'1097423564','Felipe Suarez','Calle 30','4');
INSERT INTO Cliente (id_cliente, cl_identificacion, cl_nombre, cl_direccion, fk_municipio)
VALUES (NULL,'1089489764','Danna Mendoza','Calle 40','5');
INSERT INTO Cliente (id_cliente, cl_identificacion, cl_nombre, cl_direccion, fk_municipio)
VALUES (NULL,'1097459764','Camila Castellanos','Calle 30','6');
INSERT INTO Cliente (id_cliente, cl_identificacion, cl_nombre, cl_direccion, fk_municipio)
VALUES (NULL,'1023469764','Carlos Ferreira','Calle 22','7');
INSERT INTO Cliente (id_cliente, cl_identificacion, cl_nombre, cl_direccion, fk_municipio)
VALUES (NULL,'1057999764','Laura Perez','Calle 48','8');
INSERT INTO Cliente (id_cliente, cl_identificacion, cl_nombre, cl_direccion, fk_municipio)
VALUES (NULL,'1084489764','Diego Manrique','Calle 14','9');
INSERT INTO Cliente (id_cliente, cl_identificacion, cl_nombre, cl_direccion, fk_municipio)
VALUES (NULL,'1087489764','Andres Carreño','Calle 80','10');

-- Empleado
INSERT INTO Empleado (id_empleado, em_identificacion, em_nombres)
VALUES (NULL,'1099489764','Ana Mendoza');
INSERT INTO Empleado (id_empleado, em_identificacion, em_nombres)
VALUES (NULL,'1089332764','Esteban Carrillo');
INSERT INTO Empleado (id_empleado, em_identificacion, em_nombres)
VALUES (NULL,'1079897633','David Tellez');
INSERT INTO Empleado (id_empleado, em_identificacion, em_nombres)
VALUES (NULL,'1099489342','Valeria Mantilla');
INSERT INTO Empleado (id_empleado, em_identificacion, em_nombres)
VALUES (NULL,'1087489764','Javier Espinosa');
INSERT INTO Empleado (id_empleado, em_identificacion, em_nombres)
VALUES (NULL,'1054489464','Julian Barrera');
INSERT INTO Empleado (id_empleado, em_identificacion, em_nombres)
VALUES (NULL,'1023948976','Juliana Ferreira');
INSERT INTO Empleado (id_empleado, em_identificacion, em_nombres)
VALUES (NULL,'1069478724','Francisco Espinel');
INSERT INTO Empleado (id_empleado, em_identificacion, em_nombres)
VALUES (NULL,'1089489237','Karla Mendoza');
INSERT INTO Empleado (id_empleado, em_identificacion, em_nombres)
VALUES (NULL,'1068989732','Camilo Torres');

-- Facturas
INSERT INTO Facturas (id_factura, fk_pedido, fc_fecha)
VALUES (NULL,'1','04/07/2022');
INSERT INTO Facturas (id_factura, fk_pedido, fc_fecha)
VALUES (NULL,'2','08/07/2022');
INSERT INTO Facturas (id_factura, fk_pedido, fc_fecha)
VALUES (NULL,'3','12/08/2022');
INSERT INTO Facturas (id_factura, fk_pedido, fc_fecha)
VALUES (NULL,'4','15/08/2022');
INSERT INTO Facturas (id_factura, fk_pedido, fc_fecha)
VALUES (NULL,'5','20/08/2022');
INSERT INTO Facturas (id_factura, fk_pedido, fc_fecha)
VALUES (NULL,'6','22/08/2022');
INSERT INTO Facturas (id_factura, fk_pedido, fc_fecha)
VALUES (NULL,'7','24/08/2022');
INSERT INTO Facturas (id_factura, fk_pedido, fc_fecha)
VALUES (NULL,'8','15/09/2022');
INSERT INTO Facturas (id_factura, fk_pedido, fc_fecha)
VALUES (NULL,'9','18/09/2022');
INSERT INTO Facturas (id_factura, fk_pedido, fc_fecha)
VALUES (NULL,'10','30/09/2022');

-- Facturas pagos
INSERT INTO Facturas_pagos (id_factura_pago, fk_factura, fc_valor_pago, fc_forma_de_pago, fc_fecha_hora)
VALUES (NULL,'1','1200','Efectivo','04/07/2022');
INSERT INTO Facturas_pagos (id_factura_pago, fk_factura, fc_valor_pago, fc_forma_de_pago, fc_fecha_hora)
VALUES (NULL,'2','1500','Efectivo','07/07/2022');
INSERT INTO Facturas_pagos (id_factura_pago, fk_factura, fc_valor_pago, fc_forma_de_pago, fc_fecha_hora)
VALUES (NULL,'3','1800','Efectivo','12/07/2022');
INSERT INTO Facturas_pagos (id_factura_pago, fk_factura, fc_valor_pago, fc_forma_de_pago, fc_fecha_hora)
VALUES (NULL,'4','2500','Efectivo','16/07/2022');
INSERT INTO Facturas_pagos (id_factura_pago, fk_factura, fc_valor_pago, fc_forma_de_pago, fc_fecha_hora)
VALUES (NULL,'5','3000','Efectivo','24/07/2022');
INSERT INTO Facturas_pagos (id_factura_pago, fk_factura, fc_valor_pago, fc_forma_de_pago, fc_fecha_hora)
VALUES (NULL,'6','4500','Tarjeta','27/07/2022');
INSERT INTO Facturas_pagos (id_factura_pago, fk_factura, fc_valor_pago, fc_forma_de_pago, fc_fecha_hora)
VALUES (NULL,'7','5000','Tarjeta','02/08/2022');
INSERT INTO Facturas_pagos (id_factura_pago, fk_factura, fc_valor_pago, fc_forma_de_pago, fc_fecha_hora)
VALUES (NULL,'8','5500','Tarjeta','06/08/2022');
INSERT INTO Facturas_pagos (id_factura_pago, fk_factura, fc_valor_pago, fc_forma_de_pago, fc_fecha_hora)
VALUES (NULL,'9','7800','Tarjeta','15/08/2022');
INSERT INTO Facturas_pagos (id_factura_pago, fk_factura, fc_valor_pago, fc_forma_de_pago, fc_fecha_hora)
VALUES (NULL,'10','8800','Tarjeta','20/08/2022');

-- Transportadoras

insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('1','ecopetrol','carrera 7 #6 -08', '2')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('2','exito','carrera 7 #1 -07', '3')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('3','terpel','carrera 7 #6 -07', '4')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('4','EPM','carrera 5 #6 -07', '5')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('5','Avianca','carrera 8 #6 -07', '6')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('6','Argo','carrera 2 #6 -07', '7')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('7','Nutresa','carrera 2 #6 -07', '8')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('8','BlackBox','carrera 5 #6 -07', '9')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('9','Claro','carrera 76 #6 -8', '10')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('10','IBM','carrera 77 #6 -07', '11')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('11','Riot','carrera 75 #6 -07', '12')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('12','Nueva EPS','carrera 7 #6 -08', '13')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('13','Primax','carrera 76 #6 -07', '14')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('14','Movistar','carrera 14 #6 -07', '15')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('15','ENEL','carrera 45 #6 -07', '16')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('16','Discord','carrera 16 #6 -07', '17')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('17','Visual','carrera 20 #6 -07', '18')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('18','Olimpica','carrera 54 #6 -07', '19')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('19','ISA','carrera 88 #6 -07', '20')
insert into transportadoras (id_transportadoras, tr_empresa, tr_dirreccion,fk_id_municipio)
values ('20','Cerrejon','carrera 99 #6 -07', '21')

-- municipios

insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('1','Floridablanca','1001','Centro Florida','101')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('2','Bogota','1002','Centro Bogota','102')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('3','Medellin','1003','Centro Medellin','103')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('4','Cali','1004','Centro Cali','104')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('5','Barraquilla','1005','Centro Barraquilla','105')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('6','Cartagena','1006','Centro Cartagena','106')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('7','Soacha','1007','Centro Soacha','107')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('8','Cucuta','1008','Centro Cucuta','108')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('9','Soledad','1009','Centro Soledad','109')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('10','Bucarramanga','10010','Centro Bucarramanga','110')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('11','Bello','10011','Centro Bello','111')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('12','Villavicencio','10012','Centro Villavicencio','112')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('13','Santa Marta','10013','Centro Santa Marta','113')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('14','Valledupar','10014','Centro Valledupar','114')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('15','Ibague','10015','Centro Ibague','115')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('16','Monteria','10016','Centro Monteria','116')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('17','Pereira','10017','Centro Pereira','117')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('18','Manizales','10018','Centro Manizales','118')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('19','Pasto','10019','Centro Pasto','119')
insert into municipios (id_municipio,mu_municipio,fk_id_departamento,mu_capital,mu_cod_divipola_municipop)
values ('20','Neiva','1020','Centro Neiva','120')

-- Departamentos

insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('1','Amazonas','2001')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('2','Antioqui','2002')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('3','Atlantico','2003')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('4','Arauca','2004')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('5','Bogotá','2005')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('6','Bolivar','2006')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('7','Boyaca','2007')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('8','Caldas','2008')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('9','Caqueta','2009')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('10','Cauca','20010')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('11','Cesar','20011')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('12','Choco','20012')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('13','Cordoba','20013')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('14','Cundinamarca','20014')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('15','Guainia','20015')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('16','Guaviare','20016')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('17','Huila','20088')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('18','La Guajira','20017')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('19','Magdanela','20018')
insert into departamentos (id_departamento, de_departamento, de_cod_divipola)
values ('20','Meta','20019')

-- Bodegas

insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('1','carrera 6 #15','1')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('2','carrera 6 #100','2')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('3','carrera 6 #17','3')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('4','carrera 6 #11','4')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('5','carrera 6 #12','5')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('6','carrera 6 #13','6')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('7','carrera 6 #17','7')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('8','carrera 6 #16','8')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('9','carrera 6 #144','9')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('10','carrera 6 #155','10')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('11','carrera 6 #155','11')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('13','carrera 6 #166','13')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('14','carrera 6 #177','14')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('15','carrera 6 #188','15')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('16','carrera 6 #199','16')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('17','carrera 6 #198','17')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('18','carrera 6 #196','18')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('19','carrera 6 #175','19')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('20','carrera 6 #184','20')
insert into bodegas (id_bodegas,bo_direccion,fk_id_municipio)
values ('21','carrera 6 #152','21')

-- Bodegas Procutos

insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('1','1','1','15')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('2','2','1','145')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('3','3','1','14')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('4','4','4','55')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('5','5','5','82')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('6','6','6','56')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('7','7','7','44')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('8','8','8','5')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('9','9','9','52')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('10','10','10','33')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('11','11','11','11')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('12','12','12','665')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('13','13','13','78')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('14','14','14','12')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('15','15','15','110')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('16','16','16','10')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('17','17','17','150')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('18','18','18','154')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('19','19','19','159')
insert into bodegas_productos (id_bodegas_productos,fk_id_bodega,fk_id_productos,bopr_cantidad)
values ('20','20','20','157')

-- Productos

insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('1','perfumes', 'caja','2')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('2','limpiante', 'Bolsa','1020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('3','perfumes', 'caja','4020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('4','ceras', 'Bolsa','3020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('5','Vodka', 'caja','6020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('6','Licor', 'caja','5020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('7','perfumes', 'caja','8020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('8','Fragancia', 'Bolsa','7020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('9','Budines', 'caja','10020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('10','Aperitivos', 'caja','9020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('11','Caramelos', 'caja','12020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('12','Barras de cereal', 'caja','11020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('13','Ceras', 'Bolsa','14020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('15','Bebidas blancas', 'caja','13020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('16','Rotiseria', 'caja','17020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('18','Apresados', 'Bolsa','1620')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('19','Leches', 'caja','2020')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('20','Quitamanchas', 'caja','1920')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('17','Goma de mascar', 'Bolsa','2120')
insert into productos (id_productos, pro_productos, pro_descripcion, pro_valor)
values ('21','After Shave', 'caja','1720')

-- Productos Caracteristicas

insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('1','11','Sin caja', 'Goma de mascar')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('2','12','Con caja', 'Apresados')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('3','13','Sin bolsa', 'Bebidas blancas')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('4','14','Sin caja', 'Bebidas')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('5','15','Con bolsa', 'Vodka')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('6','16','Sin caja', 'Miel')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('7','17','Con bolsa', 'Vinagre')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('8','18','Sin caja', 'Guantesr')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('9','19','Con caja', 'Legumbres')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('10','10','Sin bolsa', 'Polvo')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('11','111','Sin caja', 'Polvo Gelat')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('12','122','Sin caja', 'Postre')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('13','133','Con bolsa', 'Flan')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('14','144','Sin caja', 'Jabon')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('15','155','Sin bolsa', 'Jabon de manos')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('16','166','Sin caja', 'Jabon para cuerpo')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('17','177','Sin bolsa', 'Atun')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('18','188','Sin caja', 'Mantecas')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('19','199','Con caja', 'Milanesa')
insert into productos_caracteristiacas (id_productos_caracteristicas,fk_id_productos,proca_caracteristicas,proca_descripcion)
values ('20','100','Sin bolsa', 'Pezcado')

-- Tipos de movimiento

insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('1','Carro','Fase 2' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('2','Camioneta','Fase 2' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('3','Carro','Fase 5' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('4','Moto','Fase 1' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('5','Camioneta','Fase 3' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('6','Carro','Fase 4' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('7','Moto','Fase 2' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('8','Avion','Fase 5' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('9','Camioneta','Fase 1' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('10','Carro','Fase 5' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('11','Avion','Fase 4' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('12','Moto','Fase 1' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('13','Carro','Fase 3' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('14','Moto','Fase 1' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('15','Avion','Fase 4' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('16','Carro','Fase 5' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('17','Carro','Fase 5' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('18','Avion','Fase 4' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('19','Carro','Fase 4' )
insert into tipos_movimiento (id_tipos_movimientos, timo_descripcion, timo_tipo_movimiento)
values ('20','Avion','Fase 1' )


