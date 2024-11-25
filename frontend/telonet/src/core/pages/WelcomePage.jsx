import React, { useEffect, useState } from 'react';
import axios from 'axios';
import '../../styles/ContentStyles.css';

export default function WelcomePage() {
    const [profileData, setProfileData] = useState({
        nombre: '',
        apellido: '',
        correo: '',
        nacionalidad: '',
        fecha_nacimiento: '',
        DNI: '',
        telefono: ''
    });

    useEffect(() => {
        // Obtener id_cliente del localStorage
        const id_cliente = localStorage.getItem('id_cliente');

        // Obtener datos del perfil del usuario que inició sesión
        if (id_cliente) {
            axios.get(`http://localhost:3001/api/obtener_perfil?id_cliente=${id_cliente}`)
                .then(response => {
                    setProfileData(response.data);
                })
                .catch(error => {
                    console.error('Error al obtener los datos del perfil:', error);
                });
        }
    }, []);

    return (
        <div className="main-content">
            <h1 className="welcome-title">Bienvenido, {profileData.nombre} {profileData.apellido}</h1>
            <div className="profile-container">
                <p className="profile-field"><span className="profile-field-label">Correo:</span> {profileData.correo}</p>
                <p className="profile-field"><span className="profile-field-label">Nacionalidad:</span> {profileData.nacionalidad}</p>
                <p className="profile-field"><span className="profile-field-label">Fecha de Nacimiento:</span> {new Date(profileData.fecha_nacimiento).toLocaleDateString()}</p>
                <p className="profile-field"><span className="profile-field-label">DNI:</span> {profileData.DNI}</p>
                <p className="profile-field"><span className="profile-field-label">Teléfono:</span> {profileData.telefono}</p>
            </div>
        </div>
    );
}
