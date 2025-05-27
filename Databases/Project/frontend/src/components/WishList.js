import React, { useState, useEffect } from 'react'; // Import the useState and useEffect hooks
import api from './api'; // Import the API module
import "./styles/WishList.css"; // Import the CSS file


const Wishlist = () => {
    const [wishlist, setWishlist] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchWishlist = async () => {
            try {
                const response = await api.get('/wishlist');
                setWishlist(response.data);
            } catch (err) {
                setError('Failed to fetch wishlist.');
                console.error(err);
            } finally {
                setLoading(false);
            }
        };

        fetchWishlist();
    }, []);

    if (loading) {
        return <div>Loading your wishlist...</div>;
    }

    if (error) {
        return <div>{error}</div>;
    }

    return (
        <div className="wishlist-container">
            <h2>Your Wishlist</h2>
            {wishlist.length === 0 ? (
                <p>Your wishlist is empty.</p>
            ) : (
                <ul>
                    {wishlist.map(item => (
                        <li key={item.id}>
                            <h3>{item.item_count}</h3>
                            <p>{item.date_of_addition}</p>
                        </li>
                    ))}
                </ul>
            )}
        </div>
    );
};

export default Wishlist;