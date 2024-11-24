CREATE DATABASE telonet;
USE telonet;

CREATE TABLE actividad (
  id_actividad int(11) NOT NULL,
  nombre varchar(100) DEFAULT NULL,
  descripcion text DEFAULT NULL,
  precio decimal(10,2) DEFAULT NULL,
  id_reserva_actividad_Reserva_actividad int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla cliente
--

CREATE TABLE cliente (
  id_cliente int(11) NOT NULL,
  nombre varchar(100) DEFAULT NULL,
  apellido varchar(100) DEFAULT NULL,
  correo varchar(100) DEFAULT NULL,
  nacionalidad varchar(50) DEFAULT NULL,
  contraseña varchar(100) DEFAULT NULL,
  fecha_nacimiento date DEFAULT NULL,
  DNI varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla cliente_proveedor
--

CREATE TABLE cliente_proveedor (
  id_cliente_Cliente int(11) NOT NULL,
  id_proveedor_Proveedor int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla cliente_reserva_evento
--

CREATE TABLE cliente_reserva_evento (
  id_cliente_Cliente int(11) NOT NULL,
  id_reserva_evento_Reserva_evento int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla cliente_telefono
--

CREATE TABLE cliente_telefono (
  id_cliente_Cliente int(11) DEFAULT NULL,
  telefonos varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla empleado
--

CREATE TABLE empleado (
  id_empleado int(11) NOT NULL,
  nombre varchar(100) DEFAULT NULL,
  apellido varchar(100) DEFAULT NULL,
  correo varchar(100) DEFAULT NULL,
  puesto varchar(50) DEFAULT NULL,
  id_hotel_Hotel int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla empleado_telefono
--

CREATE TABLE empleado_telefono (
  id_empleado_Empleado int(11) DEFAULT NULL,
  telefonos varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla evento
--

CREATE TABLE evento (
  id_evento int(11) NOT NULL,
  nombre varchar(100) DEFAULT NULL,
  fecha date DEFAULT NULL,
  descripcion text DEFAULT NULL,
  precio decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla facturacion
--

CREATE TABLE facturacion (
  id_facturacion int(11) NOT NULL,
  fecha_emision date DEFAULT NULL,
  metodo_pago varchar(50) DEFAULT NULL,
  monto_total decimal(10,2) DEFAULT NULL,
  descripcion text DEFAULT NULL,
  estado varchar(20) DEFAULT NULL,
  id_reserva_Reserva int(11) DEFAULT NULL,
  id_reserva_evento_Reserva_evento int(11) DEFAULT NULL,
  id_servicio_Servicio int(11) DEFAULT NULL,
  id_reserva_actividad_Reserva_actividad int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla habitacion
--

CREATE TABLE habitacion (
  id_habitacion int(11) NOT NULL,
  nro_habitacion int(11) DEFAULT NULL,
  estado varchar(20) DEFAULT NULL,
  id_hotel_Hotel int(11) DEFAULT NULL,
  id_tipo_habitacion_Tipo_habitacion int(11) DEFAULT NULL,
  id_reserva_Reserva int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla historial_cambios
--

CREATE TABLE historial_cambios (
  id_historial_cambio int(11) NOT NULL,
  fecha_modificacion date DEFAULT NULL,
  campo_modificado varchar(100) DEFAULT NULL,
  estado varchar(20) DEFAULT NULL,
  valor_anterior text DEFAULT NULL,
  nuevo_valor text DEFAULT NULL,
  id_empleado_Empleado int(11) DEFAULT NULL,
  id_reserva_Reserva int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla hotel
--

CREATE TABLE hotel (
  id_hotel int(11) NOT NULL,
  nombre varchar(100) DEFAULT NULL,
  direccion varchar(255) DEFAULT NULL,
  correo varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla hotel_promociones
--

CREATE TABLE hotel_promociones (
  id_hotel_Hotel int(11) NOT NULL,
  id_promocion_Promociones int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla hotel_seccion
--

CREATE TABLE hotel_seccion (
  id_hotel_Hotel int(11) NOT NULL,
  id_evento_Evento int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla hotel_telefono
--

CREATE TABLE hotel_telefono (
  id_hotel_Hotel int(11) DEFAULT NULL,
  telefonos varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla inventario
--

CREATE TABLE inventario (
  id_inventario int(11) NOT NULL,
  nombre_articulo varchar(100) DEFAULT NULL,
  precio_articulo decimal(10,2) DEFAULT NULL,
  fecha_adquisicion date DEFAULT NULL,
  descripcion text DEFAULT NULL,
  cantidad int(11) DEFAULT NULL,
  id_proveedor_Proveedor int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla promociones
--

CREATE TABLE promociones (
  id_promocion int(11) NOT NULL,
  nombre_promo varchar(100) DEFAULT NULL,
  descripcion text DEFAULT NULL,
  fecha_inicio date DEFAULT NULL,
  fecha_fin date DEFAULT NULL,
  porcentaje_descuento decimal(5,2) DEFAULT NULL,
  area_aplicacion varchar(50) DEFAULT NULL,
  estado varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla proveedor
--

CREATE TABLE proveedor (
  id_proveedor int(11) NOT NULL,
  nombre varchar(100) DEFAULT NULL,
  tipo_producto varchar(50) DEFAULT NULL,
  contacto varchar(100) DEFAULT NULL,
  correo varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla proveedor_telefono
--

CREATE TABLE proveedor_telefono (
  id_proveedor_Proveedor int(11) DEFAULT NULL,
  telefonos varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla reserva
--

CREATE TABLE reserva (
  id_reserva int(11) NOT NULL,
  monto_total decimal(10,2) DEFAULT NULL,
  metodo_pago varchar(50) DEFAULT NULL,
  no_personas int(11) DEFAULT NULL,
  fecha_salida date DEFAULT NULL,
  fecha_entrada date DEFAULT NULL,
  fecha_reserva date DEFAULT NULL,
  estado varchar(20) DEFAULT NULL,
  id_cliente_Cliente int(11) DEFAULT NULL,
  promociones int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla reserva_actividad
--

CREATE TABLE reserva_actividad (
  id_reserva_actividad int(11) NOT NULL,
  fecha_reserva date DEFAULT NULL,
  monto_total decimal(10,2) DEFAULT NULL,
  id_cliente_Cliente int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla reserva_evento
--

CREATE TABLE reserva_evento (
  id_reserva_evento int(11) NOT NULL,
  fecha_reserva date DEFAULT NULL,
  cantidad_asistente int(11) DEFAULT NULL,
  monto_total decimal(10,2) DEFAULT NULL,
  id_evento_Evento int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla servicio
--

CREATE TABLE servicio (
  id_servicio int(11) NOT NULL,
  nombre varchar(100) DEFAULT NULL,
  descripcion text DEFAULT NULL,
  precio decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla tipo_habitacion
--

CREATE TABLE tipo_habitacion (
  id_tipo_habitacion int(11) NOT NULL,
  nombre_tipo varchar(50) DEFAULT NULL,
  descripcion text DEFAULT NULL,
  precio_noche decimal(10,2) DEFAULT NULL,
  capacidad int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla actividad
--
ALTER TABLE actividad
  ADD PRIMARY KEY (id_actividad),
  ADD KEY id_reserva_actividad_Reserva_actividad (id_reserva_actividad_Reserva_actividad);

--
-- Indices de la tabla cliente
--
ALTER TABLE cliente
  ADD PRIMARY KEY (id_cliente);

--
-- Indices de la tabla cliente_proveedor
--
ALTER TABLE cliente_proveedor
  ADD PRIMARY KEY (id_cliente_Cliente,id_proveedor_Proveedor),
  ADD KEY id_proveedor_Proveedor (id_proveedor_Proveedor);

--
-- Indices de la tabla cliente_reserva_evento
--
ALTER TABLE cliente_reserva_evento
  ADD PRIMARY KEY (id_cliente_Cliente,id_reserva_evento_Reserva_evento),
  ADD KEY id_reserva_evento_Reserva_evento (id_reserva_evento_Reserva_evento);

--
-- Indices de la tabla cliente_telefono
--
ALTER TABLE cliente_telefono
  ADD KEY id_cliente_Cliente (id_cliente_Cliente);

--
-- Indices de la tabla empleado
--
ALTER TABLE empleado
  ADD PRIMARY KEY (id_empleado),
  ADD KEY id_hotel_Hotel (id_hotel_Hotel);

--
-- Indices de la tabla empleado_telefono
--
ALTER TABLE empleado_telefono
  ADD KEY id_empleado_Empleado (id_empleado_Empleado);

--
-- Indices de la tabla evento
--
ALTER TABLE evento
  ADD PRIMARY KEY (id_evento);

--
-- Indices de la tabla facturacion
--
ALTER TABLE facturacion
  ADD PRIMARY KEY (id_facturacion),
  ADD KEY id_reserva_Reserva (id_reserva_Reserva),
  ADD KEY id_reserva_evento_Reserva_evento (id_reserva_evento_Reserva_evento),
  ADD KEY id_servicio_Servicio (id_servicio_Servicio),
  ADD KEY id_reserva_actividad_Reserva_actividad (id_reserva_actividad_Reserva_actividad);

--
-- Indices de la tabla habitacion
--
ALTER TABLE habitacion
  ADD PRIMARY KEY (id_habitacion),
  ADD KEY id_hotel_Hotel (id_hotel_Hotel),
  ADD KEY id_tipo_habitacion_Tipo_habitacion (id_tipo_habitacion_Tipo_habitacion),
  ADD KEY id_reserva_Reserva (id_reserva_Reserva);

--
-- Indices de la tabla historial_cambios
--
ALTER TABLE historial_cambios
  ADD PRIMARY KEY (id_historial_cambio),
  ADD KEY id_empleado_Empleado (id_empleado_Empleado),
  ADD KEY id_reserva_Reserva (id_reserva_Reserva);

--
-- Indices de la tabla hotel
--
ALTER TABLE hotel
  ADD PRIMARY KEY (id_hotel);

--
-- Indices de la tabla hotel_promociones
--
ALTER TABLE hotel_promociones
  ADD PRIMARY KEY (id_hotel_Hotel,id_promocion_Promociones),
  ADD KEY id_promocion_Promociones (id_promocion_Promociones);

--
-- Indices de la tabla hotel_seccion
--
ALTER TABLE hotel_seccion
  ADD PRIMARY KEY (id_hotel_Hotel,id_evento_Evento),
  ADD KEY id_evento_Evento (id_evento_Evento);

--
-- Indices de la tabla hotel_telefono
--
ALTER TABLE hotel_telefono
  ADD KEY id_hotel_Hotel (id_hotel_Hotel);

--
-- Indices de la tabla inventario
--
ALTER TABLE inventario
  ADD PRIMARY KEY (id_inventario),
  ADD KEY id_proveedor_Proveedor (id_proveedor_Proveedor);

--
-- Indices de la tabla promociones
--
ALTER TABLE promociones
  ADD PRIMARY KEY (id_promocion);

--
-- Indices de la tabla proveedor
--
ALTER TABLE proveedor
  ADD PRIMARY KEY (id_proveedor);

--
-- Indices de la tabla proveedor_telefono
--
ALTER TABLE proveedor_telefono
  ADD KEY id_proveedor_Proveedor (id_proveedor_Proveedor);

--
-- Indices de la tabla reserva
--
ALTER TABLE reserva
  ADD PRIMARY KEY (id_reserva),
  ADD KEY id_cliente_Cliente (id_cliente_Cliente),
  ADD KEY fk_promociones (promociones);

--
-- Indices de la tabla reserva_actividad
--
ALTER TABLE reserva_actividad
  ADD PRIMARY KEY (id_reserva_actividad),
  ADD KEY id_cliente_Cliente (id_cliente_Cliente);

--
-- Indices de la tabla reserva_evento
--
ALTER TABLE reserva_evento
  ADD PRIMARY KEY (id_reserva_evento),
  ADD KEY id_evento_Evento (id_evento_Evento);

--
-- Indices de la tabla servicio
--
ALTER TABLE servicio
  ADD PRIMARY KEY (id_servicio);

--
-- Indices de la tabla tipo_habitacion
--
ALTER TABLE tipo_habitacion
  ADD PRIMARY KEY (id_tipo_habitacion);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla actividad
--
ALTER TABLE actividad
  ADD CONSTRAINT actividad_ibfk_1 FOREIGN KEY (id_reserva_actividad_Reserva_actividad) REFERENCES reserva_actividad (id_reserva_actividad);

--
-- Filtros para la tabla cliente_proveedor
--
ALTER TABLE cliente_proveedor
  ADD CONSTRAINT cliente_proveedor_ibfk_1 FOREIGN KEY (id_cliente_Cliente) REFERENCES cliente (id_cliente),
  ADD CONSTRAINT cliente_proveedor_ibfk_2 FOREIGN KEY (id_proveedor_Proveedor) REFERENCES proveedor (id_proveedor);

--
-- Filtros para la tabla cliente_reserva_evento
--
ALTER TABLE cliente_reserva_evento
  ADD CONSTRAINT cliente_reserva_evento_ibfk_1 FOREIGN KEY (id_cliente_Cliente) REFERENCES cliente (id_cliente),
  ADD CONSTRAINT cliente_reserva_evento_ibfk_2 FOREIGN KEY (id_reserva_evento_Reserva_evento) REFERENCES reserva_evento (id_reserva_evento);

--
-- Filtros para la tabla cliente_telefono
--
ALTER TABLE cliente_telefono
  ADD CONSTRAINT cliente_telefono_ibfk_1 FOREIGN KEY (id_cliente_Cliente) REFERENCES cliente (id_cliente);

--
-- Filtros para la tabla empleado
--
ALTER TABLE empleado
  ADD CONSTRAINT empleado_ibfk_1 FOREIGN KEY (id_hotel_Hotel) REFERENCES hotel (id_hotel);

--
-- Filtros para la tabla empleado_telefono
--
ALTER TABLE empleado_telefono
  ADD CONSTRAINT empleado_telefono_ibfk_1 FOREIGN KEY (id_empleado_Empleado) REFERENCES empleado (id_empleado);

--
-- Filtros para la tabla facturacion
--
ALTER TABLE facturacion
  ADD CONSTRAINT facturacion_ibfk_1 FOREIGN KEY (id_reserva_Reserva) REFERENCES reserva (id_reserva),
  ADD CONSTRAINT facturacion_ibfk_2 FOREIGN KEY (id_reserva_evento_Reserva_evento) REFERENCES reserva_evento (id_reserva_evento),
  ADD CONSTRAINT facturacion_ibfk_3 FOREIGN KEY (id_servicio_Servicio) REFERENCES servicio (id_servicio),
  ADD CONSTRAINT facturacion_ibfk_4 FOREIGN KEY (id_reserva_actividad_Reserva_actividad) REFERENCES reserva_actividad (id_reserva_actividad);

--
-- Filtros para la tabla habitacion
--
ALTER TABLE habitacion
  ADD CONSTRAINT habitacion_ibfk_1 FOREIGN KEY (id_hotel_Hotel) REFERENCES hotel (id_hotel),
  ADD CONSTRAINT habitacion_ibfk_2 FOREIGN KEY (id_tipo_habitacion_Tipo_habitacion) REFERENCES tipo_habitacion (id_tipo_habitacion),
  ADD CONSTRAINT habitacion_ibfk_3 FOREIGN KEY (id_reserva_Reserva) REFERENCES reserva (id_reserva);

--
-- Filtros para la tabla historial_cambios
--
ALTER TABLE historial_cambios
  ADD CONSTRAINT historial_cambios_ibfk_1 FOREIGN KEY (id_empleado_Empleado) REFERENCES empleado (id_empleado),
  ADD CONSTRAINT historial_cambios_ibfk_2 FOREIGN KEY (id_reserva_Reserva) REFERENCES reserva (id_reserva);

--
-- Filtros para la tabla hotel_promociones
--
ALTER TABLE hotel_promociones
  ADD CONSTRAINT hotel_promociones_ibfk_1 FOREIGN KEY (id_hotel_Hotel) REFERENCES hotel (id_hotel),
  ADD CONSTRAINT hotel_promociones_ibfk_2 FOREIGN KEY (id_promocion_Promociones) REFERENCES promociones (id_promocion);

--
-- Filtros para la tabla hotel_seccion
--
ALTER TABLE hotel_seccion
  ADD CONSTRAINT hotel_seccion_ibfk_1 FOREIGN KEY (id_hotel_Hotel) REFERENCES hotel (id_hotel),
  ADD CONSTRAINT hotel_seccion_ibfk_2 FOREIGN KEY (id_evento_Evento) REFERENCES evento (id_evento);

--
-- Filtros para la tabla hotel_telefono
--
ALTER TABLE hotel_telefono
  ADD CONSTRAINT hotel_telefono_ibfk_1 FOREIGN KEY (id_hotel_Hotel) REFERENCES hotel (id_hotel);

--
-- Filtros para la tabla inventario
--
ALTER TABLE inventario
  ADD CONSTRAINT inventario_ibfk_1 FOREIGN KEY (id_proveedor_Proveedor) REFERENCES proveedor (id_proveedor);

--
-- Filtros para la tabla proveedor_telefono
--
ALTER TABLE proveedor_telefono
  ADD CONSTRAINT proveedor_telefono_ibfk_1 FOREIGN KEY (id_proveedor_Proveedor) REFERENCES proveedor (id_proveedor);

--
-- Filtros para la tabla reserva
--
ALTER TABLE reserva
  ADD CONSTRAINT fk_promociones FOREIGN KEY (promociones) REFERENCES promociones (id_promocion),
  ADD CONSTRAINT reserva_ibfk_1 FOREIGN KEY (id_cliente_Cliente) REFERENCES cliente (id_cliente);

--
-- Filtros para la tabla reserva_actividad
--
ALTER TABLE reserva_actividad
  ADD CONSTRAINT reserva_actividad_ibfk_1 FOREIGN KEY (id_cliente_Cliente) REFERENCES cliente (id_cliente);

--
-- Filtros para la tabla reserva_evento
--
ALTER TABLE reserva_evento
  ADD CONSTRAINT reserva_evento_ibfk_1 FOREIGN KEY (id_evento_Evento) REFERENCES evento (id_evento);
COMMIT;

INSERT INTO hotel (id_hotel, nombre, direccion, correo) VALUES
(1, 'Hotel Sol', 'Av. Principal 123, Lima', 'contacto@hotelsol.com'),
(2, 'Hotel Luna', 'Calle Secundaria 456, Arequipa', 'info@hotelluna.com'),
(3, 'Hotel Estrella', 'Jr. Estrellas 789, Cusco', 'reservas@hotelestrella.com');

INSERT INTO proveedor (id_proveedor, nombre, tipo_producto, contacto, correo) VALUES
(1, 'Proveedor A', 'Limpieza', 'Carlos Pérez', 'carlos@proveedora.com'),
(2, 'Proveedor B', 'Alimentos', 'Ana López', 'ana@proveedorb.com'),
(3, 'Proveedor C', 'Electrónica', 'Pedro Gómez', 'pedro@proveedorc.com'),
(4, 'Proveedor D', 'Muebles', 'María Ruiz', 'maria@proveedord.com');

INSERT INTO tipo_habitacion (id_tipo_habitacion, nombre_tipo, descripcion, precio_noche, capacidad) VALUES
(1, 'Simple', 'Habitación para una persona', 80.00, 1),
(2, 'Doble', 'Habitación con dos camas', 120.00, 2),
(3, 'Suite', 'Habitación de lujo con sala', 200.00, 4),
(4, 'Familiar', 'Habitación amplia para familias', 150.00, 5);

INSERT INTO promociones (id_promocion, nombre_promo, descripcion, fecha_inicio, fecha_fin, porcentaje_descuento, area_aplicacion, estado) VALUES
(1, 'Descuento Verano', '20% de descuento en reservas', '2024-01-01', '2024-02-28', 20.00, 'Alojamiento', 'Activo'),
(2, 'Promo Fin de Semana', '10% off en eventos', '2024-03-01', '2024-03-31', 10.00, 'Eventos', 'Activo'),
(3, 'Tarifa Especial', '5% descuento en servicios', '2024-04-01', '2024-04-30', 5.00, 'Servicios', 'Inactivo');

INSERT INTO servicio (id_servicio, nombre, descripcion, precio) VALUES
(1, 'Spa', 'Masaje relajante de 1 hora', 100.00),
(2, 'Gimnasio', 'Acceso ilimitado al gimnasio', 50.00),
(3, 'Transporte', 'Servicio de traslado al aeropuerto', 70.00),
(4, 'Lavandería', 'Lavado y planchado de ropa', 30.00);

INSERT INTO evento (id_evento, nombre, fecha, descripcion, precio) VALUES
(1, 'Concierto de Jazz', '2024-01-15', 'Concierto en vivo', 150.00),
(2, 'Festival Gastronómico', '2024-02-20', 'Comida internacional', 200.00),
(3, 'Fiesta de Año Nuevo', '2024-12-31', 'Celebración con música', 300.00),
(4, 'Torneo de Poker', '2024-03-10', 'Premios en efectivo', 100.00),
(5, 'Obra de Teatro', '2024-04-25', 'Comedia dramática', 50.00),
(6, 'Feria Artesanal', '2024-05-30', 'Venta de artesanías', 30.00);

INSERT INTO empleado (id_empleado, nombre, apellido, correo, puesto, id_hotel_Hotel) VALUES
(1, 'Juan', 'Rodríguez', 'juan@hotel.com', 'Gerente', 1),
(2, 'María', 'López', 'maria@hotel.com', 'Recepcionista', 1),
(3, 'Pedro', 'Martínez', 'pedro@hotel.com', 'Conserje', 2),
(4, 'Carla', 'Sánchez', 'carla@hotel.com', 'Cocinera', 3),
(5, 'Luis', 'Fernández', 'luis@hotel.com', 'Mantenimiento', 2),
(6, 'Andrea', 'García', 'andrea@hotel.com', 'Administradora', 1);

INSERT INTO cliente (id_cliente, nombre, apellido, correo, nacionalidad, contraseña, fecha_nacimiento, DNI) VALUES
(1, 'Carlos', 'Gómez', 'carlos@gmail.com', 'Peruano', 'pass123', '1988-04-12', '12345678'),
(2, 'Ana', 'Martínez', 'ana@gmail.com', 'Chilena', 'ana1234', '1992-06-24', '87654321'),
(3, 'Lucía', 'Ruiz', 'lucia@gmail.com', 'Argentina', 'luciaPass', '1990-11-08', '98765432'),
(4, 'Jorge', 'Pérez', 'jorge@gmail.com', 'Mexicano', 'jorge789', '1985-02-02', '45678912'),
(5, 'Marta', 'Sánchez', 'marta@gmail.com', 'Española', 'marta456', '1995-07-19', '74125896'),
(6, 'Roberto', 'Fernández', 'roberto@gmail.com', 'Peruano', 'roberto123', '1978-09-29', '25896347');
INSERT INTO inventario (id_inventario, nombre_articulo, precio_articulo, fecha_adquisicion, descripcion, cantidad, id_proveedor_Proveedor) VALUES
(1, 'Toallas', 10.50, '2024-01-10', 'Toallas de baño blancas', 50, 1),
(2, 'Sábanas', 20.00, '2024-01-15', 'Juego de sábanas de algodón', 30, 2),
(3, 'Almohadas', 15.00, '2024-01-20', 'Almohadas ergonómicas', 20, 1),
(4, 'Jabón líquido', 5.00, '2024-01-25', 'Jabón para baños', 100, 3),
(5, 'Baterías', 2.50, '2024-01-30', 'Baterías AA para controles', 200, 4);

INSERT INTO hotel_telefono (id_hotel_Hotel, telefonos) VALUES
(1, '+51987654327'),
(2, '+51987654328'),
(3, '+51987654329');

INSERT INTO proveedor_telefono (id_proveedor_Proveedor, telefonos) VALUES
(1, '+51987654330'),
(2, '+51987654331'),
(3, '+51987654332'),
(4, '+51987654333');

INSERT INTO cliente_telefono (id_cliente_Cliente, telefonos) VALUES
(1, '+51987654321'),
(2, '+56912345678'),
(3, '+54987654321'),
(4, '+52987654321'),
(5, '+34987654321'),
(6, '+51912345678');

INSERT INTO empleado_telefono (id_empleado_Empleado, telefonos) VALUES
(1, '+51987654322'),
(2, '+51912345679'),
(3, '+51987654323'),
(4, '+51987654324'),
(5, '+51987654325'),
(6, '+51987654326');

INSERT INTO hotel_promociones (id_hotel_Hotel, id_promocion_Promociones) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 1),
(3, 2);


INSERT INTO hotel_seccion (id_hotel_Hotel, id_evento_Evento) VALUES
(1, 1),
(2, 2),
(2, 3),
(3, 4),
(3, 5);

INSERT INTO cliente_proveedor (id_cliente_Cliente, id_proveedor_Proveedor) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 2),
(6, 4),
(1, 3),
(3, 4);

INSERT INTO reserva (id_reserva, monto_total, metodo_pago, no_personas, fecha_salida, fecha_entrada, fecha_reserva, estado, id_cliente_Cliente, promociones) VALUES
(1, 500.00, 'Tarjeta de crédito', 2, '2024-04-15', '2024-04-10', '2024-04-01', 'Confirmada', 1, 1),
(2, 300.00, 'Efectivo', 4, '2024-05-20', '2024-05-15', '2024-05-05', 'Pendiente', 2, 2),
(3, 250.00, 'PayPal', 3, '2024-06-30', '2024-06-25', '2024-06-15', 'Cancelada', 3, NULL),
(4, 700.00, 'Transferencia', 5, '2024-07-10', '2024-07-05', '2024-07-01', 'Confirmada', 4, 3);

INSERT INTO reserva_actividad (id_reserva_actividad, fecha_reserva, monto_total, id_cliente_Cliente) VALUES
(1, '2024-04-12', 120.00, 1),
(2, '2024-05-18', 80.00, 2),
(3, '2024-06-22', 150.00, 3),
(4, '2024-07-03', 200.00, 4);

INSERT INTO actividad (id_actividad, nombre, descripcion, precio, id_reserva_actividad_Reserva_actividad) VALUES
(1, 'Tour en bicicleta', 'Recorrido guiado por la ciudad', 50.00, 1),
(2, 'Clase de cocina', 'Aprende a cocinar platos locales', 70.00, 2),
(3, 'Senderismo', 'Excursión a la montaña cercana', 30.00, 3),
(4, 'Paseo en bote', 'Tour por el lago', 100.00, 4);

INSERT INTO reserva_evento (id_reserva_evento, fecha_reserva, cantidad_asistente, monto_total, id_evento_Evento) VALUES
(1, '2024-01-05', 50, 5000.00, 1),
(2, '2024-02-10', 30, 3000.00, 2),
(3, '2024-03-15', 20, 2000.00, 3),
(4, '2024-04-20', 100, 10000.00, 4);

INSERT INTO habitacion (id_habitacion, nro_habitacion, estado, id_hotel_Hotel, id_tipo_habitacion_Tipo_habitacion, id_reserva_Reserva) VALUES
(1, 101, 'Disponible', 1, 1, NULL),
(2, 102, 'Ocupada', 1, 2, 1),
(3, 201, 'Disponible', 2, 1, NULL),
(4, 202, 'Mantenimiento', 2, 3, NULL),
(5, 301, 'Ocupada', 3, 2, 2),
(6, 302, 'Disponible', 3, 1, NULL);

INSERT INTO facturacion (id_facturacion, fecha_emision, metodo_pago, monto_total, descripcion, estado, id_reserva_Reserva, id_reserva_evento_Reserva_evento, id_servicio_Servicio, id_reserva_actividad_Reserva_actividad) VALUES
(1, '2024-01-10', 'Tarjeta de crédito', 200.00, 'Pago por reserva de habitación', 'Pagado', 1, NULL, NULL, NULL),
(2, '2024-02-15', 'Efectivo', 150.00, 'Pago por evento', 'Pendiente', NULL, 1, NULL, NULL),
(3, '2024-03-20', 'PayPal', 50.00, 'Pago por servicio de spa', 'Pagado', NULL, NULL, 1, NULL),
(4, '2024-04-05', 'Transferencia', 100.00, 'Pago por actividad', 'Cancelado', NULL, NULL, NULL, 2),
(5, '2024-05-12', 'Tarjeta de débito', 300.00, 'Pago por paquete completo', 'Pagado', 2, 2, 2, 3);


INSERT INTO cliente_reserva_evento (id_cliente_Cliente, id_reserva_evento_Reserva_evento) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

INSERT INTO historial_cambios (id_historial_cambio, fecha_modificacion, campo_modificado, estado, valor_anterior, nuevo_valor, id_empleado_Empleado, id_reserva_Reserva) VALUES
(1, '2024-01-15', 'estado', 'Completado', 'Pendiente', 'Completado', 1, 1),
(2, '2024-02-20', 'precio', 'Ajustado', '200.00', '180.00', 2, 2),
(3, '2024-03-10', 'fecha_reserva', 'Modificado', '2024-04-01', '2024-04-10', 3, 3),
(4, '2024-04-22', 'nombre', 'Corregido', 'Event Pro', 'Event Pro+', 4, NULL),
(5, '2024-05-05', 'no_personas', 'Actualizado', '2', '4', 5, 4);