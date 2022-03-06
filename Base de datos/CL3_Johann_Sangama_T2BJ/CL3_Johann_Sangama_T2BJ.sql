--ABRIENDO LA BASE DE DATOS DEL SISTEMA
USE MASTER
GO


--VALIDAR LA BASE DE DATOS
IF DB_ID('BD_FARMACIA') IS NOT NULL
DROP DATABASE BD_FARMACIA
GO


--CREANDO LA BASE DE DATOS
CREATE DATABASE BD_FARMACIA
GO


--ABRIENDO LA BASE DE DATOS
USE BD_FARMACIA
GO


/*******************************************************************************************************/


--CREANDO TABLAS Y VALIDANDO

--TABLA DISTRITO
IF OBJECT_ID ('DISTRITO') IS NOT NULL
BEGIN
DROP TABLE DISTRITO
END 
CREATE TABLE DISTRITO( 
	CodUbigeo		char(8)		NOT NULL	PRIMARY KEY,
	Descripcion		varchar(80)	NOT NULL)
GO


--TABLA FARMACIA
IF OBJECT_ID ('FARMACIA') IS NOT NULL
BEGIN
DROP TABLE FARMACIA
END 
CREATE TABLE FARMACIA( 
	CodFarmacia	char(8)			NOT NULL	PRIMARY KEY,
	RazonSocial	varchar(50)		NOT NULL,
	Direccion	varchar(150)	NOT NULL,
	Telefono	varchar(15)		NOT NULL,
	CodUbigeo	char(8)			NOT NULL	REFERENCES DISTRITO)
GO


--TABLA CARGO
IF OBJECT_ID ('CARGO') IS NOT NULL
BEGIN
DROP TABLE CARGO
END 
CREATE TABLE CARGO( 
	CodCargo		char(8)		NOT NULL	PRIMARY KEY,
	Descripcion		varchar(80)	NOT NULL)
GO


--TABLA EMPLEADO
IF OBJECT_ID ('EMPLEADO') IS NOT NULL
BEGIN
DROP TABLE EMPLEADO
END 
CREATE TABLE EMPLEADO( 
	CodEmpleado	char(8)			NOT NULL	PRIMARY KEY,
	Nombres		varchar(50)		NOT NULL,
	Apellidos	varchar(100)	NOT NULL,
	CodCargo	char(8)			NOT NULL	REFERENCES CARGO,
	CodFarmacia	char(8)			NOT NULL	REFERENCES FARMACIA,
	DNI			integer			NOT NULL,
	Telefono	varchar(15)		NOT NULL,
	Email		varchar(100)	NULL,
	Direccion	varchar(150)	NOT NULL,
	CodUbigeo	char(8)			NOT NULL	REFERENCES DISTRITO)
GO


--TABLA CLIENTE
IF OBJECT_ID ('CLIENTE') IS NOT NULL
BEGIN
DROP TABLE CLIENTE
END 
CREATE TABLE CLIENTE( 
	CodCliente		char(8)			NOT NULL	PRIMARY KEY,
	Nombres			varchar(50)		NOT NULL,
	Apellidos		varchar(100)	NOT NULL,
	DNI				integer				NOT NULL,
	RUC				varchar(11)		NULL,
	Telefono		varchar(15)		NOT NULL,
	Email			varchar(100)	NULL,
	Direccion		varchar(150)	NOT NULL,
	CodUbigeo		char(8)			NOT NULL	REFERENCES DISTRITO)
GO


--TABLA DISTRIBUIDORA
IF OBJECT_ID ('DISTRIBUIDORA') IS NOT NULL
BEGIN
DROP TABLE DISTRIBUIDORA
END 
CREATE TABLE DISTRIBUIDORA( 
	CodDistribuidora	char(8)			NOT NULL	PRIMARY KEY,
	RazonSocial			varchar(50)		NOT NULL,
	RUC					varchar(11)		NOT NULL,
	Tipo				varchar(50)		NOT NULL,
	Telefono			varchar(15)		NOT NULL,
	Email				varchar(100)	NULL,
	Direccion			varchar(150)	NOT NULL,
	CodUbigeo			char(8)			NOT NULL	REFERENCES DISTRITO)
GO


