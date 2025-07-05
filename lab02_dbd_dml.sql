--------------------------------------------------------------------------------
-- Script de Inserción de Datos para Rent a Car de Springfield
-- Versión: 1.0
-- Motor de BD: PostgreSQL 16.9
-- Moneda: CLP
-- Alumno: Rodrigo Pereira Yañez
--------------------------------------------------------------------------------

INSERT INTO Estados_Tarifas (nombre) VALUES
('Activa'),
('Pausada'),
('Eliminada'),
('Oferta Especial'),
('Expirada');

INSERT INTO Tipos_Tarifas (nombre) VALUES
('Tarifa Diaria'),
('Tarifa Semanal'),
('Tarifa Corporativa'),
('Tarifa Fin de Semana'),
('Tarifa de Larga Duración');

INSERT INTO Estados_Vehiculos (nombre) VALUES
('Disponible'),
('Arrendado'),
('En Mantenimiento'),
('Fuera de Servicio'),
('Reservado');

INSERT INTO Tipos_Vehiculos (nombre) VALUES
('Sedán'),
('Deportivo'),
('SUV'),
('Furgón de Carga'),
('Nave Espacial'),
('Minivan');

INSERT INTO Tipos_Sucursales (nombre) VALUES
('Punto de Retiro'),
('Punto de Entrega');

INSERT INTO Direcciones (nombre_calle, numero_calle, comuna, region) VALUES
('Avenida Siempreviva', 742, 'Springfield', 'Región de Springfield'),
('Calle Falsa', 123, 'Shelbyville', 'Región de Springfield'),
('Ruta 66', 1, 'Afueras de Springfield', 'Región de Springfield'),
('Planta de Energía Nuclear', 1, 'Sector Industrial', 'Región de Springfield'),
('Planet Express', 1, 'Distrito de Dobladores', 'Nueva Nueva York'),
('Calle del Mal', 666, 'Robot Hell', 'Nueva Jersey'),
('Kwik-E-Mart', 56, 'Centro de Springfield', 'Región de Springfield'),
('Casa de Flanders', 744, 'Springfield', 'Región de Springfield'),
('Calle Plympton', 19, 'Distrito Escolar', 'Región de Springfield');


INSERT INTO Tipos_Usuarios (nombre) VALUES
('Persona Natural'),
('Empresa'),
('Empleado'),
('Robot'),
('Alienígena');

INSERT INTO Roles (nombre) VALUES
('Cliente'),
('Mantenedor'),
('Soporte'),
('Administrativo'),
('Gerente');

INSERT INTO Estados_Reservas (nombre) VALUES
('Creada'), -- se crea reserva
('Confirmada'), -- se paga reserva
('En Curso'), -- se entrega vehiculo
('Finalizada'), -- se devuelve vehiculo
('Cancelada'), -- se cancela la reserva
('Retrasada'); -- se retrasa la reserva

INSERT INTO Metodos_Pagos (nombre) VALUES
('Tarjeta de Crédito'),
('Tarjeta de Débito'),
('Transferencia Bancaria'),
('Dólares de Bender'),
('Efectivo');

INSERT INTO tipos_multas (nombre, valor) VALUES
('Atraso en la entrega (diario)', 15000),
('Daños menores al vehículo', 100000),
('Limpieza profunda requerida', 25000),
('Combustible no repuesto', 50000),
('Uso indebido de la bocina de La Cucharacha', 5000);

INSERT INTO Estados_Cuotas (nombre) VALUES
('Pendiente'),
('Pagada'),
('Atrasada'),
('Anulada');

INSERT INTO Marcas (nombre) VALUES
('Powell Motors'),
('Canyonero'),
('Plymouth'),
('Planet Express'),
('Thundercougarfalconbird'),
('Desconocida'),
('Zimon');

