import React, { useState, useEffect } from 'react';
import axios from 'axios';
import '../../styles/ContentStyles.css'

export default function ReservaPage() {
    const [reservas, setReservas] = useState([]);
    const [newReserva, setNewReserva] = useState({
        hotel: '',
        tipoHabitacion: '',
        fechaEntrada: '',
        fechaSalida: '',
        noPersonas: 1,
        promocion: null
    });
    const [message, setMessage] = useState('');

    useEffect(() => {
        fetchReservas();
    }, []);

    const fetchReservas = () => {
        const idCliente = localStorage.getItem('id_cliente'); // Obtener el ID del cliente
        axios.get(`http://localhost:3001/api/reservas?cliente_id=${idCliente}`) // Solicitud para obtener las reservas
            .then(response => {
                setReservas(response.data);
            })
            .catch(error => {
                console.error('Error fetching reservas:', error);
            });
    };

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setNewReserva({ ...newReserva, [name]: value });
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        const idCliente = localStorage.getItem('id_cliente');
        const reservaData = { ...newReserva, id_cliente: idCliente };

        axios.post('http://localhost:3001/api/agregar_reserva', reservaData)
            .then(response => {
                setMessage('Reserva agregada exitosamente');
                fetchReservas(); // Actualizar la lista de reservas
            })
            .catch(error => {
                console.error('Error adding reserva:', error);
                setMessage('Hubo un error al agregar la reserva');
            });
    };

    return (
        <div className="main-content">
            <h2>Agregar Nueva Reserva</h2>
            {message && <p className="message">{message}</p>}
            <form onSubmit={handleSubmit} className="add-reserva-form">
                <label>Hotel:</label>
                <input
                    type="text"
                    name="hotel"
                    value={newReserva.hotel}
                    onChange={handleInputChange}
                    required
                />
                <label>Tipo de Habitación:</label>
                <input
                    type="text"
                    name="tipoHabitacion"
                    value={newReserva.tipoHabitacion}
                    onChange={handleInputChange}
                    required
                />
                <label>Fecha de Entrada:</label>
                <input
                    type="date"
                    name="fechaEntrada"
                    value={newReserva.fechaEntrada}
                    onChange={handleInputChange}
                    required
                />
                <label>Fecha de Salida:</label>
                <input
                    type="date"
                    name="fechaSalida"
                    value={newReserva.fechaSalida}
                    onChange={handleInputChange}
                    required
                />
                <label>Número de Personas:</label>
                <input
                    type="number"
                    name="noPersonas"
                    value={newReserva.noPersonas}
                    onChange={handleInputChange}
                    min="1"
                    required
                />
                <label>Promoción (opcional):</label>
                <input
                    type="text"
                    name="promocion"
                    value={newReserva.promocion}
                    onChange={handleInputChange}
                />
                <button type="submit">Agregar Reserva</button>
            </form>

            <h1>Tus Reservas</h1>
            {reservas.length > 0 ? (
                <table className="reservas-table">
                    <thead>
                        <tr>
                            <th>Hotel</th>
                            <th>Tipo de Habitación</th>
                            <th>Promoción</th>
                            <th>Monto Total</th>
                            <th>Fecha Entrada</th>
                            <th>Fecha Salida</th>
                            <th>Número de Personas</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        {reservas.map((reserva) => (
                            <tr key={reserva.id_reserva}>
                                <td>{reserva.hotel}</td>
                                <td>{reserva.tipo_habitacion}</td>
                                <td>{reserva.promocion ? `${reserva.promocion} (${reserva.porcentaje_descuento}%)` : 'No aplica'}</td>
                                <td>{reserva.monto_total}</td>
                                <td>{new Date(reserva.fecha_entrada).toLocaleDateString()}</td>
                                <td>{new Date(reserva.fecha_salida).toLocaleDateString()}</td>
                                <td>{reserva.no_personas}</td>
                                <td>{reserva.estado}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            ) : (
                <p>No tienes reservas próximas disponibles.</p>
            )}
        </div>
    );
}