--TABLA CONTACTO
IF OBJECT_ID ('CONTACTO') IS NOT NULL
BEGIN
DROP TABLE CONTACTO
END 
CREATE TABLE CONTACTO(
	CodDistribuidora	char(8)			NOT NULL	REFERENCES DISTRIBUIDORA,
	CodContacto			char(8)			NOT NULL,
	Nombre				varchar(50)		NOT NULL,
	Cargo				varchar(50)		NOT NULL,
	Telefono			varchar(15)		NOT NULL,
	Email				varchar(100)	NULL,
	PRIMARY KEY (CodDistribuidora, CodContacto))
GO


--TABLA PROVEEDOR
IF OBJECT_ID ('PROVEEDOR') IS NOT NULL
BEGIN
DROP TABLE PROVEEDOR
END 
CREATE TABLE PROVEEDOR( 
	CodDistribuidora	char(8)		NOT NULL REFERENCES DISTRIBUIDORA,
	PRIMARY KEY (CodDistribuidora))
GO


--TABLA MARCA
IF OBJECT_ID ('MARCA') IS NOT NULL
BEGIN
DROP TABLE MARCA
END 
CREATE TABLE MARCA( 
	CodMarca	char(8)		NOT NULL	PRIMARY KEY,
	Descripcion	varchar(80)	NULL)
GO


--TABLA CATEGORIA
IF OBJECT_ID ('CATEGORIA') IS NOT NULL
BEGIN
DROP TABLE CATEGORIA
END 
CREATE TABLE CATEGORIA( 
	CodCategoria	char(8)		NOT NULL	PRIMARY KEY,
	Descripcion		varchar(80)	NOT NULL)
GO


--TABLA PRESENTACION_ESTANDAR
IF OBJECT_ID ('PRESENTACION_ESTANDAR') IS NOT NULL
BEGIN
DROP TABLE PRESENTACION_ESTANDAR
END 
CREATE TABLE PRESENTACION_ESTANDAR( 
	CodPresentacion	char(8)	NOT NULL	PRIMARY KEY,
	Descripcion		varchar(80)	NULL)
GO


--TABLA PRESENTACION
IF OBJECT_ID ('PRESENTACION') IS NOT NULL
BEGIN
DROP TABLE PRESENTACION
END 
CREATE TABLE PRESENTACION( 
	CodPresentacion	char(8)	NOT NULL	PRIMARY KEY,
	Descripcion	varchar(80)	NULL)
GO


--TABLA LABORATORIO
IF OBJECT_ID ('LABORATORIO') IS NOT NULL
BEGIN
DROP TABLE LABORATORIO
END 
CREATE TABLE LABORATORIO( 
	CodDistribuidora	char(8)	NOT NULL	REFERENCES DISTRIBUIDORA,
	PRIMARY KEY (CodDistribuidora))
GO


--TABLA MEDICAMENTO
IF OBJECT_ID ('MEDICAMENTO') IS NOT NULL
BEGIN
DROP TABLE MEDICAMENTO
END 
CREATE TABLE MEDICAMENTO( 
	CodMedicamento			char(8)			NOT NULL	PRIMARY KEY,
	CodMarca				char(8)			NULL		REFERENCES MARCA,
	Compuesto				varchar(150)	NULL,
	CodCategoria			char(8)			NULL		REFERENCES CATEGORIA,
	PresentacionEstandar	char(8)			NOT NULL	REFERENCES PRESENTACION_ESTANDAR,
	Precio					money			NULL,
	FechaVencimiento		date			NULL,
	StockActual				integer			NULL,
	CodLaboratorio			char(8)			NOT NULL	REFERENCES LABORATORIO,
	CodDistribuidora		char(8)			NULL		REFERENCES DISTRIBUIDORA,
	Factor					integer			NULL,
	CodPresentacion			char(8)			NULL		REFERENCES PRESENTACION)
GO


--TABLA BOLETA
IF OBJECT_ID ('BOLETA') IS NOT NULL
BEGIN
DROP TABLE BOLETA
END 
CREATE TABLE BOLETA( 
	NroBoleta		char(8)	NOT NULL	PRIMARY KEY,
	Fecha			date	NOT NULL,
	CodEmpleado		char(8)	NOT NULL	REFERENCES EMPLEADO,
	CodCliente		char(8)	NOT NULL	REFERENCES CLIENTE,
	SubTotal		money	NULL,
	IGV				money	NULL,
	Total			money	NULL)
GO