INSERT INTO Tarifas (valor, fecha_inicio_vigencia_tarifa, fecha_termino_vigencia_tarifa, tipo_tarifa_id, estado_tarifa_id) VALUES
(25000, '2025-01-01', '2025-12-31', 1, 1), -- Tarifa Diaria para Sedán (Activa)
(150000, '2025-01-01', '2025-12-31', 2, 1), -- Tarifa Semanal (Activa)
(40000, '2025-06-01', '2025-08-31', 4, 1), -- Tarifa Fin de Semana (Activa)
(500000, '2025-01-01', '2025-12-31', 5, 1), -- Tarifa Larga Duración (Activa)
(999999, '3025-01-01', '3025-12-31', 1, 1); -- Tarifa Diaria Nave Espacial (Activa)

INSERT INTO Sucursales (nombre, hora_inicio_operacion, hora_fin_operacion, direccion_id) VALUES
('Sucursal Central Springfield', '09:00:00'::time without time zone, '19:00:00'::time without time zone, 1), -- Sucursal Central Springfield (Casa Simpson)
('Sucursal Shelbyville', '08:00:00'::time without time zone, '20:00:00'::time without time zone, 2), -- Sucursal Shelbyville
('Sucursal Planet Express', '00:00:00'::time without time zone, '23:59:59'::time without time zone, 5), -- Sucursal Planet Express (24/7)
('Sucursal Planta Nuclear', '10:00:00'::time without time zone, '18:00:00'::time without time zone, 4); -- Sucursal Planta Nuclear

INSERT INTO Modelos (nombre, marca_id) VALUES
('The Homer', 1),
('F-Series', 2),
('Junkerolla', 3),
('Nave de Reparto', 4),
('Sedán de Lujo', 5),
('Coche Rosa Familiar', 3),
('Minivan Familiar', 7);

-- NOTA_1: total_pagado se inicia en 0 o NULL. Un trigger/procedimiento lo actualizará.
-- NOTA_2: Fecha_pago corresponde a now() ya que cuando se reserva, se paga inmediatamente.
INSERT INTO Pagos (numero_cuotas, total_pagado, metodo_pago_id) VALUES
(1, 0, 1), -- Pago 1: Homero, 1 cuota, Tarjeta de Crédito
(1, 0, 2), -- Pago 2: Marge, 1 cuota, Tarjeta de Débito
(3, 0, 1), -- Pago 3: Burns, 3 cuotas, Tarjeta de Crédito
(1, 0, 4), -- Pago 4: Bender, 1 cuota, Dólares de Bender
(1, 0, 5), -- Pago 5: Fry, 1 cuota, Efectivo
(2, 0, 1), -- Pago 6: Lisa, 2 cuotas, Tarjeta de Crédito
(1, 0, 2), -- Pago 7: Moe, 1 cuota, Tarjeta de Débito
(1, 0, 1), -- Pago 8: Bart, 1 cuota, Tarjeta de Crédito
(1, 0, 2), -- Pago 9: Apu, 1 cuota, Tarjeta de Débito
(1, 0, 1), -- Pago 10: Flanders, 1 cuota, Tarjeta de Crédito
(1, 0, 1), -- Pago 11: Profesor, 1 cuota, Tarjeta de Crédito
(1, 0, 3), -- Pago 12: Leela, 1 cuota, Transferencia Bancaria
(1, 0, 1), -- Pago 13: Homero, 1 cuota, Tarjeta de Crédito
(1, 0, 2), -- Pago 14: Bart, 1 cuota, Tarjeta de Débito
(1, 0, 5), -- Pago 15: Moe, 1 cuota, Efectivo
(1, 0, 1), -- Pago 16: Homero, 1 cuota, Tarjeta de Crédito
(1, 0, 2), -- Pago 17: Homero, 1 cuota, Tarjeta de Débito
(1, 0, 1); -- Pago 18: Bart, 1 cuota, Tarjeta de Crédito

