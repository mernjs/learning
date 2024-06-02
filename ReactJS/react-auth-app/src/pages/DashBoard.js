import React, { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import 'mdb-react-ui-kit/dist/css/mdb.min.css';
import axios from 'axios';

const DashBoard = () => {

	const token = localStorage.getItem('Token')
	const [profileDetails, setProfileDetails] = useState(null)
	const navigate = useNavigate()

	const getProfileDetails = () => {
		axios({
			method: 'GET',
			url: 'http://api.mern.co.in/api/v1/get-profile-details',
			headers: { Authorization: token }
		}).then((resp) => {
			setProfileDetails(resp.data.data)
		}).catch((err) => {
			console.log("Error", err)
		})
	}

	useEffect(() => {
		getProfileDetails()
	}, [])

	const logout = () => {
		localStorage.removeItem("Token")
		navigate("/login")
	}

	return (
		<section style={{ "background-color": "#eee", paddingBottom: '20%' }}>
			<div className="container" style={{ paddingTop: '100px' }}>
				<div className="main-body">
					<div className="row gutters-sm">
						<div className="col-md-4 mb-3">
							<div className="card">
								<div className="card-body">
									<div className="d-flex flex-column align-items-center text-center">
										<img src={profileDetails?.profilePic || "https://bootdey.com/img/Content/avatar/avatar7.png"} alt="Admin" className="rounded-circle" width={150} />
										<div className="mt-3">
											<h4 className='mb-3'>{profileDetails?.name}</h4>
											<button className='btn btn-primary' onClick={logout}>Logout</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div className="col-md-8">
							<div className="card mb-3">
								<div className="card-body">
									<div className="row">
										<div className="col-sm-3">
											<h6 className="mb-0">Full Name</h6>
										</div>
										<div className="col-sm-9 text-secondary">
											{profileDetails?.name}
										</div>
									</div>
									<hr />
									<div className="row">
										<div className="col-sm-3">
											<h6 className="mb-0">Email</h6>
										</div>
										<div className="col-sm-9 text-secondary">
											{profileDetails?.email}
										</div>
									</div>
									<hr />
									<div className="row">
										<div className="col-sm-3">
											<h6 className="mb-0">Designation</h6>
										</div>
										<div className="col-sm-9 text-secondary">
											N/A
										</div>
									</div>
									<hr />
									<div className="row">
										<div className="col-sm-3">
											<h6 className="mb-0">Phone</h6>
										</div>
										<div className="col-sm-9 text-secondary">
											N/A
										</div>
									</div>
									<hr />
									<div className="row">
										<div className="col-sm-3">
											<h6 className="mb-0">Address</h6>
										</div>
										<div className="col-sm-9 text-secondary">
											N/A
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	)
}

export default DashBoard;
