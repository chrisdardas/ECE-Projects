import axios from 'axios';

// Create an Axios instance
const api = axios.create({
    baseURL: 'http://localhost:5000', // Backend URL
});

// Add a request interceptor to include the Authorization header
api.interceptors.request.use(
    (config) => {
        const token = localStorage.getItem('token');
        console.log('Interceptor - Token:', token); // Log token for debugging

        if (token) {
            config.headers['Authorization'] = `Bearer ${token}`;
            console.log('Interceptor - Authorization header set'); // Log for debugging
        } else {
            console.log('Interceptor - No token found'); // Log for debugging
        }

        return config; // Return the config object to the next step
    },
    (error) => {
        return Promise.reject(error); // Return the error for the next step
    }
);

export default api;