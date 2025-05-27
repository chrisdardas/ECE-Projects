import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './styles/CreateAccount.css';

const CreateAccount = () => {
    const [email, setEmail] = useState('');
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [error, setError] = useState('');
    const navigate = useNavigate();

    const handleCreate = async (event) => {
        event.preventDefault();
        if (password !== confirmPassword) {
            setError('Passwords do not match.');
            return;
        }
        try {
            const response = await axios.post('http://localhost:5000/player', { email, username, password });
            const { token } = response.data;
            console.log('Token:', token);
            console.log('Response:', response.data);
            if(token) {
                localStorage.setItem('token', token);
                alert('Account created successfully!');
                navigate('/');
            } else {
                alert('Account creation failed.');
                navigate('/create-account');
            }
        } catch (error) {
            console.log(error.response.data.message);
            alert(error.response.data.message);
        }
    };

    return (
        <div className="create-account-container">
            <h2>Create Account</h2>
            <form onSubmit={handleCreate} className="create-account-form">
                <div className="form-group">
                    <label htmlFor="email">Email:</label>
                    <input 
                        type="email" 
                        id="email" 
                        value={email} 
                        onChange={(e) => setEmail(e.target.value)} 
                        required 
                    />
                </div>
                <div className="form-group">
                    <label htmlFor="new-username">Username:</label>
                    <input 
                        type="text" 
                        id="new-username" 
                        value={username} 
                        onChange={(e) => setUsername(e.target.value)} 
                        required 
                    />
                </div>
                <div className="form-group">
                    <label htmlFor="new-password">Password:</label>
                    <input 
                        type="password" 
                        id="new-password" 
                        value={password} 
                        onChange={(e) => setPassword(e.target.value)} 
                        required 
                    />
                </div>
                <div className="form-group">
                    <label htmlFor="confirm-password">Confirm Password:</label>
                    <input 
                        type="password" 
                        id="confirm-password" 
                        value={confirmPassword} 
                        onChange={(e) => setConfirmPassword(e.target.value)} 
                        required 
                    />
                </div>
                {error && <p className="error-message">{error}</p>}
                <button type="submit">Create Account</button>
            </form>
        </div>
    );
};

export default CreateAccount;