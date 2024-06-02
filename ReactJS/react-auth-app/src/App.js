import React from 'react';
import './App.css';
import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom';
import Header from './components/Header';
import Footer from './components/Footer';

import Login from './pages/Login';
import SignUp from './pages/SignUp';
import DashBoard from './pages/DashBoard';
import Error from './pages/Error';


const ProtectedRoute = ({ children }) => {
	const token = localStorage.getItem("Token")
	return token == null ? <Navigate to="/login" /> : children
}

const PublicRoute = ({ children }) => {
	const token = localStorage.getItem("Token")
	return token != null ? <Navigate to="/dashboard" /> : children
}
function App() {

	return (
		<div className="App">
			<BrowserRouter>
				<Header />
				<Routes>
					<Route
						path="/"
						element={
							<ProtectedRoute>
								<DashBoard />
							</ProtectedRoute>
						}>
					</Route>

					<Route
						path="/signup"
						element={
							<PublicRoute>
								<SignUp />
							</PublicRoute>
						}>
					</Route>

					<Route
						path='/login'
						element={
							<PublicRoute>
								<Login />
							</PublicRoute>
						}>
					</Route>

					<Route
						path="/dashboard"
						element={
							<ProtectedRoute>
								<DashBoard />
							</ProtectedRoute>
						}>
					</Route>
					<Route path='/*' element={<Error />}></Route>
				</Routes>
			</BrowserRouter>
			<Footer />
		</div>
	);
}

export default App;
