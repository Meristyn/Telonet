import React, { useState } from 'react';
import axios from 'axios';
import '../../styles/ConsultasStyles.css';
import NavBar from './NavBar.jsx';

export default function ConsultasPage() {
    const [searchParams, setSearchParams] = useState([{ field: '', value: '' }]);
    const [table, setTable] = useState('cliente'); // Estado para seleccionar la tabla a buscar
    const [results, setResults] = useState([]);
    const [message, setMessage] = useState('');

    const handleInputChange = (index, field, value) => {
        const newSearchParams = [...searchParams];
        newSearchParams[index] = { ...newSearchParams[index], [field]: value };
        setSearchParams(newSearchParams);
    };

    const addSearchField = () => {
        setSearchParams([...searchParams, { field: '', value: '' }]);
    };

    const handleTableChange = (e) => {
        setTable(e.target.value);
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        const validParams = searchParams.filter(param => param.field.trim() !== '' && param.value.trim() !== '');
        if (validParams.length === 0) {
            setMessage('Por favor, ingrese al menos un campo y valor para buscar.');
            return;
        }

        // Realizar la búsqueda al backend
        axios.get('http://localhost:4321//api/consultas', {
            params: { table, searchParams: JSON.stringify(validParams) }
        })
            .then(response => {
                if (response.data.length > 0) {
                    setResults(response.data);
                    setMessage('');
                } else {
                    setResults([]);
                    setMessage('No se encontraron resultados para la búsqueda.');
                }
            })
            .catch(error => {
                console.error('Error al realizar la búsqueda:', error);
                setMessage('Hubo un error al realizar la búsqueda.');
            });
    };

    return (
        <div className="consultas-page">
            <NavBar /> {/* Asegúrate de que NavBar se está utilizando aquí */}
            <h1>Consultas Personalizadas</h1>
            <form onSubmit={handleSubmit} className="consultas-form">
                <label htmlFor="table">Seleccione la tabla:</label>
                <select id="table" value={table} onChange={handleTableChange}>
                    <option value="cliente">Clientes</option>
                    <option value="reserva">Reservas</option>
                    <option value="servicio">Servicios</option>
                    <option value="promocion">Promociones</option>
                </select>
                {searchParams.map((param, index) => (
                    <div key={index} className="query-field">
                        <input
                            type="text"
                            value={param.field}
                            onChange={(e) => handleInputChange(index, 'field', e.target.value)}
                            placeholder={`Campo a buscar ${index + 1}...`}
                        />
                        <input
                            type="text"
                            value={param.value}
                            onChange={(e) => handleInputChange(index, 'value', e.target.value)}
                            placeholder={`Valor a buscar ${index + 1}...`}
                        />
                    </div>
                ))}
                <button type="button" onClick={addSearchField}>Agregar otra búsqueda</button>
                <button type="submit">Buscar</button>
            </form>
            {message && <p className="message">{message}</p>}
            {results.length > 0 && (
                <table className="results-table">
                    <thead>
                        <tr>
                            {Object.keys(results[0]).map((key) => (
                                <th key={key}>{key}</th>
                            ))}
                        </tr>
                    </thead>
                    <tbody>
                        {results.map((result, index) => (
                            <tr key={index}>
                                {Object.values(result).map((value, i) => (
                                    <td key={i}>{value}</td>
                                ))}
                            </tr>
                        ))}
                    </tbody>
                </table>
            )}
        </div>
    );
}
