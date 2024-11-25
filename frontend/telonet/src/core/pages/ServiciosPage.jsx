import React, { useState, useEffect } from 'react';
import axios from 'axios';
import '../../styles/ContentStyles.css';

export default function ServiciosPage() {
    const [servicios, setServicios] = useState([]);

    useEffect(() => {
        fetchServicios();
    }, []);

    const fetchServicios = () => {
        axios.get('http://localhost:3001/api/servicios') // Asegúrate de que el backend tiene esta ruta configurada
            .then(response => {
                setServicios(response.data);
            })
            .catch(error => {
                console.error('Error fetching servicios:', error);
            });
    };

    return (
        <div className="main-content">
            <h1>Servicios Disponibles</h1>
            {servicios.length > 0 ? (
                <table className="servicios-table">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>Precio</th>
                        </tr>
                    </thead>
                    <tbody>
                        {servicios.map((servicio) => (
                            <tr key={servicio.id_servicio}>
                                <td>{servicio.nombre}</td>
                                <td>{servicio.descripcion}</td>
                                <td>{servicio.precio}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            ) : (
                <p>No se encontraron servicios disponibles.</p>
            )}
        </div>
    );
}
