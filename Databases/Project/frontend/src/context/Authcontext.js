import React, { createContext, useState } from 'react';

export const AuthContext = createContext(); // Create the authentication context

export const AuthProvider = ({children}) => {
    const [isAuthenticated, setIsAuthenticated] = useState(false); // Set the initial state of the authentication status
    const [user, setUser] = useState(null); // Set the initial state of the user data to null

    // function to handle login
    const login = (userData) => {
        setIsAuthenticated(true);
        setUser(userData);
    }; // once logged in, set the authentication status to true and set the user data

    const logout = () => {
        setIsAuthenticated(false);
        setUser(null);
        localStorage.removeItem('token');
    };

    return (
        <AuthContext.Provider value = {{isAuthenticated, user, login, logout}}>
            {children}
        </ AuthContext.Provider> // Pass the authentication status, user data, login, and logout functions to the provider
    )
}