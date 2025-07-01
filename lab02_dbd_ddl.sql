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

create table Direcciones (
	id_direccion int generated always as identity,
	nombre_calle varchar(200) not null,
	numero_calle int not null,
	comuna varchar(200) not null,
	region varchar(200) not null,
	constraint id_direccion_pk primary key (id_direccion),
	constraint numero_calle_check check (numero_calle > 0)
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
	constraint id_metodo_pago_pk primary key (id_metodo_pago),
	constraint nombre_metodo_pago_unique unique (nombre)
)

create table tipos_multas (
	id_tipo_multa int generated always as identity,
	nombre varchar(200) not null,
	valor int not null default 0,
	constraint id_tipo_multa_pk primary key (id_tipo_multa),
	constraint valor_check check (valor >= 0) 
)

create table Estados_Cuotas (
	id_estado_cuota int generated always as identity,
	nombre varchar(200) not null,
	constraint id_estado_cuota_pk primary key (id_estado_cuota),
	constraint nombre_estado_cuota_unique unique (nombre)
)

create table Marcas (
	id_marca int generated always as identity,
	nombre varchar(200) not null,
	constraint id_marca_pk primary key (id_marca),
	constraint nombre_marca_unique unique (nombre)
)

create table Tarifas (
	id_tarifa int generated always as identity,
	valor int not null default 0,
	fecha_inicio_vigencia_tarifa timestamp not null default now(),
	fecha_termino_vigencia_tarifa timestamp not null,
	tipo_tarifa_id int not null,
	estado_tarifa_id int not null,
	constraint id_tarifa_pk primary key (id_tarifa),
	constraint tipo_tarifa_id_fk foreign key (tipo_tarifa_id) references Tipos_Tarifas(id_tipo_tarifa),
	constraint estado_tarifa_id_fk foreign key (estado_tarifa_id) references Estados_Tarifas(id_estado_tarifa),
	constraint valor check (valor >= 0),
	constraint tipo_tarifa_id_check check (tipo_tarifa_id > 0),
	constraint estado_tarifa_id_check check (estado_tarifa_id > 0)
)

create table Sucursales (
	id_sucursal int generated always as identity,
	hora_inicio_operacion time not null default '09:00:00',
	hora_fin_operacion time not null default '18:00:00',
	direccion_id int not null,
	constraint id_sucursal_pk primary key (id_sucursal),
	constraint direccion_id_fk foreign key (direccion_id) references direcciones (id_direccion),
	constraint direccion_id_check check (direccion_id > 0) 
)

create table Telefonos_Sucursales (
	id_telefono_sucursal int generated always as identity,
	telefono varchar(30) not null,
	estado boolean not null default true,
	sucursal_id int not null,
	constraint id_telefono_sucursal_pk primary key (id_telefono_sucursal),
	constraint sucursal_id_fk foreign key (sucursal_id) references sucursales (id_sucursal),
	constraint sucursal_id_check check (sucursal_id > 0),
	constraint telefono_unique unique (telefono)
)

create table Usuarios (
	id_usuario int generated always as identity,
	rut varchar(20) not null,
	nombre_completo varchar(200) not null,
	email varchar(200) not null,
	fecha_registro date not null default current_date,
	clave varchar(200) not null,
	rol_id int not null,
	tipo_usuario_id int not null,
	direccion_id int not null,
	constraint id_usuario_pk primary key (id_usuario),
	constraint rol_id_fk foreign key (rol_id) references roles (id_rol),
	constraint tipo_usuario_id_fk foreign key (tipo_usuario_id) references tipos_usuarios (id_tipo_usuario),
	constraint direccion_id_fk foreign key (direccion_id) references direcciones (id_direccion),
	constraint rol_id check (rol_id > 0),
	constraint tipo_usuario_id check (tipo_usuario_id > 0),
	constraint direccion_id_check check (direccion_id > 0),
	constraint email_unique unique (email)
)

create table Telefonos_Usuarios (
	id_telefono_usuario int generated always as identity,
	telefono varchar(30) not null,
	estado boolean not null default true,
	usuario_id int not null,
	constraint id_telefono_usuario_pk primary key (id_telefono_usuario),
	constraint usuario_id_fk foreign key (usuario_id) references usuarios (id_usuario),
	constraint usuario_id_check check (usuario_id > 0)
)

create table Pagos (
	id_pago int generated always as identity,
	fecha_pago timestamp not null default now(),
	numero_cuotas int not null default 1,
	metodo_pago_id int not null,
	constraint id_pago_pk primary key (id_pago),
	constraint metodo_pago_id_fk foreign key (metodo_pago_id) references metodos_pagos (id_metodo_pago),
	constraint metodo_pago_id_check check (metodo_pago_id > 0)
)

create table Multas (
	id_multa int generated always as identity,
	valor_multa int not null,
	fecha_emision_multa timestamp not null default now(),
	pago_id int not null,
	tipo_multa_id int not null,
	constraint id_multa_pk primary key (id_multa),
	constraint pago_id_fk foreign key (pago_id) references pagos (id_pago),
	constraint tipo_multa_id_fk foreign key (tipo_multa_id) references tipos_multas (id_tipo_multa),
	constraint pago_id_check check (pago_id > 0),
	constraint tipo_multa_id_check check (tipo_multa_id > 0)
)

