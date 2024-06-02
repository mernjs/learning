import React from 'react';
import './App.css';
import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom';
import SignUp from './pages/SignUp';
import Login from './pages/Login';
import DashBoard from './pages/DashBoard';
import Error from './pages/Error';
import Header from './components/Header';
import Footer from './components/Footer';
import ViewProfile from './pages/ViewProfile';
import ResetPassword from './pages/ResetPassword'
import ChangePassword from './pages/ChangePassword';
import UpdateProfile from './pages/UpdateProfile';
import ForgetPassword from './pages/ForgetPassword';
import Home from './pages/Home';

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
					<Route path='/' element={<Home/>} />
					<Route path="/signup" element={
						<PublicRoute>
							<SignUp />
						</PublicRoute>
					}></Route>
					<Route path='/login' element={
						<PublicRoute>
							<Login />
						</PublicRoute>
					}>
					</Route>
					<Route path='/forgetpassword' element={
						<PublicRoute>
							<ForgetPassword />
						</PublicRoute>
					}>
					</Route>
					<Route path='/resetpassword' element={
						<PublicRoute>
							<ResetPassword />
						</PublicRoute>
					}>
					</Route>
					<Route path="/dashboard"
						element={
							<ProtectedRoute>
								<DashBoard />
							</ProtectedRoute>
						}>
					</Route>
					<Route path='/*' element={<Error />}></Route>
					<Route path='/viewprofile' element={
						<ProtectedRoute>
							<ViewProfile />
						</ProtectedRoute>
					}>
					</Route>
					<Route path='/changepassword' element={
						<ProtectedRoute>
							<ChangePassword />
						</ProtectedRoute>
					}>
					</Route>
					<Route path='/updateprofile' element={
						<ProtectedRoute>
							<UpdateProfile />
						</ProtectedRoute>
					}>
					</Route>
					
				</Routes>
			</BrowserRouter>
			<Footer />
		</div>
	);
}

export default App;
