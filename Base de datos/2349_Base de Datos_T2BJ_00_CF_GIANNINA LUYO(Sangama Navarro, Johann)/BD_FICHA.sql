USE MASTER 
GO

--Creando tablas con archivos primarios, secundarios y  registro de transacciones
IF DB_ID('BD_FICHA') IS NOT NULL
DROP DATABASE BD_FICHA
GO

CREATE DATABASE BD_FICHA
on primary 
(
name = 'FICHA01',
filename = 'D:\ficha\Ficha.mdf',
size = 10MB,
maxsize = 20MB,
filegrowth = 20%
),
(
name = 'FICHA02',
filename = 'D:\ficha\Ficha.ndf',
size = 15MB,
maxsize = 25MB,
filegrowth = 2MB
),
(
name = 'FICHA03',
filename = 'D:\ficha\Ficha.ldf',
size = 20MB,
maxsize = 30MB,
filegrowth = 1MB
)
GO

USE BD_FICHA
GO

/*******************************************************************************************************/

--Tablas 

IF OBJECT_ID ('DOCTOR') IS NOT NULL
BEGIN
DROP TABLE DOCTOR
END 
CREATE TABLE DOCTOR( 
	CodDoctor			char(10)	NOT NULL	PRIMARY KEY,
	NombreDoctor		varchar(10)	NOT NULL,
	EspecialidadDoctor	varchar(20)	NOT NULL,
	SeriviciosDoctor	int
)
GO

--RESTRICCION PARA QUE EL AÑO DE SERVICIO SEA MAYOR A 
alter table dbo.DOCTOR ADD CONSTRAINT CHECK_SeriviciosDoctor CHECK(0 < SeriviciosDoctor)
INSERT INTO DOCTOR VALUES ('253315', 'JUAN', 'Dermatología',-25);


IF OBJECT_ID ('PACIENTE') IS NOT NULL
BEGIN
DROP TABLE PACIENTE
END 
CREATE TABLE PACIENTE( 
	CodPaciente			char(10)		NOT NULL	PRIMARY KEY,
	NombrePaciente		varchar(10)		NOT NULL,
	ApellidoPaciente	varchar(20)		NOT NULL,
	Edad				int,
	DNI					char(8)			NOT NULL,
	DireccionPaciente	varchar(150),
	CodDoctor			char(10)		NOT NULL	REFERENCES DOCTOR,
)
GO
insert into PACIENTE values ('25136', 'ALONSO', 'SANCHEZ',35,'72716175','Jiron los zafiros 2019','253315');

IF OBJECT_ID ('DIAGNOSTICO') IS NOT NULL
BEGIN
DROP TABLE DIAGNOSTICO
END 
CREATE TABLE DIAGNOSTICO( 
	CodDiag				char(10)	NOT NULL	PRIMARY KEY,
	CodDoctor			char(10)    NOT NULL	REFERENCES DOCTOR,
	TipEnfermedad		varchar(20)	NOT NULL,
	Tratamiento			varchar(20)	NOT NULL,
	DuracionTratam				int
)
GO

IF OBJECT_ID ('ANALISIS') IS NOT NULL
BEGIN
DROP TABLE ANALISIS
END 
CREATE TABLE ANALISIS( 
	CodAnalisis				char(10)	NOT NULL	PRIMARY KEY,
	CodPaciente				char(10)    NOT NULL	REFERENCES PACIENTE,
	CodDoctor				char(10)    NOT NULL	REFERENCES DOCTOR,
	TipAnalisis				varchar(20)	NOT NULL,
	Duracion				varchar(20)	NOT NULL,
	Resultado				varchar(20)	NOT NULL,
	FechaAnalisis			date
)
GO

IF OBJECT_ID ('DISTRITO') IS NOT NULL
BEGIN
DROP TABLE DISTRITO
END 
CREATE TABLE DISTRITO( 
	CodDistrito				char(10)	NOT NULL	PRIMARY KEY,
	NombreDistrito			varchar(20)	NOT NULL
)
GO

--CODIGO DISTRITO UNICO
ALTER TABLE dbo.distrito ADD CONSTRAINT UNIQUE_DISTRITO_NombreDistrito UNIQUE(CodDistrito)

INSERT INTO DISTRITO VALUES ('150121', 'MAGDALENA');
INSERT INTO DISTRITO VALUES ('150121', 'SJL');

select * from DISTRITO



IF OBJECT_ID ('FICHA') IS NOT NULL
BEGIN
DROP TABLE FICHA
END 
CREATE TABLE FICHA( 
	CodFicha				char(10)	NOT NULL	PRIMARY KEY,
	TipAnalisis				varchar(20)	NOT NULL,
	CodPaciente				char(10)	NOT NULL REFERENCES PACIENTE,
	Resultado				varchar(20)	NOT NULL,
	CodDistrito				char(10)	NOT NULL REFERENCES DISTRITO,
	fecha					date
)
GO

--RESULTADOS POR DEFECTO
ALTER TABLE dbo.FICHA add CONSTRAINT DEFAULT_FICHA_resultado DEFAULT ('NEGATIVO') for Resultado

INSERT INTO FICHA (CodFicha,TipAnalisis,CodPaciente,CodDistrito,fecha) VALUES ('256312', 'Biometría Hemática','25136','150121','2019-01-20');
select * from FICHA

