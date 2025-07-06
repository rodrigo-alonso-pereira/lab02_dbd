--------------------------------------------------------------------------------
-- Script de consultas de Datos para Rent a Car de Springfield
-- Versión: 1.0
-- Motor de BD: PostgreSQL 16.9
-- Moneda: CLP
-- Alumno: Rodrigo Pereira Yañez
--------------------------------------------------------------------------------

select * from Estados_Tarifas;
select * from Tipos_Tarifas;
select * from Estados_Vehiculos;
select * from Tipos_Vehiculos;
select * from Tipos_Sucursales;
select * from Direcciones;
select * from Tipos_Usuarios;
select * from Roles;
select * from Estados_Reservas;
select * from Metodos_Pagos;
select * from tipos_multas;
select * from Estados_Cuotas;
select * from Marcas;
select * from Tarifas;
select * from Sucursales;
select * from Modelos;
select * from Pagos;
select * from Usuarios;
select * from Telefonos_Sucursales;
select * from Telefonos_Usuarios;
select * from Vehiculos;
select * from Multas;
select * from Cuotas;
select * from Sucursales_Tipos_Sucursales;
select * from Tarifas_Vehiculos;
select * from Reservas;
select * from Reservas_Estados_Reservas;


-- Consultas de Enunciado Laboratorio
-- Su modelo debe ser capaz de responder a las siguientes preguntas clave:

-- 1. ¿Qué vehículos están reservados para el siguiente mes?
select 
	r.id_reserva,
    v.patente,
    m.nombre as modelo,
    tv.nombre as tipo_vehiculo,
    u.nombre_completo AS cliente,
    r.fecha_inicio_alquiler,
    r.fecha_termino_alquiler
from reservas r
join Vehiculos v on r.vehiculo_id = v.id_vehiculo
join Modelos m on v.modelo_id = m.id_modelo
join Tipos_Vehiculos tv on v.tipo_vehiculo_id = tv.id_tipo_vehiculo
join Usuarios u on r.usuario_id = u.id_usuario
join estados_vehiculos ev on ev.id_estado_vehiculo = v.estado_vehiculo_id
join reservas_estados_reservas rer on rer.reserva_id = r.id_reserva 
join estados_reservas er on er.id_estado_reserva = rer.estado_reserva_id
where ev.nombre = 'Reservado' 
      and (r.fecha_inicio_alquiler, r.fecha_termino_alquiler) 
      overlaps (date_trunc('month', now() + interval '1 month'), date_trunc('month', now() + interval '2 month'))
      and (er.nombre = 'Confirmada');

-- 2. ¿Qué tipo de vehículos es el más arrendado?
select tv.nombre, count(r.id_reserva) as cantidad_arriendos
from reservas r 
join vehiculos v on v.id_vehiculo = r.vehiculo_id
join tipos_vehiculos tv on tv.id_tipo_vehiculo = v.tipo_vehiculo_id
where r.id_reserva not in (
	select rer.reserva_id
	from reservas_estados_reservas rer 
	join estados_reservas er on er.id_estado_reserva = rer.estado_reserva_id
	where er.nombre = 'Cancelada'
)
group by tv.nombre
order by cantidad_arriendos desc
limit 1;

-- 3. ¿Cuántas reservas hay desde comienzos de año hasta la fecha actual?
select count(r.id_reserva) as cantidad_reservas
from reservas r 
where (r.fecha_inicio_alquiler, r.fecha_termino_alquiler) 
	overlaps (date_trunc('year', now()), now());

-- 4. ¿Qué sucursal generó más reservas el último mes?
select s.id_sucursal, s.nombre as nombre_sucursal, count(r.sucursal_reserva_id) as total_reservas_generadoas
from reservas r 
join sucursales s on s.id_sucursal = r.sucursal_reserva_id
join reservas_estados_reservas rer on rer.reserva_id = r.id_reserva
join estados_reservas er on rer.estado_reserva_id = er.id_estado_reserva
where er.nombre = 'Creada' and rer.fecha_estado_reserva >= (now() - interval '1 month')
group by s.id_sucursal, s.nombre
order by count(r.sucursal_reserva_id) desc
limit 1;

-- 5. ¿De las reservas cuya sucursal de retiro es diferente a la de entrega, cuántos vehículos, de cada tipo, han sido arrendados?
select tv.nombre, count(tv.id_tipo_vehiculo) as cantidad_tipo_vehiculo
from reservas r
join vehiculos v on r.vehiculo_id = v.id_vehiculo
join tipos_vehiculos tv on v.tipo_vehiculo_id = tv.id_tipo_vehiculo
where r.sucursal_entrega_id != r.sucursal_retiro_id 
	and r.id_reserva not in (
		select rer.reserva_id -- Selecciona vehiculos que tienen estado de cancelado para no incluirlos en el conteo
		from reservas_estados_reservas rer 
		join estados_reservas er on er.id_estado_reserva = rer.estado_reserva_id
		where er.nombre = 'Cancelada'  
	)
group by tv.nombre
order by cantidad_tipo_vehiculo desc;

-- 6. ¿Cuál es el promedio de días que dura una reserva? (Usando todas las reservas que existen en la bd)

-- Nota: round(..., 2) redondeamos el promedio final (dias) a 2 decimales
--		 avg(...) calcula el promedio de dias
--		 extract(epoch from) extrae el total de segundo de un intervalo de fecha
--       /86400 (total segundos de un dia 60*60*24) se divide para obtener cantidad de dias
select round(avg(extract(epoch from(r.fecha_termino_alquiler - r.fecha_inicio_alquiler))/86400), 2) as duracion_prmedio_reserva
from reservas r
where r.id_reserva not in (
	select rer.reserva_id -- Selecciona vehiculos que tienen estado de cancelado para no incluirlos en el conteo
	from reservas_estados_reservas rer 
	join estados_reservas er on er.id_estado_reserva = rer.estado_reserva_id
	where er.nombre = 'Cancelada'  
);

-- 7. Ranking de los 3 clientes que más reservas tienen finalizadas.
select u.nombre_completo as nombre_usuario, count(er.id_estado_reserva)
from reservas r 
join usuarios u on u.id_usuario = r.usuario_id
join reservas_estados_reservas rer on rer.reserva_id = r.id_reserva
join estados_reservas er on er.id_estado_reserva = rer.estado_reserva_id
where er.nombre = 'Finalizada'
group by u.nombre_completo
order by count(er.id_estado_reserva) desc
limit 3;




