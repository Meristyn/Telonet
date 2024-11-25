import React, { useState, useEffect } from 'react';
import axios from 'axios';
import '../../styles/ContentStyles.css';
export default function HotelesPage() {
    const [hoteles, setHoteles] = useState([]);
    const [error, setError] = useState('');

    useEffect(() => {
        fetchHoteles();
    }, []);

    const fetchHoteles = () => {
        axios.get('http://localhost:4321//api/hoteles')
            .then(response => {
                setHoteles(response.data);
            })
            .catch(error => {
                console.error('Error fetching hoteles:', error);
                setError('Hubo un error al obtener los hoteles.');
            });
    };

    return (
        <div className="main-content">
            <h1>Hoteles Disponibles</h1>
            {error && <p style={{ color: 'red' }}>{error}</p>}
            <div className="hotel-list">
                {hoteles.length > 0 ? (
                    hoteles.map((hotel) => (
                        <div key={hotel.id_hotel} className="hotel-card">
                            <img
                                src={hotel.imagen_url}
                                alt={`Imagen del hotel ${hotel.nombre}`}
                                className="hotel-image"
                            />
                            <h2>{hotel.nombre}</h2>
                            <p>{hotel.direccion}</p>
                            <p>Correo: {hotel.correo}</p>
                        </div>
                    ))
                ) : (
                    <p>No se encontraron hoteles disponibles.</p>
                )}
            </div>
        </div>
    );
}
