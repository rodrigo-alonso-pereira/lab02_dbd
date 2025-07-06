--------------------------------------------------------------------------------
-- Script de Creacion de Modelo de datos para Rent a Car de Springfield
-- Versión: 1.0
-- Motor de BD: PostgreSQL 16.9
-- Alumno: Rodrigo Pereira Yañez
--------------------------------------------------------------------------------

create table Estados_Tarifas (
	id_estado_tarifa int generated always as identity,
	nombre varchar(200) not null,
	constraint id_estado_tarifa_pk primary key (id_estado_tarifa),
	constraint nombre_estado_tarifa_unique unique (nombre)
);

create table Tipos_Tarifas (
	id_tipo_tarifa int generated always as identity,
	nombre varchar(200) not null,
	constraint id_tipo_tarifa_pk primary key (id_tipo_tarifa),
	constraint nombre_tipo_tarifa_unique unique (nombre)
);

create table Estados_Vehiculos (
	id_estado_vehiculo int generated always as identity,
	nombre varchar(200) not null,
	constraint id_estado_vehiculo_pk primary key (id_estado_vehiculo),
	constraint nombre_estado_vehiculo_unique unique (nombre)
);

create table Tipos_Vehiculos (
	id_tipo_vehiculo int generated always as identity,
	nombre varchar(200) not null,
	constraint id_tipo_vehiculo_pk primary key (id_tipo_vehiculo),
	constraint nombre_tipo_vehiculo_unique unique (nombre)
);

create table Tipos_Sucursales (
	id_tipo_sucursal int generated always as identity,
	nombre varchar(200) not null,
	constraint id_tipo_sucursal_pk primary key (id_tipo_sucursal),
	constraint nombre_tipo_sucursal_unique unique (nombre)
);

create table Direcciones (
	id_direccion int generated always as identity,
	nombre_calle varchar(200) not null,
	numero_calle int not null,
	comuna varchar(200) not null,
	region varchar(200) not null,
	constraint id_direccion_pk primary key (id_direccion),
	constraint numero_calle_check check (numero_calle > 0)
);

create table Tipos_Usuarios (
	id_tipo_usuario int generated always as identity,
	nombre varchar(200) not null,
	constraint id_tipo_usuario_pk primary key (id_tipo_usuario),
	constraint nombre_tipo_usuario_unique unique (nombre)
);

create table Roles (
	id_rol int generated always as identity,
	nombre varchar(200) not null,
	constraint id_rol_pk primary key (id_rol),
	constraint nombre_rol_unique unique (nombre)
);

create table Estados_Reservas (
	id_estado_reserva int generated always as identity,
	nombre varchar(200) not null,
	constraint id_estado_reserva_pk primary key (id_estado_reserva),
	constraint nombre_estado_reserva_unique unique (nombre)
);

create table Metodos_Pagos (
	id_metodo_pago int generated always as identity,
	nombre varchar(200) not null,
	constraint id_metodo_pago_pk primary key (id_metodo_pago),
	constraint nombre_metodo_pago_unique unique (nombre)
);

create table tipos_multas (
	id_tipo_multa int generated always as identity,
	nombre varchar(200) not null,
	valor int not null default 0,
	constraint id_tipo_multa_pk primary key (id_tipo_multa),
	constraint valor_check check (valor >= 0) 
);

create table Estados_Cuotas (
	id_estado_cuota int generated always as identity,
	nombre varchar(200) not null,
	constraint id_estado_cuota_pk primary key (id_estado_cuota),
	constraint nombre_estado_cuota_unique unique (nombre)
);

create table Marcas (
	id_marca int generated always as identity,
	nombre varchar(200) not null,
	constraint id_marca_pk primary key (id_marca),
	constraint nombre_marca_unique unique (nombre)
);

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
	constraint estado_tarifa_id_check check (estado_tarifa_id > 0),
	constraint fechas_alquiler_check check (fecha_termino_vigencia_tarifa > fecha_inicio_vigencia_tarifa)
);

