import React, { useState, useEffect } from 'react';
import api from './api';
import './styles/DLC.css';

const DLC = () => {
    const [dlc, setDlc] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchDLC = async () => {
            try {
                const response = await api.get('/dlc');
                setDlc(response.data);
            } catch (err) {
                setError('Failed to fetch DLCs.');
                console.error(err);
            } finally {
                setLoading(false);
            }
        };

        fetchDLC();
    }, []);

    if (loading) {
        return <div>Loading the DLCs...</div>;
    }

    if (error) {
        return <div>{error}</div>;
    }

    return (
        <div className="game-list-container">
            <h1>DLCs</h1>
            <ul className="game-list">
                {dlc.map(dlc => (
                    <li key={dlc.game_id} className="dlc-item">
                        <span className="dlc-title">{dlc.title}</span>
                        {/* <span className="game-price">${game.price}</span> */}
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default DLC;