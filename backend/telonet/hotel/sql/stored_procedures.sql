DELIMITER $$
--1
-- Listado de clientes y su nacionalidad
CREATE PROCEDURE ListadoClientesNacionalidad()
BEGIN
    SELECT 
        c.nombre AS Nombre,
        c.apellido AS Apellido,
        c.nacionalidad AS Nacionalidad
    FROM cliente c;
END$$

--2
CREATE PROCEDURE GetClientesConMasDeUnaReserva()
BEGIN
    DECLARE total INT;

    -- Contar cuántos clientes tienen más de una reserva
    SELECT COUNT(*) INTO total
    FROM (
        SELECT c.id_cliente
        FROM cliente c
        JOIN reserva r ON c.id_cliente = r.id_cliente_Cliente
        GROUP BY c.id_cliente
        HAVING COUNT(r.id_reserva) > 1
    ) AS subquery;

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            c.nombre AS NombreCliente, 
            c.apellido AS ApellidoCliente, 
            COUNT(r.id_reserva) AS ReservasTotales
        FROM cliente c
        JOIN reserva r ON c.id_cliente = r.id_cliente_Cliente
        GROUP BY c.id_cliente
        HAVING ReservasTotales > 1;
    ELSE
        SELECT 'No hay clientes con más de una reserva' AS Mensaje;
    END IF;
END$$

--3
-- Clientes con facturas pendientes
CREATE PROCEDURE ClientesConFacturasPendientes()
BEGIN
    DECLARE total INT;

    -- Contar clientes con facturas pendientes
    SELECT COUNT(*) INTO total
    FROM cliente c
    JOIN reserva r ON c.id_cliente = r.id_cliente_Cliente
    JOIN facturacion f ON f.id_reserva_Reserva = r.id_reserva
    WHERE f.estado = 'Pendiente';

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            CONCAT(c.nombre, ' ', c.apellido) AS Nombre
        FROM cliente c
        JOIN reserva r ON c.id_cliente = r.id_cliente_Cliente
        JOIN facturacion f ON f.id_reserva_Reserva = r.id_reserva
        WHERE f.estado = 'Pendiente';
    ELSE
        SELECT 'No hay clientes con facturas pendientes' AS Mensaje;
    END IF;
END$$

--4
-- Eventos y su número de asistentes
CREATE PROCEDURE EventosConAsistentes()
BEGIN
    SELECT 
        e.nombre AS NombreEvento,
        SUM(re.cantidad_asistente) AS TotalAsistentes
    FROM evento e
    JOIN reserva_evento re ON e.id_evento = re.id_evento_Evento
    GROUP BY e.id_evento;
END$$



-- 5
CREATE PROCEDURE GetFacturacionEventos()
BEGIN
    DECLARE total INT;

    -- Contar cuántos registros existen
    SELECT COUNT(*) INTO total
    FROM facturacion f
    JOIN reserva_evento re ON f.id_reserva_evento_Reserva_evento = re.id_reserva_evento
    JOIN evento e ON re.id_evento_Evento = e.id_evento;

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            e.nombre AS Evento, 
            f.fecha_emision AS FechaEmision, 
            f.monto_total AS MontoTotal
        FROM facturacion f
        JOIN reserva_evento re ON f.id_reserva_evento_Reserva_evento = re.id_reserva_evento
        JOIN evento e ON re.id_evento_Evento = e.id_evento;
    ELSE
        SELECT 'No hay datos de facturación para eventos' AS Mensaje;
    END IF;
END$$


-- 6 eventos y el promedio de asistentes 
CREATE PROCEDURE GetPromedioAsistentesPorEvento()
BEGIN
    DECLARE total INT;

    -- Contar registros existentes
    SELECT COUNT(*) INTO total
    FROM evento e
    JOIN reserva_evento re ON e.id_evento = re.id_evento_Evento;

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            e.nombre AS Evento, 
            AVG(re.cantidad_asistente) AS PromedioAsistentes
        FROM evento e
        JOIN reserva_evento re ON e.id_evento = re.id_evento_Evento
        GROUP BY e.id_evento;
    ELSE
        SELECT 'No hay datos para calcular el promedio de asistentes por evento' AS Mensaje;
    END IF;
END$$

-- 7
-- Obtener promociones activas
CREATE PROCEDURE GetPromocionesActivas()
BEGIN
    SELECT 
        p.id_promocion AS PromocionID,
        p.nombre_promo AS NombrePromocion,
        p.descripcion AS Descripcion,
        p.fecha_inicio AS FechaInicio,
        p.fecha_fin AS FechaFin,
        p.porcentaje_descuento AS PorcentajeDescuento,
        p.area_aplicacion AS AreaAplicacion
    FROM promociones p
    WHERE p.estado = 'Activo';
