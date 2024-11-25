import React, { useContext } from 'react';
import { UserContext } from '../context/UserContext';

export default function UserBar() {
    const { user } = useContext(UserContext);

    return (
        <div className="user-bar">
            {user ? (
                <>
                    <img src="/images/default-user.png" alt="Foto del Usuario" />
                    <span>{user.nombre}</span>
                </>
            ) : (
                <span>No has iniciado sesión</span>
            )}
        </div>
    );
}
