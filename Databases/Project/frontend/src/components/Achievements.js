import React, { useState, useEffect } from 'react'; // Import the useState and useEffect hooks
import api from './api'; // Import the API module
import "./styles/Achievements.css"; // Import the CSS file


const Achievement = () => {
    const [achievement, setAchievement] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchAchievements = async () => {
            try {
                const response = await api.get('/achievement');
                setAchievement(response.data);
            } catch (err) {
                setError('Failed to fetch achievements.');
                console.error(err);
            } finally {
                setLoading(false);
            }
        };

        fetchAchievements();
    }, []);

    if (loading) {
        return <div>Loading your achievements...</div>;
    }

    if (error) {
        return <div>{error}</div>;
    }

    return (
        <div className="achievement-container">
            <h2>Your Achievements</h2>
            {achievement.length === 0 ? (
                <p>You do not have any achievements.</p>
            ) : (
                <ul>
                    {achievement.map(item => (
                        <li key={item.id}>
                            <h3>{item.title}</h3>
                        </li>
                    ))}
                </ul>
            )}
        </div>
    );
};

export default Achievement;