END$$

-- 8 Ingresos Totales por cada evento

CREATE PROCEDURE GetPromocionesActivasPorEvento()
BEGIN
    DECLARE total INT;

    -- Contar registros existentes
    SELECT COUNT(*) INTO total
    FROM promociones p
    JOIN hotel_promociones hp ON p.id_promocion = hp.id_promocion_Promociones
    JOIN hotel_seccion hs ON hp.id_hotel_Hotel = hs.id_hotel_Hotel
    JOIN evento e ON hs.id_evento_Evento = e.id_evento
    WHERE p.area_aplicacion = 'Eventos' AND p.estado = 'Activo';

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            e.nombre AS Evento, 
            p.nombre_promo AS NombrePromocion
        FROM promociones p
        JOIN hotel_promociones hp ON p.id_promocion = hp.id_promocion_Promociones
        JOIN hotel_seccion hs ON hp.id_hotel_Hotel = hs.id_hotel_Hotel
        JOIN evento e ON hs.id_evento_Evento = e.id_evento
        WHERE p.area_aplicacion = 'Eventos' AND p.estado = 'Activo';
    ELSE
        SELECT 'No hay promociones activas aplicables a eventos' AS Mensaje;
    END IF;
END$$



-- 9
-- Facturación total por método de pago
CREATE PROCEDURE FacturacionPorMetodoPago()
BEGIN
    SELECT 
        f.metodo_pago AS MetodoPago,
        SUM(f.monto_total) AS TotalFacturado
    FROM facturacion f
    GROUP BY f.metodo_pago;
END$$

-- 10 
-- Total de ingresos por servicios en facturación
CREATE PROCEDURE IngresosPorServicios()
BEGIN
    SELECT 
        s.nombre AS NombreServicio,
        SUM(f.monto_total) AS TotalIngresos
    FROM servicio s
    JOIN facturacion f ON s.id_servicio = f.id_servicio_Servicio
    GROUP BY s.id_servicio;
END$$
 
--11 Detalles de facturación por eventos

CREATE PROCEDURE GetFacturacionPorEvento()
BEGIN
    DECLARE total INT;

    -- Contar registros existentes
    SELECT COUNT(*) INTO total
    FROM facturacion f
    JOIN reserva_evento re ON f.id_reserva_evento_Reserva_evento = re.id_reserva_evento
    JOIN evento e ON re.id_evento_Evento = e.id_evento;

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            e.nombre AS Evento, 
            f.fecha_emision AS FechaEmision, 
            f.monto_total AS MontoTotal
        FROM facturacion f
        JOIN reserva_evento re ON f.id_reserva_evento_Reserva_evento = re.id_reserva_evento
        JOIN evento e ON re.id_evento_Evento = e.id_evento;
    ELSE
        SELECT 'No hay datos de facturación para eventos' AS Mensaje;
    END IF;
END$$


--12
-- Total de reservas y monto total pagado por cada cliente
CREATE PROCEDURE TotalReservasPorCliente()
BEGIN
    SELECT 
        c.nombre AS NombreCliente,
        c.apellido AS ApellidoCliente,
        COUNT(r.id_reserva) AS TotalReservas,
        SUM(r.monto_total) AS TotalPagado
    FROM cliente c
    JOIN reserva r ON c.id_cliente = r.id_cliente_Cliente
    GROUP BY c.id_cliente;
END$$


--13 Facturación por hotel
CREATE PROCEDURE GetTotalFacturacionPorHotel()
BEGIN
    DECLARE total INT;

    -- Contar cuántos registros existen
    SELECT COUNT(*) INTO total
    FROM hotel h
    JOIN habitacion ha ON h.id_hotel = ha.id_hotel_Hotel
    JOIN reserva r ON ha.id_habitacion = r.id_habitacion_Habitacion
    JOIN facturacion f ON r.id_reserva = f.id_reserva_Reserva;

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            h.nombre AS Hotel, 
            SUM(f.monto_total) AS TotalFacturacion
        FROM hotel h
        JOIN habitacion ha ON h.id_hotel = ha.id_hotel_Hotel
        JOIN reserva r ON ha.id_habitacion = r.id_habitacion_Habitacion
        JOIN facturacion f ON r.id_reserva = f.id_reserva_Reserva
        GROUP BY h.id_hotel;
    ELSE
        SELECT 'No hay datos de facturación por hotel' AS Mensaje;
    END IF;
END$$


--14 Ingresos por mes en facturación

