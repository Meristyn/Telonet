import React from 'react';
import { Link } from 'react-router-dom';
import '../../styles/NavBar.css';

export default function NavBar() {
    return (
        <nav className="sidebar">
            <ul className="sidebar-menu">
                <li><Link to="/clients/inicio">Inicio</Link></li>
                <li><Link to="/clients/promociones">Promociones</Link></li>
                <li><Link to="/clients/hoteles">Hoteles</Link></li>
                <li><Link to="/clients/servicios">Servicios</Link></li>
                <li><Link to="/clients/eventos">Eventos</Link></li>
                <li><Link to="/clients/consultas">Consultas</Link></li> {/* Agregada la ruta para consultas */}
                <li><Link to="/clients/reserva">Reservas</Link></li> {/* Agregar la opción para reservas */}
                <li><Link to="/clients/actualizar-perfil">Actualizar Perfil</Link></li> {/* Agregar una opción para actualizar perfil */}
            </ul>
            <a className='bg-slate-950 p-4 rounded-lg font-bold hover:scale-110 transition-all' href='/dashboard/clientes'>Ir al dashboard</a>
        </nav>
    );
}