--TABLA DETALLE_BOLETA
IF OBJECT_ID ('DETALLE_BOLETA') IS NOT NULL
BEGIN
DROP TABLE DETALLE_BOLETA
END 
CREATE TABLE DETALLE_BOLETA( 
	NroBoleta		char(8)	NOT NULL	REFERENCES BOLETA,
	CodMedicamento	char(8)	NOT NULL	REFERENCES MEDICAMENTO,
	Cantidad		integer	NOT NULL,
	Importe			money	NOT NULL,
	PrecioVenta		money	NOT NULL,
	PRIMARY KEY (NroBoleta, CodMedicamento))
GO


/*******************************************************************************************************/


--INSERTANDO REGISTROS

--INSERTAR REGISTROS A LA TABLA CATEGORIAS --Inserción individual
INSERT INTO DISTRITO VALUES ('150121', 'MAGDALENA VIEJA');
INSERT INTO DISTRITO VALUES ('150128', 'RIMAC');
INSERT INTO DISTRITO VALUES ('150129', 'SAN BARTOLO');
INSERT INTO DISTRITO VALUES ('150130', 'SAN BORJA');
INSERT INTO DISTRITO VALUES ('150143', 'VILLA MARIA DEL TRIUNFO');
INSERT INTO DISTRITO VALUES ('150101', 'LIMA');
INSERT INTO DISTRITO VALUES ('150108', 'CHORRILLOS');
INSERT INTO DISTRITO VALUES ('150110', 'COMAS');
INSERT INTO DISTRITO VALUES ('150117', 'LOS OLIVOS');
INSERT INTO DISTRITO VALUES ('150112', 'INDEPENDENCIA');
INSERT INTO DISTRITO VALUES ('150114', 'LA MOLINA');
INSERT INTO DISTRITO VALUES ('150106', 'CARABAYLLO');
INSERT INTO DISTRITO VALUES ('150104', 'BARRANCO');
INSERT INTO DISTRITO VALUES ('150113', 'JESUS MARIA');
INSERT INTO DISTRITO VALUES ('150119', 'LURIN');
INSERT INTO DISTRITO VALUES ('150133', 'SAN JUAN DE MIRAFLORES');
INSERT INTO DISTRITO VALUES ('150124', 'PUCUSANA');
INSERT INTO DISTRITO VALUES ('150138', 'SANTA MARIA DEL MAR');
INSERT INTO DISTRITO VALUES ('150102', 'ANCON');
INSERT INTO DISTRITO VALUES ('150105', 'BREÑA');
INSERT INTO DISTRITO VALUES ('150111', 'EL AGUSTINO');
INSERT INTO DISTRITO VALUES ('150136', 'SAN MIGUEL');
INSERT INTO DISTRITO VALUES ('150103', 'ATE');
INSERT INTO DISTRITO VALUES ('150109', 'CIENEGUILLA');
INSERT INTO DISTRITO VALUES ('150116', 'LINCE');
INSERT INTO DISTRITO VALUES ('150120', 'MAGDALENA DEL MAR');
INSERT INTO DISTRITO VALUES ('150137', 'SANTA ANITA');
INSERT INTO DISTRITO VALUES ('150139', 'SANTA ROSA');
INSERT INTO DISTRITO VALUES ('150140', 'SANTIAGO DE SURCO');
INSERT INTO DISTRITO VALUES ('150134', 'SAN LUIS');
INSERT INTO DISTRITO VALUES ('150107', 'CHACLACAYO');
INSERT INTO DISTRITO VALUES ('150132', 'SAN JUAN DE LURIGANCHO');
INSERT INTO DISTRITO VALUES ('150135', 'SAN MARTIN DE PORRES');
INSERT INTO DISTRITO VALUES ('150142', 'VILLA EL SALVADOR');
INSERT INTO DISTRITO VALUES ('150118', 'LURIGANCHO');
INSERT INTO DISTRITO VALUES ('150115', 'LA VICTORIA');
INSERT INTO DISTRITO VALUES ('150123', 'PACHACAMAC');
INSERT INTO DISTRITO VALUES ('150131', 'SAN ISIDRO');
INSERT INTO DISTRITO VALUES ('150141', 'SURQUILLO');
INSERT INTO DISTRITO VALUES ('150125', 'PUENTE PIEDRA');
INSERT INTO DISTRITO VALUES ('150127', 'PUNTA NEGRA');
INSERT INTO DISTRITO VALUES ('150126', 'PUNTA HERMOSA');
INSERT INTO DISTRITO VALUES ('150122', 'MIRAFLORES');

