import React from 'react'
import { Link, NavLink } from 'react-router-dom'

const Header = () => {

	const token = localStorage.getItem('Token')

	return (
		<div>
			<nav class="navbar fixed-top navbar-expand-lg navbar-light bg-light">
				<div class="container">
					<Link class="navbar-brand" to="/">Auth App</Link>
					<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav me-auto mb-5 mb-lg-0">
						</ul>
						<div class="d-flex">
							<ul class="navbar-nav me-auto mb-5 mb-lg-0">
								{!token &&
									<>
										<li class="nav-item">
											<NavLink to="/signup" class="nav-link" >Signup</NavLink> &nbsp;&nbsp;&nbsp;
										</li>
										<li class="nav-item">
											<NavLink to='/login' class="nav-link" >Login</NavLink>
										</li>
									</>
								}
								{token &&
									<li class="nav-item dropdown">
										<NavLink to="/dashboard" class="nav-link dropdown-toggle">
											<img style={{ borderRadius: '100px' }} src="https://bootdey.com/img/Content/avatar/avatar7.png"
												height="30px" width="30px" />
										</NavLink>
									</li>
								}
							</ul>
						</div>
					</div>
				</div>
			</nav>
		</div>
	)
}

export default Header