create table Sucursales (
	id_sucursal int generated always as identity,
	nombre varchar(200) not null,
	hora_inicio_operacion time not null default '09:00:00',
	hora_fin_operacion time not null default '18:00:00',
	direccion_id int not null,
	constraint id_sucursal_pk primary key (id_sucursal),
	constraint direccion_id_fk foreign key (direccion_id) references direcciones (id_direccion),
	constraint direccion_id_check check (direccion_id > 0),
	constraint horas_operacion_check check (hora_fin_operacion > hora_inicio_operacion)
);

create table Telefonos_Sucursales (
	id_telefono_sucursal int generated always as identity,
	telefono varchar(30) not null,
	estado boolean not null default true,
	sucursal_id int not null,
	constraint id_telefono_sucursal_pk primary key (id_telefono_sucursal),
	constraint sucursal_id_fk foreign key (sucursal_id) references sucursales (id_sucursal),
	constraint sucursal_id_check check (sucursal_id > 0),
	constraint telefono_unique unique (telefono)
);

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
	constraint email_unique unique (email),
	constraint rut_unique unique (rut)
);

create table Telefonos_Usuarios (
	id_telefono_usuario int generated always as identity,
	telefono varchar(30) not null,
	estado boolean not null default true,
	usuario_id int not null,
	constraint id_telefono_usuario_pk primary key (id_telefono_usuario),
	constraint usuario_id_fk foreign key (usuario_id) references usuarios (id_usuario),
	constraint usuario_id_check check (usuario_id > 0)
);

create table Pagos (
	id_pago int generated always as identity,
	fecha_pago timestamp not null default now(),
	numero_cuotas int not null default 1,
	total_pagado int,
	metodo_pago_id int not null,
	constraint id_pago_pk primary key (id_pago),
	constraint metodo_pago_id_fk foreign key (metodo_pago_id) references metodos_pagos (id_metodo_pago),
	constraint metodo_pago_id_check check (metodo_pago_id > 0)
);

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
);

create table Cuotas (
	id_cuota int generated always as identity,
	monto_cuota int not null,
	numero_cuota int not null,
	fecha_vencimiento_cuota date not null,
	fecha_pago_cuota date,
	pago_id int not null,
	estado_cuota_id int not null,
	constraint id_cuota_pk primary key (id_cuota),
	constraint pago_id_fk foreign key (pago_id) references pagos (id_pago),
	constraint estado_cuota_id_fk foreign key (estado_cuota_id) references estados_cuotas (id_estado_cuota),
	constraint monto_cuota_check check (monto_cuota > 0),
	constraint numero_cuota_check check (numero_cuota > 0),
	constraint pago_id_check check (pago_id > 0),
	constraint estado_cuota_id_check check (estado_cuota_id > 0)
);

create table Modelos (
	id_modelo int generated always as identity,
	nombre varchar(200) not null,
	marca_id int not null,
	constraint id_modelo_pk primary key (id_modelo),
	constraint marca_id_fk foreign key (marca_id) references marcas (id_marca),
	constraint marca_id_check check (marca_id > 0),
	constraint nombre_marca_id_unique unique (nombre, marca_id)
);

create table Vehiculos (
	id_vehiculo int generated always as identity,
	anio int not null,
	color varchar(100) not null,
	patente varchar(20) not null,
	modelo_id int not null,
	estado_vehiculo_id int not null,
	tipo_vehiculo_id int not null,
	sucursal_id int not null,
	constraint id_vehiculo_pk primary key (id_vehiculo),
	constraint modelo_id_fk foreign key (modelo_id) references Modelos (id_modelo),
	constraint estado_vehiculo_id_fk foreign key (estado_vehiculo_id) references estados_vehiculos (id_estado_vehiculo),
	constraint tipo_vehiculo_id_fk foreign key (tipo_vehiculo_id) references tipos_vehiculos (id_tipo_vehiculo),
	constraint sucursal_id_fk foreign key (sucursal_id) references sucursales (id_sucursal),
	constraint modelo_id_check check (modelo_id > 0),
	constraint estado_vehiculo_id_check check (estado_vehiculo_id > 0),
	constraint tipo_vehiculo_id_check check (tipo_vehiculo_id > 0),
	constraint sucursal_id_check check (sucursal_id > 0),
	constraint patente_unique unique (patente),
	constraint anio_vehiculo_check check (anio > 1980 and anio <= extract(year from now()) + 1)
);

