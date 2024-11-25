import React, { useState, useEffect } from 'react';
import axios from 'axios';
import '../styles/ClientesPage.css'; // Usando el alias configurado en vite.config.js

export default function ClientesPage() {
    const [clientes, setClientes] = useState([]);
    const [formData, setFormData] = useState({
        nombre: '', apellido: '', correo: '', nacionalidad: '', contrasena: '', fecha_nacimiento: '', dni: ''
    });
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        fetchClientes();
    }, []);

    const fetchClientes = () => {
        setIsLoading(true);
        axios.get('http://localhost:4321//api/clientes')
            .then(response => {
                setClientes(response.data);
                setIsLoading(false);
            })
            .catch(error => {
                console.error('Error fetching clientes:', error);
                setIsLoading(false);
            });
    };

    const handleSubmit = (event) => {
        event.preventDefault();
        axios.post('http://localhost:4321//api/agregar_cliente', formData)
            .then(() => {
                setFormData({
                    nombre: '', apellido: '', correo: '', nacionalidad: '', contrasena: '', fecha_nacimiento: '', dni: ''
                });
                alert('Cliente agregado exitosamente');
                fetchClientes();
            })
            .catch(error => {
                console.error('Error adding cliente:', error);
                alert('Hubo un error al agregar el cliente, por favor intenta nuevamente');
            });
    };

    return (
        <div>
            <form onSubmit={handleSubmit}>
                <input type="text" value={formData.nombre} onChange={(e) => setFormData({ ...formData, nombre: e.target.value })} placeholder="Nombre" required />
                <input type="text" value={formData.apellido} onChange={(e) => setFormData({ ...formData, apellido: e.target.value })} placeholder="Apellido" required />
                <input type="email" value={formData.correo} onChange={(e) => setFormData({ ...formData, correo: e.target.value })} placeholder="Correo" required />
                <input type="text" value={formData.nacionalidad} onChange={(e) => setFormData({ ...formData, nacionalidad: e.target.value })} placeholder="Nacionalidad" required />
                <input type="password" value={formData.contrasena} onChange={(e) => setFormData({ ...formData, contrasena: e.target.value })} placeholder="Contraseña" required />
                <input type="date" value={formData.fecha_nacimiento} onChange={(e) => setFormData({ ...formData, fecha_nacimiento: e.target.value })} required />
                <input type="text" value={formData.dni} onChange={(e) => setFormData({ ...formData, dni: e.target.value })} placeholder="DNI" required />
                <button type="submit">Agregar Cliente</button>
            </form>

            <h3>Lista de Clientes</h3>
            {isLoading ? (
                <p>Cargando clientes...</p>
            ) : (
                <ul>
                    {clientes.length > 0 ? (
                        clientes.map(cliente => (
                            <li key={cliente.id_cliente}>{cliente.nombre} {cliente.apellido}</li>
                        ))
                    ) : (
                        <p>No hay clientes disponibles.</p>
                    )}
                </ul>
            )}
        </div>
    );
}
