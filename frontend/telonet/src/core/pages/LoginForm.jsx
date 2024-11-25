import React, { useState } from 'react';

export default function LoginForm() {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');

    const handleSubmit = (e) => {
        e.preventDefault();

        // Realizar la solicitud de inicio de sesión al backend
        fetch('http://localhost:3001/api/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ correo: email, contrasena: password })
        })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    response.json().then(data => alert(data.error));
                    throw new Error('Inicio de sesión fallido');
                }
            })
            .then(data => {
                // Guardar el nombre del usuario y el id_cliente en el localStorage
                localStorage.setItem('userName', data.nombre);
                localStorage.setItem('id_cliente', data.id_cliente);
                // Redirigir a la página de bienvenida
                window.location.href = "/inicio";
            })
            .catch(error => {
                console.error('Error al realizar la solicitud:', error);
                alert('No se pudo conectar con el servidor');
            });
    };

    return (
        <form onSubmit={handleSubmit} className="login-form">
            <div className="input-container">
                <span className="icon"><i className="fas fa-user"></i></span>
                <input
                    id="email"
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="Correo Electrónico"
                    required
                />
            </div>
            <div className="input-container">
                <span className="icon"><i className="fas fa-lock"></i></span>
                <input
                    id="password"
                    type="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="Contraseña"
                    required
                />
            </div>
            <button type="submit" id="login-button" className="login-button">
                Iniciar Sesión
            </button>
            <div className="register-link">
                <p>¿No tienes una cuenta? <a href="/registro">Regístrate</a></p>
            </div>
        </form>
    );
}
