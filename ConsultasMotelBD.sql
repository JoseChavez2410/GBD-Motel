--CONSULTAS
--1. Mostrar las facturas emitidas en el mes de Octubre del año 2020.
select * from factura 
where to_char(fecha_factura, 'MM')='10' and to_char(fecha_factura, 'YYYY')='2020'

--2. Mostrar las reservas que se hicieron con la habitación Doble
select 
reserva.id_reserva,
(cliente.nombre_cliente || ' ' || cliente.apellido_cliente) as Cliente,
habitacion.numero_habitacion,
tipo_habitacion.descripcion_habitacion as descripcion,
reserva.fecha_reserva
from reserva
inner join cliente on reserva.id_cliente=cliente.id_cliente
inner join habitacion on reserva.id_habitacion=habitacion.id_habitacion
inner join tipo_habitacion on habitacion.id_tipo_habitacion=tipo_habitacion.id_tipo_habitacion
where tipo_habitacion.descripcion_habitacion='DOBLE'

--3. Mostrar al empleado con más servicios realizados junto al nombre del servicio.
select 
(empleado.nombre_empleado || ' ' || empleado.apellido_empleado) as Empleado,
tipo_servicio.nombre_tipo_servicio as servicio,
count (servicio) as servicios_realizados
from servicio
inner join empleado on servicio.id_empleado=empleado.id_empleado
inner join tipo_servicio on servicio.id_tipo_servicio=tipo_servicio.id_tipo_servicio
where servicio.estado_servicio_atendido=TRUE
group by Empleado, servicio
order by servicios_realizados desc limit 1

--4. Mostrar el número y el tipo de habitación que fue más solicitada mediante reserva.
select 
habitacion.numero_habitacion as Numero_Habitacion,
tipo_habitacion.descripcion_habitacion as Tipo
from reserva 
inner join habitacion on reserva.id_habitacion=habitacion.id_habitacion
inner join tipo_habitacion on habitacion.id_tipo_habitacion=tipo_habitacion.id_tipo_habitacion
group by Numero_Habitacion, Tipo, reserva.id_habitacion having count (reserva.id_habitacion)=
(select max(i.total) from(select count(reserva.id_habitacion) as total
from reserva 
group by reserva.id_habitacion)i)