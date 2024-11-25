import React, { useState, useEffect } from 'react';
import axios from 'axios';
import '../../styles/ContentStyles.css'

export default function EventosPage() {
    const [eventos, setEventos] = useState([]);
    const [error, setError] = useState('');

    useEffect(() => {
        fetchEventos();
    }, []);

    const fetchEventos = () => {
        axios.get('http://localhost:3001/api/eventos')
            .then(response => {
                setEventos(response.data);
            })
            .catch(error => {
                console.error('Error fetching eventos:', error);
                setError('Hubo un error al obtener los eventos.');
            });
    };

    return (
        <div className="main-content">
            <h1>Eventos Disponibles</h1>
            {error && <p style={{ color: 'red' }}>{error}</p>}
            <div className="event-list">
                {eventos.length > 0 ? (
                    eventos.map((evento) => (
                        <div key={evento.id_evento} className="event-card">
                            <img src={evento.link_foto} alt={`Imagen del ${evento.nombre}`} className="event-image" />
                            <div className="event-info">
                                <h2>{evento.nombre}</h2>
                                <p>Fecha: {new Date(evento.fecha).toLocaleDateString()}</p>
                                <p>{evento.descripcion}</p>
                                <p>Precio: ${evento.precio}</p>
                            </div>
                        </div>
                    ))
                ) : (
                    <p>No se encontraron eventos disponibles.</p>
                )}
            </div>
        </div>
    );
}
