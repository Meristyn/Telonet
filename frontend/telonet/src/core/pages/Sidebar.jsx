import React from 'react';
import { Link } from 'react-router-dom';

export default function Sidebar() {
    return (
        <div className="sidebar">
            <nav>
                <ul>
                    <li><Link to="/inicio">Inicio</Link></li>
                    <li><Link to="/clientes">Clientes</Link></li>
                    <li><Link to="/reservas">Reservas</Link></li>
                    <li><Link to="/facturacion">Facturación</Link></li>
                    <li><Link to="/promociones">Promociones</Link></li>
                </ul>
            </nav>
        </div>
    );
}