SELECT * FROM DISTRITO;


--INSERTAR REGISTROS A LA TABLA FARMACIA --Inserción individual
INSERT INTO FARMACIA VALUES ('20201001', 'Inka Salud', 'Av. Los Incas Mz.Q Lte.17', '723-6457', '150108');
INSERT INTO FARMACIA VALUES ('20201002', 'Salud Farma', 'Antero Aspillaga 172', '745-2136', '150131');
INSERT INTO FARMACIA VALUES ('20201003', 'Farma Vida', 'Conde Castelar 140', '375-9916', '150140');

SELECT * FROM FARMACIA;


--INSERTAR REGISTROS A LA TABLA CARGO --Inserción individual
INSERT INTO CARGO VALUES ('10', 'Administrador');
INSERT INTO CARGO VALUES ('11', 'Farmaceutico');
INSERT INTO CARGO VALUES ('12', 'Cajero');

SELECT * FROM CARGO;


--INSERTAR REGISTROS A LA TABLA EMPLEADO --Inserción individual
INSERT INTO EMPLEADO VALUES ('10001', 'Franz Alberto', 'Quispe Huerta', '10', '20201001', 74311335, '950-063-214', 'franzquispe@gmail.com', 'Av. Los Incas 142', '150108');
INSERT INTO EMPLEADO VALUES ('10002', 'Alejandro Hanz', 'Hidalgo Seguil', '11', '20201001', 96532148, '986-454-475', 'alejandrodid@gmail.com', 'Av. Guardia Civil 402', '150108');
INSERT INTO EMPLEADO VALUES ('10003', 'Alexandra Juana', 'Huertas Ramírez', '12', '20201001', 78546219, '985-637-458', 'alexaj@gmail.com', 'Av. Guardia Peruana 120', '150108');
INSERT INTO EMPLEADO VALUES ('10004', 'Frank Carlos', 'Ramos Chiclla', '12', '20201002', 48596321, '978-856-632', 'frankcar@gmail.com', 'Residencial La Cruceta 150', '150140');
INSERT INTO EMPLEADO VALUES ('10005', 'Juana  Karla', 'Palacios Rivera', '11', '20201002', 35962147, '912-345-689', 'juanakl@gmail.com', 'Jr. Carlos Aguirre 125', '150140');
INSERT INTO EMPLEADO VALUES ('10006', 'Flavia Rin', 'Rivera Pituy', '10', '20201002', 96532875, '958-674-481', 'rinf@gmail.com', 'Puerto Chicama 740', '150108');

SELECT * FROM EMPLEADO;


--INSERTAR REGISTROS A LA TABLA CLIENTE --Inserción individual
INSERT INTO CLIENTE VALUES ('CLI001', 'Juan Carlos', 'Lariena Vasquez', 75869421, '10401002133', '942-563-875', 'juanLariena@gmail.com', 'Av. Las Gaviotas 120', '150108');
INSERT INTO CLIENTE VALUES ('CLI002', 'Alexa Flavia', 'Tuya Apaza', 45621379, '17658684127', '968-547-256', 'alexatuya@gmail.com', 'Jirón Tacna 420', '150140');
INSERT INTO CLIENTE VALUES ('CLI003', 'Marcos Ramiro', 'Vidarte Rodriguez', 45869871, '16851536987', '968-536-985', 'marcosvidarte@gmail.com', 'Av. Los Bicus 520', '150140');
INSERT INTO CLIENTE VALUES ('CLI004', 'Julia María', 'RodriGuez Palma', 35698748, '18980245298', '978-541-236', 'juliarodriquez@gmail.com', 'Av. Surco 740', '150140');
INSERT INTO CLIENTE VALUES ('CLI005', 'María Alejandra', 'Bueno Quispe', 14589678, '15894267815', '985-647-258', 'mariabueno@gmail.com', 'Av. El Sol 450', '150108');

SELECT * FROM CLIENTE;