INSERT INTO Usuarios (rut, nombre_completo, email, clave, rol_id, tipo_usuario_id, direccion_id) VALUES
('1.111.111-9', 'Homero Simpson', 'homer@springfield.com', 'doh123', 1, 1, 1),        -- Rol: Cliente, Tipo: Empleado
('2.222.222-7', 'Marge Simpson', 'marge@springfield.com', 'mmmmh123', 1, 1, 1),     -- Rol: Cliente, Tipo: Persona Natural
('3.333.333-5', 'Montgomery Burns', 'burns@nuclear.com', 'excelente', 1, 2, 4),   -- Rol: Cliente, Tipo: Empresa
('4.444.444-3', 'Bender Rodriguez', 'bender@planetexpress.com', 'shinymetalass', 1, 4, 6), -- Rol: Cliente, Tipo: Robot
('5.555.555-1', 'Philip J. Fry', 'fry@planetexpress.com', 'futurama', 1, 1, 5),      -- Rol: Cliente, Tipo: Persona Natural
('6.666.666-K', 'Lisa Simpson', 'lisa@springfield.com', 'saxofon', 1, 1, 1),       -- Rol: Cliente, Tipo: Persona Natural
('7.777.777-8', 'Moe Szyslak', 'moe@moes.com', 'duff123', 4, 3, 3),             -- Rol: Administrativo, Tipo: Empleado
('8.888.888-6', 'Turanga Leela', 'leela@planetexpress.com', 'hiyaaa', 5, 3, 5),      -- Rol: Gerente, Tipo: Empleado
('9.999.999-4', 'Bart Simpson', 'bart@springfield.com', 'aycaramba', 1, 1, 1),       -- Rol: Cliente, Tipo: Persona Natural
('10.101.101-2', 'Apu Nahasapeemapetilon', 'apu@kwikemart.com', 'thankyoucomeagain', 4, 3, 7), -- Rol: Administrativo, Tipo: Empleado
('11.112.211-K', 'Ned Flanders', 'ned@leftorium.com', 'okilydokily', 1, 1, 8),      -- Rol: Cliente, Tipo: Persona Natural
('12.212.212-3', 'Profesor Farnsworth', 'hubert@planetexpress.com', 'goodnewseveryone', 5, 3, 5), -- Rol: Gerente, Tipo: Empleado
('13.313.313-4', 'Dr. Zoidberg', 'zoidberg@planetexpress.com', 'woopwoopwoop', 3, 3, 5),      -- Rol: Soporte, Tipo: Empleado
('14.414.414-5', 'Willie el jardinero', 'willie@springfield.edu', 'cheese-eating-surrender-monkeys', 2, 3, 9); -- Rol: Mantenedor, Tipo: Empleado

INSERT INTO Telefonos_Sucursales (telefono, sucursal_id) VALUES
('+56911111111', 1),
('+56922222222', 2),
('+13475550100', 3),
('+56944444444', 4);

INSERT INTO Telefonos_Usuarios (telefono, usuario_id) VALUES
('+56912345678', 1), -- Homero Simpson
('+56987654321', 2), -- Marge Simpson
('+56911112222', 3), -- Montgomery Burns
('+13475550101', 4), -- Bender Rodriguez
('+13475550102', 5), -- Philip J. Fry
('+56933334444', 8), -- Turanga Leela
('+56955556666', 10), -- Apu Nahasapeemapetilon
('+56977778888', 11), -- Ned Flanders
('+56900001111', 12), -- Profesor Farnsworth
('+56922223333', 13), -- Dr. Zoidberg
('+56944445555', 14); -- Willie el jardinero