create table Cuotas (
	id_cuota int generated always as identity,
	monto_cuota int not null,
	numero_cuota int not null,
	fecha_vencimiento_cuota date not null,
	fecha_pago_cuota date not null,
	pago_id int not null,
	estado_cuota_id int not null,
	constraint id_cuota_pk primary key (id_cuota),
	constraint pago_id_fk foreign key (pago_id) references pagos (id_pago),
	constraint estado_cuota_id_fk foreign key (estado_cuota_id) references estados_cuotas (id_estado_cuota),
	constraint monto_cuota_check check (monto_cuota > 0),
	constraint numero_cuota_check check (numero_cuota > 0),
	constraint pago_id_check check (pago_id > 0),
	constraint estado_cuota_id_check check (estado_cuota_id > 0)
)

create table Modelos (
	id_modelo int generated always as identity,
	nombre varchar(200) not null,
	marca_id int not null,
	constraint id_modelo_pk primary key (id_modelo),
	constraint marca_id_fk foreign key (marca_id) references marcas (id_marca),
	constraint marca_id_check check (marca_id > 0)
)

create table Vehiculos (
	id_vehiculo int generated always as identity,
	anio int not null,
	color varchar(100) not null,
	patente varchar(20) not null,
	marca_id int not null,
	estado_vehiculo_id int not null,
	tipo_vehiculo_id int not null,
	sucursal_id int not null,
	constraint id_vehiculo_pk primary key (id_vehiculo),
	constraint marca_id_fk foreign key (marca_id) references marcas (id_marca),
	constraint estado_vehiculo_id_fk foreign key (estado_vehiculo_id) references estados_vehiculos (id_estado_vehiculo),
	constraint tipo_vehiculo_id_fk foreign key (tipo_vehiculo_id) references tipos_vehiculos (id_tipo_vehiculo),
	constraint sucursal_id_fk foreign key (sucursal_id) references sucursales (id_sucursal),
	constraint marca_id_check check (marca_id > 0),
	constraint estado_vehiculo_id_check check (estado_vehiculo_id > 0),
	constraint tipo_vehiculo_id_check check (tipo_vehiculo_id > 0),
	constraint sucursal_id_check check (sucursal_id > 0),
	constraint patente_unique unique (patente)
)

create table Tarifas_Vehiculos (
	vehiculo_id int not null,
	tarifa_id int not null,
	primary key (vehiculo_id, tarifa_id),
	constraint vehiculo_id_fk foreign key (vehiculo_id) references vehiculos (id_vehiculo),
	constraint tarifa_id_fk foreign key (tarifa_id) references tarifas (id_tarifa),
	constraint vehiculo_id_check check (vehiculo_id > 0),
	constraint tarifa_id_check check (tarifa_id > 0)
)

create table Sucursales_Tipos_Sucursales (
	sucursal_id int not null,
	tipo_sucursal_id int not null,
	primary key (sucursal_id, tipo_sucursal_id),
	constraint sucursal_id_fk foreign key (sucursal_id) references sucursales (id_sucursal),
	constraint tipo_sucursal_id_fk foreign key (tipo_sucursal_id) references tipos_sucursales (id_tipo_sucursal),
	constraint sucursal_id_check check (sucursal_id > 0),
	constraint tipo_sucursal_id_check check (tipo_sucursal_id > 0)
)

create table Reservas (
	id_reserva int not null,
	fecha_inicio_alquiler timestamp not null default now(),
	fecha_termino_alquiler timestamp not null,
	monto_total int not null,
	usuario_id int not null,
	vehiculo_id int not null,
	pago_id int not null,
	sucursal_retiro_id int not null,
	sucursal_entrega_id int not null,
	constraint id_reserva_pk primary key (id_reserva),
	constraint usuario_id_fk foreign key (usuario_id) references usuarios (id_usuarios),
	constraint vehiculo_id_fk foreign key (vehiculo_id) references vehiculos (id_vehiculo),
	constraint pago_id_fk foreign key (pago_id) references pagos (id_pago),
	constraint sucursal_retiro_id_fk foreign key (sucursal_retiro_id) references sucursales (id_sucursal),
	constraint sucursal_entrega_id_fk foreign key (sucursal_entrega_id) references sucursales (id_sucursal),
	constraint usuario_id_check check (usuario_id > 0),
	constraint vehiculo_id_check check (vehiculo_id > 0),
	constraint pago_id_check check (pago_id > 0),
	constraint sucursal_retiro_id_check check (sucursal_retiro_id > 0),
	constraint sucursal_entrega_id_check check (sucursal_entrega_id > 0),
	constraint monto_total_check check (monto_total > 0)
)

create table Reservas_Estados_Reservas (
	reserva_id int not null,
	estado_reserva_id int not null,
	fecha_estado_reserva timestamp not null default now(),
	primary key (reserva_id, estado_reserva_id),
	constraint reserva_id_fk foreign key (reserva_id) references reservas (id_reserva),
	constraint estado_reserva_id_fk foreign key (estado_reserva_id) references estados_reservas (id_estado_reserva),
	constraint reserva_id_check check (reserva_id > 0),
	constraint estado_reserva_id_check check (estado_reserva_id > 0)
)


