create table Tarifas_Vehiculos (
	vehiculo_id int not null,
	tarifa_id int not null,
	primary key (vehiculo_id, tarifa_id),
	constraint vehiculo_id_fk foreign key (vehiculo_id) references vehiculos (id_vehiculo),
	constraint tarifa_id_fk foreign key (tarifa_id) references tarifas (id_tarifa),
	constraint vehiculo_id_check check (vehiculo_id > 0),
	constraint tarifa_id_check check (tarifa_id > 0)
);

create table Sucursales_Tipos_Sucursales (
	sucursal_id int not null,
	tipo_sucursal_id int not null,
	primary key (sucursal_id, tipo_sucursal_id),
	constraint sucursal_id_fk foreign key (sucursal_id) references sucursales (id_sucursal),
	constraint tipo_sucursal_id_fk foreign key (tipo_sucursal_id) references tipos_sucursales (id_tipo_sucursal),
	constraint sucursal_id_check check (sucursal_id > 0),
	constraint tipo_sucursal_id_check check (tipo_sucursal_id > 0)
);

create table Reservas (
	id_reserva int generated always as identity,
	fecha_inicio_alquiler timestamp not null default now(),
	fecha_termino_alquiler timestamp not null,
	monto_total int not null,
	usuario_id int not null,
	vehiculo_id int not null,
	pago_id int not null,
	sucursal_reserva_id int not null,
	sucursal_retiro_id int not null,
	sucursal_entrega_id int not null,
	constraint id_reserva_pk primary key (id_reserva),
	constraint usuario_id_fk foreign key (usuario_id) references usuarios (id_usuario),
	constraint vehiculo_id_fk foreign key (vehiculo_id) references vehiculos (id_vehiculo),
	constraint pago_id_fk foreign key (pago_id) references pagos (id_pago),
	constraint sucursal_reserva_id_fk foreign key (sucursal_reserva_id) references sucursales (id_sucursal),
	constraint sucursal_retiro_id_fk foreign key (sucursal_retiro_id) references sucursales (id_sucursal),
	constraint sucursal_entrega_id_fk foreign key (sucursal_entrega_id) references sucursales (id_sucursal),
	constraint usuario_id_check check (usuario_id > 0),
	constraint vehiculo_id_check check (vehiculo_id > 0),
	constraint pago_id_check check (pago_id > 0),
	constraint sucursal_reserva_id_check check (sucursal_reserva_id > 0),
	constraint sucursal_retiro_id_check check (sucursal_retiro_id > 0),
	constraint sucursal_entrega_id_check check (sucursal_entrega_id > 0),
	constraint monto_total_check check (monto_total > 0),
	constraint fechas_alquiler_check check (fecha_termino_alquiler > fecha_inicio_alquiler)
);

create table Reservas_Estados_Reservas (
	reserva_id int not null,
	estado_reserva_id int not null,
	fecha_estado_reserva timestamp not null default now(),
	primary key (reserva_id, estado_reserva_id),
	constraint reserva_id_fk foreign key (reserva_id) references reservas (id_reserva),
	constraint estado_reserva_id_fk foreign key (estado_reserva_id) references estados_reservas (id_estado_reserva),
	constraint reserva_id_check check (reserva_id > 0),
	constraint estado_reserva_id_check check (estado_reserva_id > 0)
);