INSERT INTO Vehiculos (anio, color, patente, marca_id, estado_vehiculo_id, tipo_vehiculo_id, sucursal_id) VALUES
(1986, 'Rosado', 'BORT-66', 3, 5, 1, 1),        -- ID 1: Sedán de Homero. Estado: Reservado (por Lisa).
(2024, 'Rojo', 'AY-CRMB', 2, 5, 3, 1),        -- ID 2: Canyonero. Estado: Reservado (por Flanders).
(1992, 'Verde con burbujas', 'THEHMR', 1, 3, 1, 2), -- ID 3: The Homer. Estado: En Mantenimiento.
(1999, 'Verde claro', 'PLN-EXP', 4, 5, 5, 3),        -- ID 4: Nave Planet Express. Estado: Reservado (por Leela).
(2005, 'Plata', 'TFCB-01', 5, 2, 2, 3),        -- ID 5: Thundercougarfalconbird. Estado: Arrendado (por Fry).
(1993, 'Morado', '7G04', 6, 5, 1, 2),        -- ID 6: Auto de Marge. Estado: Reservado (por Homero para agosto).
(2022, 'Negro', 'EXLNT-1', 5, 1, 1, 4),        -- ID 7: Auto de Lujo del Sr. Burns. Estado: Disponible.
(2023, 'Azul', 'APU-008', 7, 2, 6, 1),         -- ID 8: Minivan de Apu. Estado: Arrendado (por Apu).
(2025, 'Naranja', 'WOOHOO', 2, 1, 3, 2),         -- ID 9: Nuevo Canyonero. Estado: Disponible.
(2021, 'Gris', 'MM-BEER', 6, 5, 1, 1);         -- ID 10: Nuevo Sedán. Estado: Reservado (por Bart para agosto).


INSERT INTO Multas (valor_multa, pago_id, tipo_multa_id) VALUES
(30000, 4, 1), -- Multa para el pago de Bender
(75000, 12, 5); -- Multa para el Profesor Farnsworth.


INSERT INTO Cuotas (monto_cuota, numero_cuota, fecha_vencimiento_cuota, fecha_pago_cuota, pago_id, estado_cuota_id) VALUES
(100000, 1, '2025-06-15', '2025-06-14', 3, 2), -- Cuota 1 pagada (estado_cuota_id=2)
(100000, 2, '2025-07-15', NULL, 3, 1), -- Cuota 2 pendiente (estado_cuota_id=1)
(100000, 3, '2025-08-15', NULL, 3, 1); -- Cuota 3 pendiente (estado_cuota_id=1)

-- ID 1 = 'Pto de Retiro', ID 2 = 'Pto de Entrega'
INSERT INTO Sucursales_Tipos_Sucursales (sucursal_id, tipo_sucursal_id) VALUES
(1, 1), -- Springfield Central es Pto de Retiro
(1, 2), -- Springfield Central también es Pto de Entrega
(2, 1), -- Shelbyville es Pto de Retiro
(2, 2), -- Shelbyville también es Pto de Entrega
(3, 1), -- Planet Express es Pto de Retiro
(3, 2), -- Planet Express también es Pto de Entrega
(4, 1); -- Planta Nuclear es solo Pto de Retiro

-- Insertando Tarifas de un Vehículo (Relación Muchos a Muchos)
INSERT INTO Tarifas_Vehiculos (vehiculo_id, tarifa_id) VALUES
(1, 1), -- Sedán de Homero con Tarifa Diaria
(1, 2), -- Sedán de Homero también con Tarifa Semanal
(2, 1), -- Canyonero con Tarifa Diaria
(2, 4), -- Canyonero con Tarifa Larga Duración
(4, 5), -- Nave Planet Express con Tarifa de Nave
(5, 1), -- Thundercougarfalconbird con Tarifa Diaria
(7, 3), -- Auto de Burns con Tarifa Corporativa 
(8, 1), -- Minivan de Apu con Tarifa diaria
(8, 2); -- Minivan de Apu con Tarifa semanal


