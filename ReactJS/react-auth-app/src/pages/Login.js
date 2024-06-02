import React, { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import axios from 'axios'
import { MDBContainer, MDBInput, MDBBtn } from 'mdb-react-ui-kit';

const Login = () => {

	const [email, setEmail] = useState("")
	const [password, setPassword] = useState("")
	const [submitting, setSubmitting] = useState(false)
	const [errors, setErrors] = useState(null)

	const navigate = useNavigate()
	const submitData = () => {
		if (!email) {
			setErrors({ emailErr: "Email is Required" })
			return
		}
		if (!password) {
			setErrors({ passwordErr: "Password is Required" })
			return
		}
		setSubmitting(true)
		setErrors(null)
		axios({
			method: 'post',
			url: 'http://api.mern.co.in/api/v1/login',
			data: {
				"email": email,
				"password": password
			}
		}).then((resp) => {
			setSubmitting(false)
			localStorage.setItem("Token", resp.data.data.accessToken)
			navigate("/dashboard")
		}).catch((err) => {
			setSubmitting(false)
			toast.error(err.response.data.message)
		})
	}
	return (

		<div>
			<section style={{ "background-color": "#eee" }}>
				<div className="container">
					<div className="row d-flex justify-content-center align-items-center" style={{ paddingTop: '100px', paddingBottom: '100px' }}>
						<div className="col-lg-12 col-xl-11">
							<div className="card text-black" style={{ "border-radius": "25px" }}>
								<div className="card-body p-md-5">
									<div className="row justify-content-center">
										<div className="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">

											<p className="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Login</p>
											<MDBContainer className="p-3 my-5 d-flex flex-column w-60">

												<MDBInput wrapperClass='mb-4' label='Email address' id='form1' type='email' name={email} onChange={(e) => { setEmail(e.target.value) }} />
												<span style={{ color: "red" }}>{errors?.email}</span>
												<MDBInput wrapperClass='mb-4' label='Password' id='form2' type='password' name={password} onChange={(e) => { setPassword(e.target.value) }} />
												<span style={{ color: "red" }}>{errors?.password}</span>
												{/* <div className="d-flex justify-content-between mx-3 mb-4">
													<Link to='/forgetpassword'>Forgot password?</Link>
												</div> */}
												<MDBBtn className="mb-4" onClick={submitData} disabled={submitting}>{submitting === true ? "Submitting..." : "Login"}</MDBBtn>
												<p className="text-center"> Don't have an account? <Link to="/signup">Sign Up</Link></p>

											</MDBContainer>

										</div>
										<div className="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
											<img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-registration/draw1.webp"
												className="img-fluid" alt="Sample image" />
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	)
}




export default Login
