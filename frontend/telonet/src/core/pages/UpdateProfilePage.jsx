// UpdateProfile.jsx
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import '../../styles/UpdateProfileStyles.css';

export default function UpdateProfile() {
    const [profileData, setProfileData] = useState({
        id_cliente: '',
        nombre: '',
        apellido: '',
        correo: '',
        contrasena: '',
        nacionalidad: '',
        fecha_nacimiento: '',
        DNI: '',
        telefono: ''
    });
    const [message, setMessage] = useState('');

    useEffect(() => {
        // Obtener id_cliente del localStorage
        const id_cliente = localStorage.getItem('id_cliente');
        if (id_cliente) {
            // Obtener datos del perfil del usuario que inició sesión cuando el componente se monta
            axios.get(`http://localhost:3001/api/obtener_perfil?id_cliente=${id_cliente}`, { withCredentials: true })
                .then(response => {
                    setProfileData({ ...response.data, id_cliente });
                })
                .catch(error => {
                    console.error('Error al obtener los datos del perfil:', error);
                });
        }
    }, []);

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setProfileData({ ...profileData, [name]: value });
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        // Enviar datos actualizados al backend
        axios.put('http://localhost:3001/api/profile', profileData, { withCredentials: true })
            .then(response => {
                setMessage('Perfil actualizado exitosamente');
            })
            .catch(error => {
                console.error('Error al actualizar el perfil:', error);
                setMessage('Hubo un error al actualizar el perfil');
            });
    };

    return (
        <div className="update-profile">
            <h1>Actualizar Perfil</h1>
            {message && <p className="message">{message}</p>}
            <form onSubmit={handleSubmit}>
                <label>Nombre:</label>
                <input
                    type="text"
                    name="nombre"
                    value={profileData.nombre}
                    onChange={handleInputChange}
                />
                <label>Apellido:</label>
                <input
                    type="text"
                    name="apellido"
                    value={profileData.apellido}
                    onChange={handleInputChange}
                />
                <label>Correo:</label>
                <input
                    type="email"
                    name="correo"
                    value={profileData.correo}
                    onChange={handleInputChange}
                />
                <label>Nacionalidad:</label>
                <input
                    type="text"
                    name="nacionalidad"
                    value={profileData.nacionalidad}
                    onChange={handleInputChange}
                />
                <label>Fecha de Nacimiento:</label>
                <input
                    type="date"
                    name="fecha_nacimiento"
                    value={profileData.fecha_nacimiento}
                    onChange={handleInputChange}
                />
                <label>DNI:</label>
                <input
                    type="text"
                    name="DNI"
                    value={profileData.DNI}
                    onChange={handleInputChange}
                />
                <label>Teléfono:</label>
                <input
                    type="text"
                    name="telefono"
                    value={profileData.telefono}
                    onChange={handleInputChange}
                />
                <label>Contraseña:</label>
                <input
                    type="password"
                    name="contrasena"
                    value={profileData.contrasena}
                    onChange={handleInputChange}
                />
                <button type="submit">Actualizar</button>
            </form>
        </div>
    );
}
