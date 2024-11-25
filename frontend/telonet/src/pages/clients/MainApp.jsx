import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

import NavBar from '../../core/pages/NavBar.jsx';
import WelcomePage from '../../core/pages/WelcomePage.jsx';
import PromocionesPage from '../../core/pages/PromocionesPage.jsx';
import HotelesPage from '../../core/pages/HotelesPage.jsx';
import ServiciosPage from '../../core/pages/ServiciosPage.jsx';
import EventosPage from '../../core/pages/EventosPage.jsx'; // Importa el componente para eventos
import ConsultasPage from '../../core/pages/ConsultasPage.jsx'; // Importa el componente de Consultas
import UpdateProfile from '../../core/pages/UpdateProfilePage.jsx'; // Importa el componente de Actualizar Perfil

import ReservaPage from '../../core/pages/ReservasPage.jsx';

export default function MainApp() {
    return (
        <Router>
            <Routes>
                <Route path="/clients/inicio" element={<><NavBar /><WelcomePage /></>} /> {/* Ruta para la página de bienvenida con la barra de navegación */}
                <Route path="/clients/promociones" element={<><NavBar /><PromocionesPage /></>} /> {/* Ruta para la página de promociones con la barra de navegación */}
                <Route path="/clients/hoteles" element={<><NavBar /><HotelesPage /></>} /> {/* Ruta para la página de hoteles con la barra de navegación */}
                <Route path="/clients/servicios" element={<><NavBar /><ServiciosPage /></>} /> {/* Ruta para la página de servicios con la barra de navegación */}
                <Route path="/clients/eventos" element={<><NavBar /><EventosPage /></>} /> {/* Ruta para la página de eventos con la barra de navegación */}
                <Route path="/clients/consultas" element={<><NavBar /><ConsultasPage /></>} /> {/* Ruta para la página de consultas */}
                <Route path="/clients/reserva" element={<><NavBar /><ReservaPage /></>} /> {/* Ruta para la página de reservas */}
                <Route path="/clients/actualizar-perfil" element={<><NavBar /><UpdateProfile /></>} /> {/* Ruta para la página de actualizar perfil */}
            </Routes>
        </Router>
    );
}