CREATE PROCEDURE GetIngresosMensuales()
BEGIN
    DECLARE total INT;

    -- Contar registros existentes
    SELECT COUNT(*) INTO total
    FROM facturacion;

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            MONTH(fecha_emision) AS Mes, 
            SUM(monto_total) AS Ingresos
        FROM facturacion
        GROUP BY Mes;
    ELSE
        SELECT 'No hay datos de facturación disponibles para calcular ingresos mensuales' AS Mensaje;
    END IF;
END$$


--15
-- Promociones activas aplicadas en hoteles
CREATE PROCEDURE PromocionesActivasHoteles()
BEGIN
    SELECT 
        h.nombre AS NombreHotel,
        p.nombre_promo AS NombrePromocion,
        p.estado AS EstadoPromocion
    FROM hotel h
    JOIN hotel_promociones hp ON h.id_hotel = hp.id_hotel_Hotel
    JOIN promociones p ON hp.id_promocion_Promociones = p.id_promocion
    WHERE p.estado = 'Activo';
END$$



--17 lista de habitaciones ocupadas por hotel
CREATE PROCEDURE GetHabitacionesOcupadasPorHotel()
BEGIN
    DECLARE total INT;

    -- Contar registros existentes
    SELECT COUNT(*) INTO total
    FROM hotel h
    JOIN habitacion ha ON h.id_hotel = ha.id_hotel_Hotel
    WHERE ha.estado = 'Ocupada';

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            h.nombre AS Hotel, 
            COUNT(ha.id_habitacion) AS HabitacionesOcupadas
        FROM hotel h
        JOIN habitacion ha ON h.id_hotel = ha.id_hotel_Hotel
        WHERE ha.estado = 'Ocupada'
        GROUP BY h.id_hotel;
    ELSE
        SELECT 'No hay habitaciones ocupadas registradas por hotel' AS Mensaje;
    END IF;
END$$

--18 Habitaciones en mantenimiento
CREATE PROCEDURE GetHabitacionesEnMantenimiento()
BEGIN
    DECLARE total INT;

    -- Contar registros existentes
    SELECT COUNT(*) INTO total
    FROM habitacion
    WHERE estado = 'Mantenimiento';

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            nro_habitacion AS NumeroHabitacion
        FROM habitacion
        WHERE estado = 'Mantenimiento';
    ELSE
        SELECT 'No hay habitaciones en mantenimiento' AS Mensaje;
    END IF;
END$$


--19 Cantidad de promociones por hotel

CREATE PROCEDURE GetPromocionesTotalesPorHotel()
BEGIN
    DECLARE total INT;

    -- Contar registros existentes
    SELECT COUNT(*) INTO total
    FROM hotel h
    JOIN hotel_promociones hp ON h.id_hotel = hp.id_hotel_Hotel;

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            h.nombre AS Hotel, 
            COUNT(hp.id_promocion_Promociones) AS PromocionesTotales
        FROM hotel h
        JOIN hotel_promociones hp ON h.id_hotel = hp.id_hotel_Hotel
        GROUP BY h.id_hotel;
    ELSE
        SELECT 'No hay datos de promociones registradas por hotel' AS Mensaje;
    END IF;
END$$


--20 
-- Artículos con más de 50 unidades en el inventario
CREATE PROCEDURE InventarioMayorA50()
BEGIN
    SELECT 
        i.nombre_articulo AS NombreArticulo,
        i.cantidad AS CantidadDisponible
    FROM inventario i
    WHERE i.cantidad > 50;
END$$

--21 Articulos en inventario por proveedor
CREATE PROCEDURE GetInventarioPorProveedor()
BEGIN
    DECLARE total INT;

    -- Contar registros existentes
    SELECT COUNT(*) INTO total
    FROM proveedor p
    JOIN inventario i ON p.id_proveedor = i.id_proveedor_Proveedor;

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            p.nombre AS Proveedor, 
            i.nombre_articulo AS NombreArticulo, 
            i.cantidad AS Cantidad
        FROM proveedor p
        JOIN inventario i ON p.id_proveedor = i.id_proveedor_Proveedor;
    ELSE
        SELECT 'No hay datos de inventario por proveedor' AS Mensaje;
    END IF;
END$$

--22 
-- Obtener servicios disponibles
CREATE PROCEDURE GetServiciosDisponibles()
BEGIN
    SELECT 
        s.id_servicio AS ServicioID,
        s.nombre AS NombreServicio,
        s.descripcion AS Descripcion,
        s.precio AS Precio
    FROM servicio s;
END$$


--Mas Consultas:
DELIMITER $$

