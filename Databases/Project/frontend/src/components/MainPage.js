import React, { useContext } from 'react';
import { AuthContext } from '../context/Authcontext'; 
import { Link, useNavigate } from 'react-router-dom';
import './styles/Main.css';

const MainPage = () => {
    const { logout } = useContext(AuthContext); // Get the logout function from the context
    const navigate = useNavigate();

    const handleLogout = () => {
        logout(); // Call the logout function
        navigate('/'); // Redirect to the login page
    };

    return (
        <div className="main-page-container">
            <h1>Gamestorm</h1>
            <nav className="menu">
                <ul>
                    <li className="voltage-button">
                        <Link to="/players" className="menu-link">Players</Link>
                        <svg 
                            version="1.1" 
                            xmlns="http://www.w3.org/2000/svg" 
                            viewBox="0 0 234.6 61.3" 
                            preserveAspectRatio="none" 
                            className="voltage-svg"
                        >
                        </svg>
                        <div className="dots">
                            <div className="dot dot-1"></div>
                            <div className="dot dot-2"></div>
                            <div className="dot dot-3"></div>
                            <div className="dot dot-4"></div>
                            <div className="dot dot-5"></div>
                        </div>
                    </li>
                    <li className="voltage-button">
                        <Link to="/games" className="menu-link">Games</Link>
                        <svg 
                            version="1.1" 
                            xmlns="http://www.w3.org/2000/svg" 
                            viewBox="0 0 234.6 61.3" 
                            preserveAspectRatio="none" 
                            className="voltage-svg"
                        >
                        </svg>
                        <div className="dots">
                            <div className="dot dot-1"></div>
                            <div className="dot dot-2"></div>
                            <div className="dot dot-3"></div>
                            <div className="dot dot-4"></div>
                            <div className="dot dot-5"></div>
                        </div>
                    </li>
                    <li className="voltage-button">
                        <Link to="/wishlist" className="menu-link">WishList</Link>
                        <svg 
                            version="1.1" 
                            xmlns="http://www.w3.org/2000/svg" 
                            viewBox="0 0 234.6 61.3" 
                            preserveAspectRatio="none" 
                            className="voltage-svg"
                        >
                        </svg>
                        <div className="dots">
                            <div className="dot dot-1"></div>
                            <div className="dot dot-2"></div>
                            <div className="dot dot-3"></div>
                            <div className="dot dot-4"></div>
                            <div className="dot dot-5"></div>
                        </div>
                    </li>
                    <li className="voltage-button">
                        <Link to="/achievement" className="menu-link">Achievements</Link>
                        <svg 
                            version="1.1" 
                            xmlns="http://www.w3.org/2000/svg" 
                            viewBox="0 0 234.6 61.3" 
                            preserveAspectRatio="none" 
                            className="voltage-svg"
                        >
                        </svg>
                        <div className="dots">
                            <div className="dot dot-1"></div>
                            <div className="dot dot-2"></div>
                            <div className="dot dot-3"></div>
                            <div className="dot dot-4"></div>
                            <div className="dot dot-5"></div>
                        </div>
                    </li>
                    <li className="voltage-button">
                        <Link to="/dlc" className="menu-link">DLCs</Link>
                        <svg 
                            version="1.1" 
                            xmlns="http://www.w3.org/2000/svg" 
                            viewBox="0 0 234.6 61.3" 
                            preserveAspectRatio="none" 
                            className="voltage-svg"
                        >
                        </svg>
                        <div className="dots">
                            <div className="dot dot-1"></div>
                            <div className="dot dot-2"></div>
                            <div className="dot dot-3"></div>
                            <div className="dot dot-4"></div>
                            <div className="dot dot-5"></div>
                        </div>
                    </li>
                    <li className="voltage-button">
                        <Link to="/reviews" className="menu-link">Reviews</Link>
                        <svg 
                            version="1.1" 
                            xmlns="http://www.w3.org/2000/svg" 
                            viewBox="0 0 234.6 61.3" 
                            preserveAspectRatio="none" 
                            className="voltage-svg"
                        >
                        </svg>
                        <div className="dots">
                            <div className="dot dot-1"></div>
                            <div className="dot dot-2"></div>
                            <div className="dot dot-3"></div>
                            <div className="dot dot-4"></div>
                            <div className="dot dot-5"></div>
                        </div>
                    </li>
                </ul>
            </nav>

            {/* Button Container */}
            <div className="voltage-button-container">
                {/* Enhanced Logout Button with Voltage Styles */}
                <div className="voltage-button">
                    <button onClick={handleLogout} className="logout-button">
                        Logout
                    </button>
                    <svg 
                        version="1.1" 
                        xmlns="http://www.w3.org/2000/svg" 
                        x="0px" 
                        y="0px" 
                        viewBox="0 0 234.6 61.3" 
                        preserveAspectRatio="none" 
                        xmlSpace="preserve"
                        className="voltage-svg"
                    >
                        <filter id="glow">
                            <feGaussianBlur className="blur" result="coloredBlur" stdDeviation="2" />
                            <feTurbulence 
                                type="fractalNoise" 
                                baseFrequency="0.075" 
                                numOctaves="0.3" 
                                result="turbulence" 
                            />
                            <feDisplacementMap 
                                in="SourceGraphic" 
                                in2="turbulence" 
                                scale="30" 
                                xChannelSelector="R" 
                                yChannelSelector="G" 
                                result="displace" 
                            />
                            <feMerge>
                                <feMergeNode in="coloredBlur" />
                                <feMergeNode in="coloredBlur" />
                                <feMergeNode in="coloredBlur" />
                                <feMergeNode in="displace" />
                                <feMergeNode in="SourceGraphic" />
                            </feMerge>
                        </filter>
                        <path 
                            className="voltage line-1" 
                            d="m216.3 51.2c-3.7 0-3.7-1.1-7.3-1.1-3.7 0-3.7 6.8-7.3 6.8-3.7 0-3.7-4.6-7.3-4.6-3.7 0-3.7 3.6-7.3 3.6-3.7 0-3.7-0.9-7.3-0.9-3.7 0-3.7-2.7-7.3-2.7-3.7 0-3.7 7.8-7.3 7.8-3.7 0-3.7-4.9-7.3-4.9-3.7 0-3.7-7.8-7.3-7.8-3.7 0-3.7-1.1-7.3-1.1-3.7 0-3.7 3.1-7.3 3.1-3.7 0-3.7 10.9-7.3 10.9-3.7 0-3.7-12.5-7.3-12.5-3.7 0-3.7 4.6-7.3 4.6-3.7 0-3.7 4.5-7.3 4.5-3.7 0-3.7 3.6-7.3 3.6-3.7 0-3.7-10-7.3-10-3.7 0-3.7-0.4-7.3-0.4-3.7 0-3.7 2.3-7.3 2.3-3.7 0-3.7 7.1-7.3 7.1-3.7 0-3.7-11.2-7.3-11.2-3.7 0-3.7 3.5-7.3 3.5-3.7 0-3.7 3.6-7.3 3.6-3.7 0-3.7-2.9-7.3-2.9-3.7 0-3.7 8.4-7.3 8.4-3.7 0-3.7-14.6-7.3-14.6-3.7 0-3.7 5.8-7.3 5.8-2.2 0-3.8-0.4-5.5-1.5-1.8-1.1-1.8-2.9-2.9-4.8-1-1.8 1.9-2.7 1.9-4.8 0-3.4-2.1-3.4-2.1-6.8s-9.9-3.4-9.9-6.8 8-3.4 8-6.8c0-2.2 2.1-2.4 3.1-4.2 1.1-1.8 0.2-3.9 2-5 1.8-1 3.1-7.9 5.3-7.9 3.7 0 3.7 0.9 7.3 0.9 3.7 0 3.7 6.7 7.3 6.7 3.7 0 3.7-1.8 7.3-1.8 3.7 0 3.7-0.6 7.3-0.6 3.7 0 3.7-7.8 7.3-7.8h7.3c3.7 0 3.7 4.7 7.3 4.7 3.7 0 3.7-1.1 7.3-1.1 3.7 0 3.7 11.6 7.3 11.6 3.7 0 3.7-2.6 7.3-2.6 3.7 0 3.7-12.9 7.3-12.9 3.7 0 3.7 10.9 7.3 10.9 3.7 0 3.7 1.3 7.3 1.3 3.7 0 3.7-8.7 7.3-8.7 3.7 0 3.7-14.6 7.3-14.6 3.7 0 3.7 5.8 7.3 5.8 2.2 0 3.8-0.4 5.5-1.5 1.8-1.1 1.8-2.9 2.9-4.8 1-1.8-1.9-2.7-1.9-4.8 0-3.4 0.4-3.4 0.4-6.8s2.9-3.4 2.9-6.8-0.8-3.4-0.8-6.8c0-2.2 0.3-4.2 1.3-5.9 1.1-1.8 0.8-6.2 2.6-7.3 1.8-1 5.5-2 7.7-2 3 0 3 2 6 2s3-0.5 6-0.5 3 5.1 6 5.1 3-1.1 6-1.1 3-5.6 6-5.6 3 4.8 6 4.8 3 0.6 6 0.6 3-3.8 6-3.8 3 5.1 6 5.1 3-0.6 6-0.6 3-1.2 6-1.2 3-2.6 6-2.6 3-0.6 6-0.6 3 2.9 6 2.9 3-4.1 6-4.1 3 0.1 6 0.1 3 3.7 6 3.7 3 0.1 6 0.1 3-0.6 6-0.6 3 0.7 6 0.7 3-2.2 6-2.2 3 4.4 6 4.4 3-1.7 6-1.7 3-4 6-4 3 4.7 6 4.7 3-0.5 6-0.5 3-0.8 6-0.8 3-3.8 6-3.8 3 6.3 6 6.3 3-4.8 6-4.8 3 1.9 6 1.9 3-1.9 6-1.9 3 1.3 6 1.3c2.2 0 5-0.5 6.7 0.5 1.8 1.1 2.4 4 3.5 5.8 1 1.8 0.3 3.7 0.3 5.9 0 3.4 3.4 3.4 3.4 6.8s-3.3 3.4-3.3 6.8 4 3.4 4 6.8c0 2.2-6 2.7-7 4.4-1.1 1.8 1.1 6.7-0.7 7.7-1.6 0.8-4.7-1.1-6.8-1.1z" 
                            fill="transparent" 
                            stroke="#fff" 
                        />
                        <path 
                            className="voltage line-2" 
                            d="m216.3 52.1c-3 0-3-0.5-6-0.5s-3 3-6 3-3-2-6-2-3 1.6-6 1.6-3-0.4-6-0.4-3-1.2-6-1.2-3 3.4-6 3.4-3-2.2-6-2.2-3-3.4-6-3.4-3-0.5-6-0.5-3 1.4-6 1.4-3 4.8-6 4.8-3-5.5-6-5.5-3 2-6 2-3 2-6 2-3 1.6-6 1.6-3-4.4-6-4.4-3-0.2-6-0.2-3 1-6 1-3 3.1-6 3.1-3-4.9-6-4.9-3 1.5-6 1.5-3 1.6-6 1.6-3-1.3-6-1.3-3 3.7-6 3.7-3-6.4-6-6.4-3 2.5-6 2.5h-6c-3 0-3-0.6-6-0.6s-3-1.4-6-1.4-3 0.9-6 0.9-3 4.3-6 4.3-3-3.5-6-3.5c-2.2 0-3.4-1.3-5.2-2.3-1.8-1.1-3.6-1.5-4.6-3.3s-4.4-3.5-4.4-5.7c0-3.4 0.4-3.4 0.4-6.8s2.9-3.4 2.9-6.8-0.8-3.4-0.8-6.8c0-2.2 0.3-4.2 1.3-5.9 1.1-1.8 0.8-6.2 2.6-7.3 1.8-1 5.5-2 7.7-2 3 0 3 2 6 2s3-0.5 6-0.5 3 5.1 6 5.1 3-1.1 6-1.1 3-5.6 6-5.6 3 4.8 6 4.8 3 0.6 6 0.6 3-3.8 6-3.8 3 5.1 6 5.1 3-0.6 6-0.6 3-1.2 6-1.2 3-2.6 6-2.6 3-0.6 6-0.6 3 2.9 6 2.9 3-4.1 6-4.1 3 0.1 6 0.1 3 3.7 6 3.7 3 0.1 6 0.1 3-0.6 6-0.6 3 0.7 6 0.7 3-2.2 6-2.2 3 4.4 6 4.4 3-1.7 6-1.7 3-4 6-4 3 4.7 6 4.7 3-0.5 6-0.5 3-0.8 6-0.8 3-3.8 6-3.8 3 6.3 6 6.3 3-4.8 6-4.8 3 1.9 6 1.9 3-1.9 6-1.9 3 1.3 6 1.3c2.2 0 5-0.5 6.7 0.5 1.8 1.1 2.4 4 3.5 5.8 1 1.8 0.3 3.7 0.3 5.9 0 3.4 3.4 3.4 3.4 6.8s-3.3 3.4-3.3 6.8 4 3.4 4 6.8c0 2.2-6 2.7-7 4.4-1.1 1.8 1.1 6.7-0.7 7.7-1.6 0.8-4.7-1.1-6.8-1.1z" 
                            fill="transparent" 
                            stroke="#fff" 
                        />
                    </svg>
                    <div className="dots">
                        <div className="dot dot-1"></div>
                        <div className="dot dot-2"></div>
                        <div className="dot dot-3"></div>
                        <div className="dot dot-4"></div>
                        <div className="dot dot-5"></div>
                    </div>
                </div>
            </div>

            {/* Additional Logout Button (if needed) */}
            {/* <button className="logout-button">Logout</button> */}
        </div>
    );

};

export default MainPage;