--INSERTAR REGISTROS A LA TABLA DISTRIBUIDORA --Inserción individual
INSERT INTO DISTRIBUIDORA VALUES ('DIS01', 'HERSIL S.A.', '20487579878', 'Laboratorio', 2523438, 'informes@drogueriadicar.com.pe', 'Av. Los Frutales 220', '150103');
INSERT INTO DISTRIBUIDORA VALUES ('DIS02', 'BAYER S.A.', '26587815963', 'Laboratorio', 994616327, 'www.distribuidorespyg.com',	'Paseo de la República 3074, Piso 10', '150131');
INSERT INTO DISTRIBUIDORA VALUES ('DIS03', 'Química Suiza S.A.', '24982604857', 'Laboratorio', 912957776, 'www.decorepresentaciones.com', 'Republica de Panamá 2577', '150115');
INSERT INTO DISTRIBUIDORA VALUES ('DIS04', 'Drogueria Dicar S.A.C', '22984563289', 'Proveedor', 2523438, 'informes@drogueriadicar.com.pe', 'Av. Guardia Peruana 1465, Chorrillos', '150108');
INSERT INTO DISTRIBUIDORA VALUES ('DIS05', 'P&G DISTRIBUIDORES SRL', '23698719605', 'Proveedor', 994616327, 'www.distribuidorespyg.com', 'Cl. Añaquito 169 B, Lima', '150101');
INSERT INTO DISTRIBUIDORA VALUES ('DIS06', 'REPRESENTACIONES DECO SAC', '21986508719', 'Proveedor', 912957776, 'www.decorepresentaciones.com', 'Santiago de Surco 15023', '150140');

SELECT * FROM DISTRIBUIDORA;


--INSERTAR REGISTROS A LA TABLA CONTACTO --Inserción individual
INSERT INTO CONTACTO VALUES ('CON01', 'DIS01', 'Carlos Zegarra', 'Administrador', '745-6895', 'carloszega@gmail.com');
INSERT INTO CONTACTO VALUES ('CON02', 'DIS02', 'Ramiro Rodríguez', 'Administrador', '748-2131', 'ramirorod@gmail.com');
INSERT INTO CONTACTO VALUES ('CON03', 'DIS03', 'Sebastián Tasayco', 'Administrador', '586-9745', 'sebastiantas@gmail.com');

SELECT * FROM CONTACTO;


--INSERTAR REGISTROS A LA TABLA PROVEEDOR --Inserción individual
INSERT INTO PROVEEDOR VALUES ('DIS04');
INSERT INTO PROVEEDOR VALUES ('DIS05');
INSERT INTO PROVEEDOR VALUES ('DIS06');

SELECT * FROM PROVEEDOR;


--INSERTAR REGISTROS A LA TABLA MARCA --Inserción individual
INSERT INTO MARCA VALUES ('CM001', 'Panadol Alergy');
INSERT INTO MARCA VALUES ('CM002', 'Panadol Forte');
INSERT INTO MARCA VALUES ('CM003', 'Panadol Antigripal');
INSERT INTO MARCA VALUES ('CM004', 'Panadol Infantil');
INSERT INTO MARCA VALUES ('CM005', 'Tramadolip');
INSERT INTO MARCA VALUES ('CM006', 'Tramadol Clorhidrato');
INSERT INTO MARCA VALUES ('CM007', 'Aspirina');
INSERT INTO MARCA VALUES ('CM008', 'Aspirina Forte');
INSERT INTO MARCA VALUES ('CM009', 'Cardio Aspirina');
INSERT INTO MARCA VALUES ('CM010', 'Ibuprofeno');
INSERT INTO MARCA VALUES ('CM011', 'Haldol');
INSERT INTO MARCA VALUES ('CM012', 'Valium');
INSERT INTO MARCA VALUES ('CM013', 'Danatrol');
INSERT INTO MARCA VALUES ('CM014', 'Diacomit');
INSERT INTO MARCA VALUES ('CM015', 'Dezaprex');

SELECT * FROM MARCA;


--INSERTAR REGISTROS A LA TABLA CATEGORIA --Inserción individual
INSERT INTO CATEGORIA VALUES ('CA001', 'Analgésicos');
INSERT INTO CATEGORIA VALUES ('CA002', 'Laxantes');
INSERT INTO CATEGORIA VALUES ('CA003', 'Mucolíticos');
INSERT INTO CATEGORIA VALUES ('CA004', 'Antibioticos');
INSERT INTO CATEGORIA VALUES ('CA005', 'Antiinflamatorios');
INSERT INTO CATEGORIA VALUES ('CA006', 'Antiácidos');

SELECT * FROM CATEGORIA;