-- Obtener información de clientes
CREATE PROCEDURE GetClientes()
BEGIN
    SELECT 
        id_cliente AS ClienteID,
        nombre AS Nombre,
        apellido AS Apellido,
        correo AS Correo,
        nacionalidad AS Nacionalidad,
        fecha_nacimiento AS FechaNacimiento,
        DNI AS Documento
    FROM cliente;
END$$

-- Obtener habitaciones disponibles en un hotel específico
CREATE PROCEDURE GetHabitacionesDisponibles(IN hotel_id INT)
BEGIN
    SELECT 
        h.id_habitacion AS HabitacionID,
        h.nro_habitacion AS NumeroHabitacion,
        th.nombre_tipo AS TipoHabitacion,
        th.precio_noche AS PrecioPorNoche,
        th.capacidad AS Capacidad
    FROM habitacion h
    JOIN tipo_habitacion th ON h.id_tipo_habitacion_Tipo_habitacion = th.id_tipo_habitacion
    WHERE h.estado = 'Disponible' AND h.id_hotel_Hotel = hotel_id;
END$$

-- Obtener reservas activas por cliente
CREATE PROCEDURE GetReservasActivasCliente(IN cliente_id INT)
BEGIN
    SELECT 
        r.id_reserva AS ReservaID,
        r.fecha_entrada AS FechaEntrada,
        r.fecha_salida AS FechaSalida,
        r.monto_total AS MontoTotal,
        r.estado AS EstadoReserva
    FROM reserva r
    WHERE r.id_cliente_Cliente = cliente_id AND r.estado = 'Confirmada';
END$$

-- Obtener eventos programados en un hotel específico
CREATE PROCEDURE GetEventosHotel(IN hotel_id INT)
BEGIN
    SELECT 
        e.id_evento AS EventoID,
        e.nombre AS NombreEvento,
        e.fecha AS FechaEvento,
        e.descripcion AS Descripcion,
        e.precio AS Precio
    FROM evento e
    JOIN hotel_seccion hs ON hs.id_evento_Evento = e.id_evento
    WHERE hs.id_hotel_Hotel = hotel_id;
END$$

-- Facturación por cliente
CREATE PROCEDURE GetFacturacionCliente(IN cliente_id INT)
BEGIN
    SELECT 
        f.id_facturacion AS FacturaID,
        f.fecha_emision AS FechaEmision,
        f.monto_total AS MontoTotal,
        f.metodo_pago AS MetodoPago,
        f.estado AS EstadoFactura
    FROM facturacion f
    JOIN reserva r ON f.id_reserva_Reserva = r.id_reserva
    WHERE r.id_cliente_Cliente = cliente_id;
END$$

-- Obtener servicios disponibles
CREATE PROCEDURE GetServiciosDisponibles()
BEGIN
    SELECT 
        s.id_servicio AS ServicioID,
        s.nombre AS NombreServicio,
        s.descripcion AS Descripcion,
        s.precio AS Precio
    FROM servicio s;
END$$


-- Historial de cambios por empleado
CREATE PROCEDURE GetHistorialCambiosEmpleado(IN empleado_id INT)
BEGIN
    SELECT 
        hc.id_historial_cambio AS CambioID,
        hc.fecha_modificacion AS FechaModificacion,
        hc.campo_modificado AS CampoModificado,
        hc.valor_anterior AS ValorAnterior,
        hc.nuevo_valor AS NuevoValor
    FROM historial_cambios hc
    WHERE hc.id_empleado_Empleado = empleado_id;
END$$

-- Todas las habitaciones disponibles y sus promociones (si tienen)
CREATE PROCEDURE GetHabitacionesYPromociones(IN hotel_id INT)
BEGIN
    SELECT 
        h.id_habitacion AS HabitacionID,
        h.nro_habitacion AS NumeroHabitacion,
        th.nombre_tipo AS TipoHabitacion,
        th.precio_noche AS PrecioPorNoche,
        th.capacidad AS Capacidad,
        IF(p.id_promocion IS NOT NULL, p.nombre_promo, 'Sin promoción') AS Promocion,
        IF(p.id_promocion IS NOT NULL, ROUND(th.precio_noche * (1 - (p.porcentaje_descuento / 100)), 2), th.precio_noche) AS PrecioConDescuento
    FROM habitacion h
    JOIN tipo_habitacion th ON h.id_tipo_habitacion_Tipo_habitacion = th.id_tipo_habitacion
    LEFT JOIN hotel_promociones hp ON h.id_hotel_Hotel = hp.id_hotel_Hotel
    LEFT JOIN promociones p ON hp.id_promocion_Promociones = p.id_promocion AND p.estado = 'Activo'
    WHERE h.estado = 'Disponible' AND h.id_hotel_Hotel = hotel_id;