-- NOTA: El estado del vehículo ('Arrendado') y el total_pagado deberían ser actualizados por triggers, no insertados directamente.
INSERT INTO Reservas (fecha_inicio_alquiler, fecha_termino_alquiler, monto_total, usuario_id, vehiculo_id, pago_id, sucursal_retiro_id, sucursal_entrega_id) VALUES
( '2025-05-10 10:00:00', '2025-05-12 18:00:00', 50000, 1, 1, 1, 1, 1),   -- 1. Homero: Finalizada
( '2025-06-20 10:00:00', '2025-06-22 18:00:00', 60000, 2, 6, 2, 1, 2),   -- 2. Marge: Cancelada
( '2025-06-01 09:00:00', '2025-08-30 17:00:00', 300000, 3, 7, 3, 4, 4),   -- 3. Burns: Finalizada
( '3025-03-01 12:00:00', '3025-03-05 12:00:00', 4000000, 4, 4, 4, 3, 3),   -- 4. Bender: Finalizada con retraso
( '2025-07-04 10:00:00', '2025-07-10 18:00:00', 350000, 5, 5, 5, 3, 3),   -- 5. Fry: En Curso
( '2025-08-01 10:00:00', '2025-08-05 18:00:00', 120000, 6, 1, 6, 1, 1),   -- 6. Lisa: Futura Confirmada (Agosto)
( '2025-04-15 11:00:00', '2025-04-16 19:00:00', 40000, 7, 2, 7, 1, 1),   -- 7. Moe: Finalizada
( '2025-06-05 10:00:00', '2025-06-07 18:00:00', 80000, 9, 2, 8, 1, 2),   -- 8. Bart: Finalizada
( '2025-07-02 09:00:00', '2025-07-09 09:00:00', 175000, 10, 8, 9, 1, 1),  -- 9. Apu: En Curso
( '2025-07-20 10:00:00', '2025-07-22 10:00:00', 80000, 11, 2, 10, 1, 1),  -- 10. Flanders: Futura Confirmada
( '3024-01-01 10:00:00', '3024-01-10 10:00:00', 9000000, 12, 4, 11, 3, 3), -- 11. Profesor Farnsworth: Finalizada
( '3025-09-10 10:00:00', '3025-09-15 10:00:00', 5000000, 8, 4, 12, 3, 3),   -- 12. Leela: Futura Confirmada
( '2025-03-05 09:00:00', '2025-03-10 18:00:00', 250000, 1, 9, 13, 2, 2), -- 13. Homero: Finalizada (2da reserva)
( '2025-05-15 10:00:00', '2025-05-20 10:00:00', 200000, 9, 9, 14, 1, 2), -- 14. Bart: Finalizada (2da reserva)
( '2025-02-10 11:00:00', '2025-02-12 11:00:00', 50000, 7, 1, 15, 1, 1), -- 15. Moe: Finalizada (2da reserva)
( '2025-06-12 09:00:00', '2025-06-15 18:00:00', 75000, 1, 1, 16, 1, 1), -- 16. Homero: Finalizada (3ra reserva)
( '2025-08-10 10:00:00', '2025-08-15 18:00:00', 125000, 1, 6, 17, 2, 2), -- 17. Homero: Futura Confirmada (Agosto)
( '2025-08-20 09:00:00', '2025-08-22 18:00:00', 75000, 9, 10, 18, 1, 1); -- 18. Bart: Futura Confirmada (Agosto)