--INSERTAR REGISTROS A LA TABLA PRESENTACION_ESTANDAR --Inserción individual
INSERT INTO PRESENTACION_ESTANDAR VALUES ('PRE1001', 'Caja x 10 pastillas');
INSERT INTO PRESENTACION_ESTANDAR VALUES ('PRE1002', 'Caja x 30 pastillas');
INSERT INTO PRESENTACION_ESTANDAR VALUES ('PRE1003', 'Caja x 50 pastillas');
INSERT INTO PRESENTACION_ESTANDAR VALUES ('PRE1004', 'Botella 100ml');
INSERT INTO PRESENTACION_ESTANDAR VALUES ('PRE1005', 'Botella 120ml');
INSERT INTO PRESENTACION_ESTANDAR VALUES ('PRE1006', 'Botella 150ml');

SELECT * FROM PRESENTACION_ESTANDAR;


--INSERTAR REGISTROS A LA TABLA PRESENTACION --Inserción individual
INSERT INTO PRESENTACION VALUES ('PRE2001', 'Pastilla');
INSERT INTO PRESENTACION VALUES ('PRE2002', 'Tableta');
INSERT INTO PRESENTACION VALUES ('PRE2003', 'Capsula');

SELECT * FROM PRESENTACION;


--INSERTAR REGISTROS A LA TABLA LABORATORIO --Inserción individual
INSERT INTO LABORATORIO VALUES ('DIS01');
INSERT INTO LABORATORIO VALUES ('DIS02');
INSERT INTO LABORATORIO VALUES ('DIS03');

SELECT * FROM LABORATORIO;


--INSERTAR REGISTROS A LA TABLA MEDICAMENTO --Inserción individual
INSERT INTO MEDICAMENTO VALUES ('MED001', 'CM001', 'Paracetamol (Acetaminofén) 500 mg. + Clorhidrato de fenilefrina 5 mg. + Dextrometorfano HBr 15 mg.', 'CA001', 'PRE1001', 100.00, '2020-12-30', 100, 'DIS01', 'DIS01', 30, 'PRE2001');
INSERT INTO MEDICAMENTO VALUES ('MED002', 'CM002', '500 mg de paracetamol. + 65 mg de cafeína.', 'CA001', 'PRE1001', 150.00, '2020-12-30', 100, 'DIS01', 'DIS02', 30, 'PRE2001');
INSERT INTO MEDICAMENTO VALUES ('MED003', 'CM003', 'Paracetamol (Acetaminofén) 500 mg + Clorhidrato de fenilefrina 5 mg + Dextrometorfano HBr 15 mg + Maleato de clorfeniramina 2 mg + Excipientes c.s.', 'CA001', 'PRE1002', 140.00, '2020-12-30', 100, 'DIS02', 'DIS03', 50, 'PRE2002');
INSERT INTO MEDICAMENTO VALUES ('MED004', 'CM004', 'Paracetamol 160 mg.', 'CA002', 'PRE1006', 80.00, '2020-12-30', 100,	'DIS01', 'DIS05', 50, 'PRE2003');
INSERT INTO MEDICAMENTO VALUES ('MED005', 'CM005', 'Por 1 comprimido: Tramadol hidrocloruro , 100.0 mg', 'CA001', 'PRE1001', 125.00, '2020-12-30', 100, 'DIS01', 'DIS05', 30, 'PRE2003');
INSERT INTO MEDICAMENTO VALUES ('MED006', 'CM006', 'Cada tableta revestida contiene tramadol 50,0 mg, lactosa monohidratada 92,0 mg; excipiente cs.', 'CA001', 'PRE1002', 150.00, '2020-12-30', 100, 'DIS03', 'DIS05', 50, 'PRE2003');
INSERT INTO MEDICAMENTO VALUES ('MED007', 'CM007', 'Como principios activos: ácido acetilsalicílico, 400 mg y ácido ascórbico (vitamina C), 240 mg.', 'CA001', 'PRE1002', 155.00, '2020-12-30', 100, 'DIS03', 'DIS01', 30, 'PRE2001');
INSERT INTO MEDICAMENTO VALUES ('MED008', 'CM008', 'Cada comprimido contiene: Acido Acetilsalicílico', 'CA001',	'PRE1001', 150.00, '2020-12-30', 100, 'DIS03', 'DIS03', 30, 'PRE2003');
INSERT INTO MEDICAMENTO VALUES ('MED009', 'CM009', 'Cada comprimido contiene: Acido Acetilsalicílico Microencapsulado 100 mg.', 'CA001', 'PRE1002', 130.00, '2020-12-30', 100, 'DIS02', 'DIS06', 30, 'PRE2002');
INSERT INTO MEDICAMENTO VALUES ('MED010', 'CM010', 'Por 1 comprimido: Alprazolam , 0.5 mg', 'CA001', 'PRE1002', 110.00, '2020-12-30', 100, 'DIS02', 'DIS03', 50, 'PRE2003');

