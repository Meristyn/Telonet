import React, { useState, useEffect } from 'react';
import axios from 'axios';
import '../../styles/ContentStyles.css';

export default function ReservaActividadPage() {
    const [reservasActividad, setReservasActividad] = useState([]);
    const [newReservaActividad, setNewReservaActividad] = useState({
        actividad: '',
        fechaReserva: '',
        montoTotal: '',
    });
    const [message, setMessage] = useState('');

    useEffect(() => {
        fetchReservasActividad();
    }, []);

    const fetchReservasActividad = () => {
        const idCliente = localStorage.getItem('id_cliente'); // Obtener el ID del cliente
        axios.get(`http://localhost:4321//api/reservas_actividad?cliente_id=${idCliente}`) // Solicitud para obtener las reservas de actividad
            .then(response => {
                setReservasActividad(response.data);
            })
            .catch(error => {
                console.error('Error fetching reservas de actividad:', error);
            });
    };

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setNewReservaActividad({ ...newReservaActividad, [name]: value });
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        const idCliente = localStorage.getItem('id_cliente');
        const reservaData = { ...newReservaActividad, id_cliente: idCliente };

        axios.post('http://localhost:4321//api/agregar_reserva_actividad', reservaData)
            .then(response => {
                setMessage('Reserva de actividad agregada exitosamente');
                fetchReservasActividad(); // Actualizar la lista de reservas de actividad
            })
            .catch(error => {
                console.error('Error adding reserva de actividad:', error);
                setMessage('Hubo un error al agregar la reserva de actividad');
            });
    };

    return (
        <div className="main-content">
            <h2>Agregar Nueva Reserva de Actividad</h2>
            {message && <p className="message">{message}</p>}
            <form onSubmit={handleSubmit} className="add-reserva-form">
                <label>Actividad:</label>
                <input
                    type="text"
                    name="actividad"
                    value={newReservaActividad.actividad}
                    onChange={handleInputChange}
                    required
                />
                <label>Fecha de Reserva:</label>
                <input
                    type="date"
                    name="fechaReserva"
                    value={newReservaActividad.fechaReserva}
                    onChange={handleInputChange}
                    required
                />
                <label>Monto Total:</label>
                <input
                    type="text"
                    name="montoTotal"
                    value={newReservaActividad.montoTotal}
                    onChange={handleInputChange}
                    required
                />
                <button type="submit">Agregar Reserva de Actividad</button>
            </form>

            <h1>Tus Reservas de Actividades</h1>
            {reservasActividad.length > 0 ? (
                <table className="reservas-table">
                    <thead>
                        <tr>
                            <th>Actividad</th>
                            <th>Fecha Reserva</th>
                            <th>Monto Total</th>
                            <th>DNI Cliente</th>
                        </tr>
                    </thead>
                    <tbody>
                        {reservasActividad.map((reserva) => (
                            <tr key={reserva.id_reserva_actividad}>
                                <td>{reserva.nombre_actividad}</td>
                                <td>{new Date(reserva.fecha_reserva).toLocaleDateString()}</td>
                                <td>{reserva.monto_total}</td>
                                <td>{reserva.dni_cliente}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            ) : (
                <p>No tienes reservas de actividades próximas disponibles.</p>
            )}
        </div>
    );
}
