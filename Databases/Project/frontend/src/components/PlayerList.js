import React, { useState, useEffect } from 'react';
import { FaSearch, FaSort } from 'react-icons/fa';
import { Link } from 'react-router-dom';
import VoltageButton from './Voltage';
import api from './api';
import './styles/PlayerList.css';


const PlayerList = () => {
    // TODO: Find a way to get the token from the login page
    const token = localStorage.getItem('token');
    console.log('Token:', token);
    const [players, setPlayers] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [sortOrder, setSortOrder] = useState('desc'); // 'asc' or 'desc'
    const [darkMode, setDarkMode] = useState(false);
    const [highlightTopPlayers, setHighlightTopPlayers] = useState(false);

    const toggleDarkMode = () => {
        setDarkMode(!darkMode);
        document.body.classList.toggle('dark-mode', !darkMode);
    };

    const toggleHighlight = () => {
        setHighlightTopPlayers(!highlightTopPlayers);
    };

    useEffect(() => {
        const fetchPlayers = async () => {
            try {
                const response = await api.get('/player');
                setPlayers(response.data); // Set the players state
                console.log('Players:', response.data);
            } catch (error) {
                console.error('Error fetching players:', error);
                if (error.response && error.response.status === 401) {
                    // Handle unauthorized access, e.g., redirect to login
                    alert('Unauthorized! Please log in.');
                    // Redirect logic here
                }
            }
        };

        if (token) {
            fetchPlayers(); // Fetch players if token is present
        } else {
            console.log('No token found. Please log in.');
            // Optionally redirect to login
        }
    }, [token]); // Re-run if token changes

    const handleSortChange = (e) => {
        setSortOrder(e.target.value);
    };

    const sortedPlayers = [...players].sort((a, b) => {
        if (sortOrder === 'asc') {
            return a.achievement_points - b.achievement_points;
        } else {
            return b.achievement_points - a.achievement_points;
        }
    });

    const filteredPlayers = sortedPlayers.filter(player =>
        player.username.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
        <div className="player-list-container">
            <VoltageButton 
            label={darkMode ? 'Light Mode' : 'Dark Mode'}
            onClick={toggleDarkMode} 
            className="dark-mode-toggle"
            ariaLabel={darkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode'}
            />
            <h1>Players</h1>
            <div className="controls">
                <FaSearch className="search-icon" />
                <input
                    type="text"
                    placeholder="Search players..."
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    className="search-bar"
                />
                <FaSort className="sort-icon" />
                <select value={sortOrder} onChange={handleSortChange} className="sort-dropdown">
                    <option value="desc">Sort by Points: High to Low</option>
                    <option value="asc">Sort by Points: Low to High</option>
                </select>
                {/* <VoltageButton label="Highlights" onClick={toggleHighlight} className="highlight-button">
                    {highlightTopPlayers ? 'Clear Highlights' : 'Highlight Top Players'}
                </VoltageButton> */}
            </div>
            <ul className="player-list">
                {filteredPlayers.map(player => (
                    <li
                        key={player.player_id}
                        className={`player-item ${highlightTopPlayers && player.achievement_points > 1000 ? 'highlight' : ''}`}
                    >
                        <img
                            src={player.profile_picture || '/images/default-avatar.png'}
                            alt={`${player.username}'s avatar`}
                            className="player-avatar"
                        />
                        <span className="player-name">{player.username}</span>
                        <span className="player-score">{player.achievement_points}</span>
                        <Link to={`http://localhost:5000/player/${player.player_id}`} className="view-profile-button">
                            View Profile
                        </Link>
                    </li>
                ))}
            </ul>
            {filteredPlayers.length === 0 && (
                <p className="error-message">No players found.</p>
            )}
        </div>
    );
};

export default PlayerList;
