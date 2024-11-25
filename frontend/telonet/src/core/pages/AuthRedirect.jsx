import { useEffect } from "react";

function checkAuthentication() {
    // Verifica si el token de autenticación está almacenado
    const isAuthenticated = localStorage.getItem("authToken") !== null;
    return isAuthenticated;
}

export default function AuthRedirect() {
    useEffect(() => {
        if (checkAuthentication()) {
            window.location.href = "/clients/inicio"; // Si está autenticado, dirige a la aplicación principal
        } else {
            window.location.href = "/clients/login"; // Si no está autenticado, dirige al login
        }
    }, []);

    return null; // Este componente no necesita renderizar nada visual
}