-- TRIGGERS
-- procedimiento almacenado para agregar monto reserva.

-- NOTA: Orden esperado de estado_vehiculo segun estado_reserva
-- Estado_Reserva -->  Estado_Vehiculo
-- Creada	      -->  Disponible  x
-- Confirmada	  -->  Reservado   x
-- En Curso	      -->  Arrendado   x
-- Finalizada	  -->  Disponible  x
-- Cancelada	  -->  Disponible  x
-- Retrasada	  -->  Arrendado   x

-- Actualizar el estado del vehículo al confirmar una reserva: Cuando se actualiza una reserva 
-- con estado ‘En curso’, el vehículo asociado debe cambiar su estado a 'Arrendado'.

create or replace function actualizar_estado_vehiculo_en_curso()
returns trigger as $$
declare
	r_id_estado_en_curso int;
	v_id_estado_arrendado int;
	v_id_vehiculo int;
begin
	select id_estado_reserva into r_id_estado_en_curso from Estados_Reservas where nombre = 'En Curso';
	select id_estado_vehiculo into v_id_estado_arrendado from Estados_Vehiculos where nombre = 'Arrendado';
	
	if new.estado_reserva_id = r_id_estado_en_curso then
		select vehiculo_id into v_id_vehiculo from Reservas where id_reserva = new.reserva_id;
		update vehiculos
		set estado_vehiculo_id = v_id_estado_arrendado
		where id_vehiculo = v_id_vehiculo;
	end if;
	return new;
end;
$$ LANGUAGE plpgsql;

create trigger tr_actualizar_estado_vehiculo_en_curso
after insert on Reservas_Estados_Reservas
for each row
execute function actualizar_estado_vehiculo_en_curso();

-- Liberar vehículo al finalizar una reserva: Si una reserva cambia a estado 'Finalizada', 
-- el vehículo debe quedar disponible ('Disponible') y moverse a la sucursal de destino.

create or replace function actualizar_estado_vehiculo_finalizada()
returns trigger as $$
declare
	r_id_estado_finalizado int;
	v_id_estado_disponible int;
	v_id_vehiculo int;
begin
	select id_estado_reserva into r_id_estado_finalizado from Estados_Reservas where nombre = 'Finalizada';
	select id_estado_vehiculo into v_id_estado_disponible from Estados_Vehiculos where nombre = 'Disponible';
	
	if new.estado_reserva_id = r_id_estado_finalizado then
		select vehiculo_id into v_id_vehiculo from Reservas where id_reserva = new.reserva_id;
		update vehiculos
		set estado_vehiculo_id = v_id_estado_disponible
		where id_vehiculo = v_id_vehiculo;
	end if;
	return new;
end;
$$ LANGUAGE plpgsql;

create trigger tr_actualizar_estado_vehiculo_finalizada
after insert on Reservas_Estados_Reservas
for each row
execute function actualizar_estado_vehiculo_finalizada();

-- OPCIONAL: Confirmada	  -->  Reservado
create or replace function actualizar_estado_vehiculo_confirmado()
returns trigger as $$
declare
	r_id_estado_finalizado int;
	v_id_estado_disponible int;
	v_id_vehiculo int;
begin
	select id_estado_reserva into r_id_estado_finalizado from Estados_Reservas where nombre = 'Confirmada';
	select id_estado_vehiculo into v_id_estado_disponible from Estados_Vehiculos where nombre = 'Reservado';
	
	if new.estado_reserva_id = r_id_estado_finalizado then
		select vehiculo_id into v_id_vehiculo from Reservas where id_reserva = new.reserva_id;
		update vehiculos
		set estado_vehiculo_id = v_id_estado_disponible
		where id_vehiculo = v_id_vehiculo;
	end if;
	return new;
end;
$$ LANGUAGE plpgsql;

create trigger tr_actualizar_estado_vehiculo_confirmado
after insert on Reservas_Estados_Reservas
for each row
execute function actualizar_estado_vehiculo_confirmado();

