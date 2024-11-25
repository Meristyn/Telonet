import React, { useState } from 'react';
import axios from 'axios';
import '../../styles/ContentStyles.css';

const RegistroForm = () => {
    const [formData, setFormData] = useState({
        nombre: '',
        apellido: '',
        correo: '',
        nacionalidad: '',
        contrasena: '',
        fecha_nacimiento: '',
        dni: ''
    });

    const [error, setError] = useState('');

    const handleChange = (e) => {
        setFormData({
            ...formData,
            [e.target.name]: e.target.value
        });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const response = await axios.post('http://localhost:4321//api/registro', formData);
            alert(response.data.message); // Mostrar mensaje de éxito
        } catch (err) {
            if (err.response && err.response.status === 400) {
                // Error específico de edad menor a 18 años
                setError(err.response.data.error);
            } else {
                setError('Hubo un error al registrar el usuario. Intente nuevamente.');
            }
        }
    };

    return (
        <div className="main-content">
            <h1 className="welcome-title">Registro de Usuario</h1>
            <form onSubmit={handleSubmit} className="profile-container">
                <input type="text" name="nombre" placeholder="Nombre" value={formData.nombre} onChange={handleChange} required className="profile-field" />
                <input type="text" name="apellido" placeholder="Apellido" value={formData.apellido} onChange={handleChange} required className="profile-field" />
                <input type="email" name="correo" placeholder="Correo" value={formData.correo} onChange={handleChange} required className="profile-field" />
                <input type="text" name="nacionalidad" placeholder="Nacionalidad" value={formData.nacionalidad} onChange={handleChange} required className="profile-field" />
                <input type="password" name="contrasena" placeholder="Contraseña" value={formData.contrasena} onChange={handleChange} required className="profile-field" />
                <input type="date" name="fecha_nacimiento" value={formData.fecha_nacimiento} onChange={handleChange} required className="profile-field" />
                <input type="text" name="dni" placeholder="DNI" value={formData.dni} onChange={handleChange} required className="profile-field" />
                <button type="submit" className="profile-button">Registrar</button>
            </form>
            {error && <p style={{ color: 'red' }}>{error}</p>}
        </div>
    );
};

export default RegistroForm;