END$$


-- Promedio de precio por tipo de habitación
CREATE PROCEDURE PromedioPrecioTipoHabitacion()
BEGIN
    SELECT 
        th.nombre_tipo AS TipoHabitacion,
        AVG(th.precio_noche) AS PrecioPromedio
    FROM tipo_habitacion th
    GROUP BY th.nombre_tipo;
END$$


-- Reservas con al menos 3 personas
CREATE PROCEDURE ReservasConMinimo3Personas()
BEGIN
    SELECT 
        r.*
    FROM reserva r
    WHERE r.no_personas >= 3;
END$$


-- Lista de empleados y su puesto en cada hotel
CREATE PROCEDURE EmpleadosPorHotel()
BEGIN
    SELECT 
        h.nombre AS NombreHotel,
        GROUP_CONCAT(CONCAT(e.nombre, ' ', e.apellido)) AS ListaEmpleados
    FROM empleado e
    JOIN hotel h ON e.id_hotel_Hotel = h.id_hotel
    GROUP BY h.id_hotel;
END$$


-- Habitaciones disponibles con promociones
CREATE PROCEDURE HabitacionesDisponiblesConPromociones(IN hotel_id INT)
BEGIN
    SELECT 
        h.id_habitacion AS HabitacionID,
        h.nro_habitacion AS NumeroHabitacion,
        th.nombre_tipo AS TipoHabitacion,
        th.precio_noche AS PrecioOriginal,
        IF(p.id_promocion IS NOT NULL, p.nombre_promo, 'Sin Promoción') AS Promocion,
        IF(p.id_promocion IS NOT NULL, 
           ROUND(th.precio_noche * (1 - (p.porcentaje_descuento / 100)), 2), 
           th.precio_noche) AS PrecioConDescuento
    FROM habitacion h
    JOIN tipo_habitacion th ON h.id_tipo_habitacion_Tipo_habitacion = th.id_tipo_habitacion
    LEFT JOIN hotel_promociones hp ON h.id_hotel_Hotel = hp.id_hotel_Hotel
    LEFT JOIN promociones p ON hp.id_promocion_Promociones = p.id_promocion AND p.estado = 'Activo'
    WHERE h.estado = 'Disponible' AND h.id_hotel_Hotel = hotel_id;
END$$



CREATE PROCEDURE GetTotalPagadoPorReserva()
BEGIN
    DECLARE total INT;

    -- Contar cuántos registros existen
    SELECT COUNT(*) INTO total
    FROM reserva r
    JOIN facturacion f ON r.id_reserva = f.id_reserva_Reserva;

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            r.id_reserva AS IdReserva, 
            SUM(f.monto_total) AS TotalPagado
        FROM reserva r
        JOIN facturacion f ON r.id_reserva = f.id_reserva_Reserva
        GROUP BY r.id_reserva;
    ELSE
        SELECT 'No hay datos de facturación por reservas' AS Mensaje;
    END IF;
END$$


CREATE PROCEDURE GetIngresosTotalesPorEvento()
BEGIN
    DECLARE total INT;

    -- Contar registros existentes
    SELECT COUNT(*) INTO total
    FROM evento e
    JOIN reserva_evento re ON e.id_evento = re.id_evento_Evento;

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            e.nombre AS Evento, 
            SUM(re.monto_total) AS IngresosTotales
        FROM evento e
        JOIN reserva_evento re ON e.id_evento = re.id_evento_Evento
        GROUP BY e.id_evento;
    ELSE
        SELECT 'No hay datos de ingresos por evento' AS Mensaje;
    END IF;
END$$

CREATE PROCEDURE GetProveedoresConMasDeUnCliente()
BEGIN
    DECLARE total INT;

    -- Contar registros existentes
    SELECT COUNT(*) INTO total
    FROM proveedor p
    JOIN cliente_proveedor cp ON p.id_proveedor = cp.id_proveedor_Proveedor
    GROUP BY p.id_proveedor
    HAVING COUNT(cp.id_cliente_Cliente) > 1;

    -- Verificar si hay resultados
    IF total > 0 THEN
        SELECT 
            p.nombre AS Proveedor, 
            COUNT(cp.id_cliente_Cliente) AS TotalClientes
        FROM proveedor p
        JOIN cliente_proveedor cp ON p.id_proveedor = cp.id_proveedor_Proveedor
        GROUP BY p.id_proveedor
        HAVING TotalClientes > 1;
    ELSE
        SELECT 'No hay proveedores con más de un cliente' AS Mensaje;
    END IF;
END$$

DELIMITER ;