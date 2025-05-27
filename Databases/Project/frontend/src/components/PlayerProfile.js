import React, { useState, useEffect } from 'react';
import api from './api'; // Import the Axios instance
import { useParams, useNavigate } from 'react-router-dom';
import './styles/PlayerProfile.css';

const PlayerProfile = () => {
    const { player_id } = useParams(); // Get the player_id from the URL
    const navigate = useNavigate();
    const [player, setPlayer] = useState(null);
    const [error, setError] = useState('');

    console.log('Player ID:', player_id);
    console.log('Token:', localStorage.getItem('token')); // Verify the token

    useEffect(() => { // Fetch the player data when the component mounts
        const fetchPlayer = async () => {
            try {
                console.log('Fetching player:', player_id);
                const response = await api.get(`/player/${player_id}`);
                console.log('Player:', response.data);
                setPlayer(response.data); // Set the player state
            } catch (err) {
                console.error('Error fetching player:', err);
                if (err.response && err.response.status === 401) {
                    alert('Unauthorized! Redirecting to login.');
                    navigate('/login'); // Redirect to login if unauthorized
                } else if (err.response && err.response.status === 403) {
                    setError('You are not authorized to view this profile.');
                } else {
                    setError('An error occurred while fetching the profile.');
                }
            }
        };

        const token = localStorage.getItem('token');
        if (token) {
            fetchPlayer(); // Fetch the player data if a token is present
        } else {
            alert('No token found. Please log in.');
            navigate('/login');
        }
    }, [player_id, navigate]);

    if (error) {
        return <div className="error-message">{error}</div>;
    }

    if (!player) {
        return <div>Loading...</div>;
    }

    return (
        <div className="player-profile-container">
            <h1>{player.username}'s Profile</h1>
            <img
                src={player.profile_picture || '/images/default-avatar.png'}
                alt={`${player.username}'s avatar`}
                className="player-avatar"
            />
            <p><strong>Email:</strong> {player.email}</p>
            <p><strong>Total Playtime:</strong> {player.total_playtime} hours</p>
            <p><strong>Achievement Points:</strong> {player.achievement_points}</p>
            <p><strong>Ban Status:</strong> {player.ban_status ? 'Banned' : 'Active'}</p>
            <p><strong>Last Login:</strong> {new Date(player.last_login).toLocaleString()}</p>
        </div>
    );
};

export default PlayerProfile;