import React from 'react';
import './App.css';
import Login from './components/Login'; // Import the Login component
import CreateAccount from './components/CreateAccount'; // Import the CreateAccount component
import PlayerList from './components/PlayerList'; // Import the PlayerList component
import PlayerProfile from './components/PlayerProfile'; // Import the PlayerProfile component
import GameList from './components/GameList'; // Import the GameList component
import WishList from './components/WishList'; // Import the WishList component
import Achievements from './components/Achievements'; // Import the Achievements component
import DLC from './components/DLC';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'; // Import React Router components
import ReviewsList from './components/ReviewsList'; // Import the ReviewsList component
import { AuthProvider } from './context/Authcontext'; // Import the AuthProvider component
import ProtectedRoute from './components/Protected'; // Import the ProtectedRoute component
import MainPage from './components/MainPage'; // Import the MainPage component
// import ReactDOM from 'react-dom/client';

const App = () => {
    return (
        <AuthProvider>
            <Router>
                <Routes>
                    <Route path="/" element={<Login />} />
                    <Route 
                        path="/players" 
                        element={
                            <ProtectedRoute>
                                <PlayerList />
                            </ProtectedRoute>
                        } 
                    />
                    <Route
                        path="/player/:player_id"
                        element={
                            <ProtectedRoute>
                                <PlayerProfile />
                            </ProtectedRoute>
                        }
                    />
                    <Route 
                        path="/games" 
                        element={
                            <ProtectedRoute>
                                <GameList />
                            </ProtectedRoute>
                        } 
                    />
                    <Route 
                        path="/reviews" 
                        element={
                            <ProtectedRoute>
                                <ReviewsList />
                            </ProtectedRoute>
                        } 
                    />
                    <Route 
                        path="/create-account" 
                        element={<CreateAccount />} 
                    />
                    <Route 
                        path="/main" 
                        element={
                            <ProtectedRoute>
                                <MainPage />
                            </ProtectedRoute>
                        } 
                    />
                    <Route 
                        path = "/wishlist"
                        element={
                            <ProtectedRoute>
                                <WishList />
                            </ProtectedRoute>
                        }
                    />
                    <Route 
                        path = "/achievement"
                        element={
                            <ProtectedRoute>
                                <Achievements />
                            </ProtectedRoute>
                        }
                    />
                    <Route 
                        path = "/dlc"
                        element={
                            <ProtectedRoute>
                                <DLC />
                            </ProtectedRoute>
                        }
                    />
                    <Route path="*" element={<h1>404: Not Found</h1>} />
                </Routes>
            </Router>
        </AuthProvider>
    );
};

export default App;
