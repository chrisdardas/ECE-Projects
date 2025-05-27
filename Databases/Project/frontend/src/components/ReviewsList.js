import React, {useEffect, useState} from "react";
import axios from "axios";

const ReviewsList = () => {
    const [reviews, setReviews] = useState([]);

    useEffect(() => {
        const token = localStorage.getItem('token');
        axios.get('http://localhost:5000/reviews', {
            headers: {
                Authorization: `Bearer ${token}`
            }
        })
            .then((response) => {
                setReviews(response.data);
            })
            .catch((error) => {
                console.error('Error fetching reviews:', error);
            });
    }, []);

    return (
        <div>
            <h1>Reviews</h1>
            <ul>
                {reviews.map(review => (
                    <li key={review.review_id} className="review-item">
                    <span className="game-title">{review.comment}</span>
                    <span className="game-price">{review.rating}</span>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default ReviewsList;