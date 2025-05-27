import React , { useContext } from 'react';
import { Navigate } from 'react-router-dom';
import { AuthContext } from '../context/Authcontext';

const ProtectedRoute = ({children}) => {
    const { isAuthenticated } = useContext(AuthContext); // Get the authentication status from the context
    if(!isAuthenticated){
        return <Navigate to="/" replace />; // If the user is not authenticated, redirect to the login page
    }

    return children; // If the user is authenticated, render the protected route
}

export default ProtectedRoute;