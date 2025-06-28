create table Estados_Tarifas (
	id_estado_tarifa int generated always as identity,
	nombre varchar(200) not null,
	constraint id_estado_tarifa_pk primary key (id_estado_tarifa),
	constraint nombre_estado_tarifa_unique unique (nombre)
)

create table Tipos_Tarifas (
	id_tipo_tarifa int generated always as identity,
	nombre varchar(200) not null,
	constraint id_tipo_tarifa_pk primary key (id_tipo_tarifa)
)

create table Estados_Vehiculos (
	id_estado_vehiculo int generated always as identity,
	nombre varchar(200) not null,
	constraint id_estado_vehiculo_pk primary key (id_estado_vehiculo),
	constraint nombre_estado_vehiculo_unique unique (nombre)
)

create table Tipos_Vehiculos (
	id_tipo_vehiculo int generated always as identity,
	nombre varchar(200) not null,
	constraint id_tipo_vehiculo_pk primary key (id_tipo_vehiculo),
	constraint nombre_tipo_vehiculo_unique unique (nombre)
)

create table Tipos_Sucursales (
	id_tipo_sucursal int generated always as identity,
	nombre varchar(200) not null,
	constraint id_tipo_sucursal_pk primary key (id_tipo_sucursal),
	constraint nombre_tipo_sucursal_unique unique (nombre)
)

create table Tipos_Vehiculos (
	id_tipo_vehiculo int generated always as identity,
	nombre varchar(200) not null,
	constraint id_tipo_vehiculo_pk primary key (id_tipo_vehiculo),
	constraint nombre_tipo_vehiculo_unique unique (nombre)
)

create table Direcciones (
	id_direccion int generated always as identity,
	nombre_calle varchar(200) not null,
	numero_calle int not null,
	comuna varchar(200) not null,
	region varchar(200) not null,
	constraint id_direccion_pk primary key (id_direccion)	
)

create table Tipos_Usuarios (
	id_tipo_usuario int generated always as identity,
	nombre varchar(200) not null,
	constraint id_tipo_usuario_pk primary key (id_tipo_usuario),
	constraint nombre_tipo_usuario_unique unique (nombre)
)

create table Roles (
	id_rol int generated always as identity,
	nombre varchar(200) not null,
	constraint id_rol_pk primary key (id_rol),
	constraint nombre_rol_unique unique (nombre)
)

create table Estados_Reservas (
	id_estado_reserva int generated always as identity,
	nombre varchar(200) not null,
	constraint id_estado_reserva_pk primary key (id_estado_reserva),
	constraint nombre_estado_reserva_unique unique (nombre)
)

create table Metodos_Pagos (
	id_metodo_pago int generated always as identity,
	nombre varchar(200) not null,
	constraint id_metodo_pago_pk primary key (id_rol),
	constraint nombre_metodo_pago_unique unique (nombre)
)

create table tipos_multas (
	id_tipo_multa int generated always as identity,
	nombre varchar(200) not null,
	valor int not null,
	constrait id_tipo_multa_pk primary key (id_tipo_multa)
)

create table Estados_Cuotas (
	id_estado_cuota int generated always as identity,
	nombre varchar(200) not null,
	constraint id_estado_cuota_pk primary key (id_estado_cuota),
	constraint nombre_estado_cuota_unique unique (nombre)
)

create table marca (
	id_marca int generated always as identity,
	nombre varchar(200) not null,
	constraint id_marca_pk primary key (id_marca),
	constraint nombre_marca_unique unique (nombre)
)	
