SELECT * FROM MEDICAMENTO;


--INSERTAR REGISTROS A LA TABLA BOLETA --Inserción individual
INSERT INTO BOLETA VALUES ('BOL001', '2019-01-20', '10001', 'CLI001', 150, 150*0.18, 150+(150*0.18));
INSERT INTO BOLETA VALUES ('BOL002', '2019-01-20', '10001', 'CLI002', 100, 100*0.18, 100+(100*0.18));
INSERT INTO BOLETA VALUES ('BOL003', '2019-01-20', '10001', 'CLI003', 140, 140*0.18, 140+(140*0.18));
INSERT INTO BOLETA VALUES ('BOL004', '2019-01-20', '10001', 'CLI004', 80, 80*0.18, 80+(80*0.18));
INSERT INTO BOLETA VALUES ('BOL005', '2019-01-20', '10001', 'CLI005', 150, 150*0.18, 150+(150*0.18));

INSERT INTO BOLETA VALUES ('BOL006', '2019-01-20', '10001', 'CLI001', 150, 150*0.18, 150+(150*0.18));
INSERT INTO BOLETA VALUES ('BOL007', '2019-01-20', '10001', 'CLI002', 300, 300*0.18, 300+(300*0.18));
INSERT INTO BOLETA VALUES ('BOL008', '2019-01-20', '10001', 'CLI003', 280, 2800*0.18, 280+(280*0.18));
INSERT INTO BOLETA VALUES ('BOL009', '2019-01-20', '10001', 'CLI004', 240, 240*0.18, 240+(240*0.18));
INSERT INTO BOLETA VALUES ('BOL0010', '2019-01-20', '10001', 'CLI005', 600, 600*0.18, 600+(600*0.18));

INSERT INTO BOLETA VALUES ('BOL011', '2019-02-20', '10001', 'CLI001', 150, 150*0.18, 150+(150*0.18));
INSERT INTO BOLETA VALUES ('BOL012', '2019-02-20', '10001', 'CLI002', 300, 300*0.18, 300+(300*0.18));
INSERT INTO BOLETA VALUES ('BOL013', '2019-02-20', '10001', 'CLI003', 280, 2800*0.18, 280+(280*0.18));
INSERT INTO BOLETA VALUES ('BOL014', '2019-02-20', '10001', 'CLI004', 240, 240*0.18, 240+(240*0.18));
INSERT INTO BOLETA VALUES ('BOL015', '2019-02-20', '10001', 'CLI005', 600, 600*0.18, 600+(600*0.18));
SELECT * FROM BOLETA;


--INSERTAR REGISTROS A LA TABLA DETALLE_BOLETA --Inserción individual
INSERT INTO DETALLE_BOLETA VALUES('BOL001', 'MED002', 1, 150, 1*150);
INSERT INTO DETALLE_BOLETA VALUES('BOL002', 'MED001', 1, 100, 1*100);
INSERT INTO DETALLE_BOLETA VALUES('BOL003', 'MED003', 1, 140, 1*140);
INSERT INTO DETALLE_BOLETA VALUES('BOL004', 'MED004', 1, 80, 1*80);
INSERT INTO DETALLE_BOLETA VALUES('BOL005', 'MED006', 1, 150, 1*150);

INSERT INTO DETALLE_BOLETA VALUES('BOL006', 'MED002', 2, 150, 2*150);
INSERT INTO DETALLE_BOLETA VALUES('BOL007', 'MED001', 3, 100, 2*100);
INSERT INTO DETALLE_BOLETA VALUES('BOL008', 'MED003', 2, 140, 2*140);
INSERT INTO DETALLE_BOLETA VALUES('BOL009', 'MED004', 3, 80, 3*80);
INSERT INTO DETALLE_BOLETA VALUES('BOL0010', 'MED006', 4, 150, 4*150);

