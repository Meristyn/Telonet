// Toma en cuenta este componente para hacerlo y adaptarlo a los demás.

import React, { useState, useEffect } from 'react';
import axios from 'axios';
import '../../styles/ContentStyles.css';

export default function PromocionesPage() {
    const [promociones, setPromociones] = useState([]);
    const [loading, setLoading] = useState(false); // Para mostrar el estado de carga
    const [error, setError] = useState(null); // Manejo de errores

    useEffect(() => {
        fetchPromociones();
    }, []);

    const fetchPromociones = async () => {
        setLoading(true);
        setError(null);
        try {
            const procedureData = {
                procedure_name: 'get_promociones', // Nombre del procedimiento
                params: [] // Parámetros (vacío si no se necesitan)
            };

            const response = await axios.post('http://localhost:8000/api/procedures', procedureData);
            setPromociones(response.data.results);
        } catch (err) {
            console.error('Error fetching promociones:', err);
            setError('Error al obtener las promociones.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="main-content">
            <h1>Promociones Disponibles</h1>
            {loading && <p>Cargando promociones...</p>}
            {error && <p className="error-message">{error}</p>}
            {!loading && !error && promociones.length > 0 ? (
                <table className="promociones-table">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>Fecha Inicio</th>
                            <th>Fecha Fin</th>
                            <th>Porcentaje Descuento</th>
                            <th>Área Aplicación</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        {promociones.map((promo) => (
                            <tr key={promo.id_promocion}>
                                <td>{promo.nombre_promo}</td>
                                <td>{promo.descripcion}</td>
                                <td>{promo.fecha_inicio}</td>
                                <td>{promo.fecha_fin}</td>
                                <td>{promo.porcentaje_descuento}%</td>
                                <td>{promo.area_aplicacion}</td>
                                <td>{promo.estado}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            ) : (
                !loading && <p>No se encontraron promociones disponibles.</p>
            )}
        </div>
    );
}