INSERT INTO Reservas_Estados_Reservas (reserva_id, estado_reserva_id, fecha_estado_reserva) VALUES
-- Historial Reserva 1 (Homero)
(1, 1, '2025-05-01 10:00:00'), -- Creada
(1, 2, '2025-05-02 11:00:00'), -- Confirmada
(1, 3, '2025-05-10 10:05:00'), -- En Curso
(1, 4, '2025-05-12 17:55:00'), -- Finalizada
-- Historial Reserva 2 (Marge)
(2, 1, '2025-06-10 15:00:00'), -- Creada
(2, 5, '2025-06-11 16:00:00'), -- Cancelada
-- Historial Reserva 3 (Burns)
(3, 1, '2025-05-20 09:00:00'), -- Creada
(3, 2, '2025-05-20 09:30:00'), -- Confirmada
(3, 3, '2025-06-01 09:05:00'), -- En Curso
(3, 4, '2025-08-30 16:50:00'), -- Finalizada
-- Historial Reserva 4 (Bender)
(4, 1, '3025-02-15 12:00:00'), -- Creada
(4, 2, '3025-02-16 13:00:00'), -- Confirmada
(4, 3, '3025-03-01 12:05:00'), -- En Curso
(4, 6, '3025-03-05 12:10:00'), -- Retrasada
(4, 4, '3025-03-07 18:00:00'), -- Finalizada
-- Historial Reserva 5 (Fry)
(5, 1, '2025-07-01 14:20:00'), -- Creada
(5, 2, '2025-07-02 10:00:00'), -- Confirmada
(5, 3, '2025-07-04 10:05:00'), -- En Curso
-- Historial Reserva 6 (Lisa)
(6, 1, '2025-07-04 17:00:00'), -- Creada
(6, 2, '2025-07-04 17:10:00'), -- Confirmada
-- Historial Reserva 7 (Moe)
(7, 1, '2025-04-10 09:00:00'), -- Creada
(7, 2, '2025-04-11 10:00:00'), -- Confirmada
(7, 3, '2025-04-15 11:05:00'), -- En Curso
(7, 4, '2025-04-16 18:50:00'), -- Finalizada
-- Historial Reserva 8 (Bart)
(8, 1, '2025-06-01 11:00:00'), -- Creada
(8, 2, '2025-06-01 11:30:00'), -- Confirmada
(8, 3, '2025-06-05 10:10:00'), -- En Curso
(8, 4, '2025-06-07 17:45:00'), -- Finalizada
-- Historial Reserva 9 (Apu)
(9, 1, '2025-06-30 08:00:00'), -- Creada
(9, 2, '2025-07-01 09:00:00'), -- Confirmada
(9, 3, '2025-07-02 09:05:00'), -- En Curso
-- Historial Reserva 10 (Flanders)
(10, 1, '2025-07-03 11:00:00'), -- Creada
(10, 2, '2025-07-04 11:15:00'), -- Confirmada
-- Historial Reserva 11 (Profesor Farnsworth)
(11, 1, '3023-12-20 10:00:00'), -- Creada
(11, 2, '3023-12-21 11:00:00'), -- Confirmada
(11, 3, '3024-01-01 10:05:00'), -- En Curso
(11, 4, '3024-01-10 10:05:00'), -- Finalizada
-- Historial Reserva 12 (Leela)
(12, 1, '3025-08-20 15:00:00'), -- Creada
(12, 2, '3025-08-21 10:00:00'), -- Confirmada
-- Historial Reserva 13 (Homero, 2da reserva)
(13, 1, '2025-03-01 10:00:00'), -- Creada
(13, 2, '2025-03-01 11:00:00'), -- Confirmada
(13, 3, '2025-03-05 09:05:00'), -- En Curso
(13, 4, '2025-03-10 17:50:00'), -- Finalizada
-- Historial Reserva 14 (Bart, 2da reserva)
(14, 1, '2025-05-10 12:00:00'), -- Creada
(14, 2, '2025-05-11 13:00:00'), -- Confirmada
(14, 3, '2025-05-15 10:05:00'), -- En Curso
(14, 4, '2025-05-20 09:55:00'), -- Finalizada
-- Historial Reserva 15 (Moe, 2da reserva)
(15, 1, '2025-02-05 14:00:00'), -- Creada
(15, 2, '2025-02-06 15:00:00'), -- Confirmada
(15, 3, '2025-02-10 11:05:00'), -- En Curso
(15, 4, '2025-02-12 10:45:00'), -- Finalizada
-- Historial Reserva 16 (Homero, 3ra reserva)
(16, 1, '2025-06-10 08:30:00'), -- Creada
(16, 2, '2025-06-10 08:45:00'), -- Confirmada
(16, 3, '2025-06-12 09:05:00'), -- En Curso
(16, 4, '2025-06-15 17:58:00'), -- Finalizada
-- Historial Reserva 17 (Homero, futura)
(17, 1, '2025-07-20 10:00:00'), -- Creada
(17, 2, '2025-07-21 11:00:00'), -- Confirmada
-- Historial Reserva 18 (Bart, futura)
(18, 1, '2025-07-25 09:00:00'), -- Creada
(18, 2, '2025-07-25 09:30:00');  -- Confirmada



