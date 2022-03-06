use Vuelos_BD

create table aereopuerto
(
codigo_aero			varchar(3)		not null primary key,
nombre_aero			varchar(20)		not null,
ciudad_aero			varchar(15)		not null,
pais_aero			varchar(20)		not null,
CHECK (codigo_aero like 'a[0-9][0-9]')
)
go

insert into aereopuerto values('a15','Sant Luis','Lima','Peru');
insert into aereopuerto values('a23','Carvanha','Berlin','Alemania');
insert into aereopuerto values('a43','Sant Loana','Buenos Aires','Argentina');
insert into aereopuerto values('a83','Onichan','Tokyo','Japon');
go

select*from aereopuerto

SELECT codigo_aero AS CODIGO, nombre_aero AS NOMBRE  , ciudad_aero AS APELLIDO , pais_aero AS PAIS FROM aereopuerto 
WHERE codigo_aero IN ('a15','a23','a83')
GO

create table avion
(
Modelo_avion		varchar(25)		not null primary key,
capacidad_avion		int				not null,
codigo_aero			varchar(3)		not null references aereopuerto,
Fecha_compra		date				null
)
go

insert into avion values('Airbus 330',580,'a15','1995-8-25');
insert into avion values('Boeing 737',840,'b23','1863-4-13');
insert into avion values('Boeing 747',750,'t43','1981-3-8');
insert into avion values('Airbus 320',960,'y83','2000-10-14');
go

select*from avion

create table vuelo
(
Nvuelo_vuelo			int			not null primary key,
plazas_vuelo			int			not null,
fecha_vuelo				date		not null,
Modelo_avion			varchar(25)	not null  references avion
)
go

insert into vuelo values(2580,580,'2021-10-01','Airbus 330');
insert into vuelo values(7890,840,'2021-12-25','Boeing 737');
insert into vuelo values(1520,750,'2022-4-14','Boeing 747');
insert into vuelo values(8412,960,'2022-6-16','Airbus 320');
go

select*from vuelo

create table Programa_vuelo
(
N_Programa_PV		char(3)			not null primary key,
Modelo_avion		varchar(25)		not null references avion,
Dias_PV				int				not null,
Escala_PV			char(2)			null,
codigo_aero			varchar(3)		not null references aereopuerto
)
go

insert into Programa_vuelo values('123','Airbus 330',15,'2','a15');
insert into Programa_vuelo values('754','Boeing 737',35,'1','b23');
insert into Programa_vuelo values('698','Boeing 747',40,'3','t43');
insert into Programa_vuelo values('453','Airbus 320',32,'4','y83');
go

select*from Programa_vuelo


create table piloto
(
Nombre_piloto		varchar(20)		not null,
Cod_piloto			varchar(3)		not null,
correo_pilot		varchar(60)		CONSTRAINT correo UNIQUE,
Nvuelo_vuelo		int				not null references vuelo,
N_Programa_PV		char(3)			not null references Programa_vuelo,
codigo_aero			varchar(3)		not null references aereopuerto,
primary key(Nombre_piloto,Cod_piloto)
)
go

ALTER TABLE piloto ADD  CONSTRAINT CH_SEXO CHECK(Sex_piloto='F' or Sex_piloto='M' )

insert into piloto values('Juan Luis','j45',2580,'123','a15');
insert into piloto values('Roberto Carlos','r74',7890,'754','b23');
insert into piloto values('Julio Matias','j12',1520,'698','t43');
insert into piloto values('Eduardo','e96',8412,'453','y83');
go


select*from piloto

create table escalas
(
Numer_escalas		char(5)			not null,
Nvuelo_vuelo		int				not null references vuelo,
N_Programa_PV		char(3)			not null references Programa_vuelo,
codigo_aero			varchar(3)		not null references aereopuerto,
Pasajeros_escalas	int				not null
primary key(Numer_escalas,Pasajeros_escalas)
)
go

insert into escalas values('a785',2580,'123','a15',785);
insert into escalas values('r521',7890,'754','b23',956);
insert into escalas values('t348',1520,'698','t43',743);
insert into escalas values('g755',8412,'453','y83',520);
go

select*from escalas