INSERT INTO DETALLE_BOLETA VALUES('BOL011', 'MED002', 2, 150, 2*150);
INSERT INTO DETALLE_BOLETA VALUES('BOL012', 'MED001', 3, 100, 2*100);
INSERT INTO DETALLE_BOLETA VALUES('BOL013', 'MED003', 2, 140, 2*140);
INSERT INTO DETALLE_BOLETA VALUES('BOL014', 'MED004', 3, 80, 3*80);
INSERT INTO DETALLE_BOLETA VALUES('BOL015', 'MED006', 4, 150, 4*150);

SELECT * FROM CLIENTE;


/*******************************************************************************************************/

select  b.Fecha as 'Fecha', m.Compuesto as 'Medicamento', Sum(Cantidad)  as 'Cantidad' from DETALLE_BOLETA db
inner join MEDICAMENTO m on db.CodMedicamento = m.CodMedicamento
inner join BOLETA b on b.NroBoleta = db.NroBoleta
where MONTH(b.Fecha) = 1
group by m.Compuesto, b.Fecha

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
create procedure Registro_Pa

@CodCliente		char(8),
@Nombres		varchar(50),
@Apellidos		varchar(100),
@DNI			int,
@RUC			varchar(11),
@Telefono		varchar(15),
@Email			varchar(100),
@Direccion		varchar(150),
@CodUbigeo		char(8)
as
begin
insert into dbo.CLIENTE
([CodCliente]
,[Nombres]
,[Apellidos]
,[DNI]
,[RUC]
,[Telefono]
,[Email]
,[Direccion]
,[CodUbigeo])

values 
(@CodCliente,@Nombres,@Apellidos,@DNI,@RUC,@Telefono,@Email,@Direccion,@CodUbigeo)

SELECT @@IDENTITY AS REGISTRO_ID
end

/*Actualizar*/
create procedure Upd_Cliente

@CodCliente		char(8),
@Nombres		varchar(50),
@Apellidos		varchar(100),
@DNI			int,
@RUC			varchar(11),
@Telefono		varchar(15),
@Email			varchar(100),
@Direccion		varchar(150),
@CodUbigeo		char(8)
as
begin
update CLIENTE set 	Nombres = @Nombres,
					Apellidos = @Apellidos,
					DNI = @DNI,
					RUC = @RUC,
					Telefono = @Telefono,
					Email = @Email,
					Direccion = @Direccion,
					CodUbigeo = @CodUbigeo
			where CodCliente = @CodCliente
end

exec Upd_Cliente 'CLI009', 'Alexander ', 'Arnold', 76541239, '1076541239', '963456987', 'jalexanderarnold@gmail.com', 'Av. Los rubies 120', '150108'  

select * from CLIENTE

/*Eliminar*/
create procedure dlte_Cliente

@CodCliente		char(8)
as
begin
	delete from CLIENTE where CodCliente = @CodCliente
end

exec dlte_Cliente 'CLI009'

/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

create procedure Ct_Medi
@CodCategoria char(8)
as
begin
	select codCategoria as 'Categoria', SUM(Cantidad) as 'Cantidad de medicamentos' 
	from DETALLE_BOLETA DB inner join MEDICAMENTO M on m.CodMedicamento = db.CodMedicamento 
	where M.CodCategoria = @CodCategoria
	group by codCategoria
end

exec Ct_Medi'CA002'


/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

create procedure Vent_Medi
@CodCategoria char(8),
@Fecha		  datetime
as
begin
	select fecha as 'Fecha', CodEmpleado as 'Codigo del empleado', cl.CodCliente as 'Codigo del cliente', SubTotal as 'Subtotal', IGV as 'IGV', Total as 'Total', Nombres as 'Nombres',
	m.Compuesto as 'Codigo del medicamento', c.CodCategoria as 'Categoria' from CATEGORIA c inner join MEDICAMENTO M on c.CodCategoria = m.CodCategoria
	inner join DETALLE_BOLETA db on m.CodMedicamento = db.CodMedicamento
	inner join BOLETA b on db.NroBoleta = b.NroBoleta
	inner join CLIENTE Cl on b.CodCliente = cl.CodCliente
	where c.CodCategoria = @CodCategoria and year(b.Fecha)= @Fecha 
end

exec Vent_Medi 'CA002',2019