-- OPCIONAL: Cancelada	  -->  Disponible
create or replace function actualizar_estado_vehiculo_cancelado()
returns trigger as $$
declare
	r_id_estado_finalizado int;
	v_id_estado_disponible int;
	v_id_vehiculo int;
begin
	select id_estado_reserva into r_id_estado_finalizado from Estados_Reservas where nombre = 'Cancelada';
	select id_estado_vehiculo into v_id_estado_disponible from Estados_Vehiculos where nombre = 'Disponible';
	
	if new.estado_reserva_id = r_id_estado_finalizado then
		select vehiculo_id into v_id_vehiculo from Reservas where id_reserva = new.reserva_id;
		update vehiculos
		set estado_vehiculo_id = v_id_estado_disponible
		where id_vehiculo = v_id_vehiculo;
	end if;
	return new;
end;
$$ LANGUAGE plpgsql;

create trigger tr_actualizar_estado_vehiculo_cancelado
after insert on Reservas_Estados_Reservas
for each row
execute function actualizar_estado_vehiculo_cancelado();

-- OPCIONAL: Retrasada	  -->  Arrendado
create or replace function actualizar_estado_vehiculo_retrasado()
returns trigger as $$
declare
	r_id_estado_finalizado int;
	v_id_estado_disponible int;
	v_id_vehiculo int;
begin
	select id_estado_reserva into r_id_estado_finalizado from Estados_Reservas where nombre = 'Retrasada';
	select id_estado_vehiculo into v_id_estado_disponible from Estados_Vehiculos where nombre = 'Arrendado';
	
	if new.estado_reserva_id = r_id_estado_finalizado then
		select vehiculo_id into v_id_vehiculo from Reservas where id_reserva = new.reserva_id;
		update vehiculos
		set estado_vehiculo_id = v_id_estado_disponible
		where id_vehiculo = v_id_vehiculo;
	end if;
	return new;
end;
$$ LANGUAGE plpgsql;

create trigger tr_actualizar_estado_vehiculo_retrasado
after insert on Reservas_Estados_Reservas
for each row
execute function actualizar_estado_vehiculo_retrasado();

-- Consulta para evaluar funcionamiento trigger
--select distinct on (r.id_reserva) r.id_reserva, u.nombre_completo , r.vehiculo_id, ev.nombre as estado_vehiculo ,rer.estado_reserva_id, er.nombre as estado_reserva, rer.fecha_estado_reserva
--from reservas r 
--join reservas_estados_reservas rer on rer.reserva_id = r.id_reserva
--join estados_reservas er on er.id_estado_reserva = rer.estado_reserva_id
--join usuarios u on u.id_usuario = r.usuario_id
--join vehiculos v on v.id_vehiculo = r.vehiculo_id
--join estados_vehiculos ev on ev.id_estado_vehiculo = v.estado_vehiculo_id
--order by r.id_reserva, rer.fecha_estado_reserva desc;

-- Inserciones de prueba: Confirmada  -->  Reservado
--INSERT INTO Reservas_Estados_Reservas (reserva_id, estado_reserva_id) VALUES (18, 2);
-- Inserciones de prueba: En Curso	-->  Arrendado
--INSERT INTO Reservas_Estados_Reservas (reserva_id, estado_reserva_id) VALUES (18, 3);
-- Inserciones de prueba: Finalizada  -->  Disponible 
--INSERT INTO Reservas_Estados_Reservas (reserva_id, estado_reserva_id) VALUES (18, 4);
-- Inserciones de prueba: Cancelada	  -->  Disponible
--INSERT INTO Reservas_Estados_Reservas (reserva_id, estado_reserva_id) VALUES (18, 5);
-- Inserciones de prueba: Retrasada	  -->  Arrendado
--INSERT INTO Reservas_Estados_Reservas (reserva_id, estado_reserva_id) VALUES (18, 6);






























