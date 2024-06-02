import React, { useState } from 'react'
import { useNavigate, Link } from 'react-router-dom'
import { toast } from 'react-toastify';
import axios from 'axios';
import {
	MDBContainer,
	MDBInput,
	MDBBtn
}
	from 'mdb-react-ui-kit';
const SignUp = () => {
	const [name, setName] = useState("")
	const [email, setEmail] = useState("")
	const [password, setPassword] = useState("")
	const [confirmPassword, setConfirmPasssword] = useState("")
	const [submitting, setSubmitting] = useState(false)
	const [errors,setErrors] = useState(null)

	const navigate = useNavigate()

	const submitData = () => {
		if(!name){
			setErrors({"nameErr" :"Name is Required"})
			return
		}
		if(!email){
			setErrors({eamilErr:"Email is Required"})
			return
		}
		if(!password){
			setErrors({passwordErr:"Password is Required"})
			return
		}
		if(!confirmPassword){
			setErrors({confirmPasswordErr:"Confirm Password is Required"})
			return
		}
		setSubmitting(true)
		setErrors(null)
		axios({
			method: 'post',
			url: 'http://api.mern.co.in/api/v1/signup',
			data: {
				"name": name,
				"email": email,
				"password": password,
				"confirm_password": confirmPassword
			}

		}).then((resp) => {
			setSubmitting(false)
			console.log(resp)
			localStorage.setItem("Token", resp.data.data.accessToken)
			navigate("/dashboard")
		}).catch((err) => {
			setSubmitting(false)
			console.log("Error", err)
			toast.error(err.response.data.message)
		})
	}
	return (
		<div>
			<section className="vh-100" style={{ "background-color": "#eee" }}>
				<div className="container h-100">
					<div className="row d-flex justify-content-center align-items-center h-100">
						<div className="col-lg-12 col-xl-11">
							<div className="card text-black" style={{ "border-radius": "25px" }}>
								<div className="card-body p-md-5">
									<div className="row justify-content-center">
										<div className="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">

											<p className="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Sign Up</p>

											<MDBContainer className="p-3 my-5 d-flex flex-column w-60">

												<MDBInput wrapperClass='mb-4' label='Name' id='form1' type='text' name={name} onChange={(e) => { setName(e.target.value) }} />
												<span style={{color:"red"}}>{errors?.nameErr}</span>
												<MDBInput wrapperClass='mb-4' label='Email address' id='form2' type='email' name={email} onChange={(e) => { setEmail(e.target.value) }} />
												<span style={{color:"red"}}>{errors?.eamilErr}</span>
												<MDBInput wrapperClass='mb-4' label='Password' id='form3' type='password' name={password} onChange={(e) => { setPassword(e.target.value) }} />
												<span style={{color:"red"}}>{errors?.passwordErr}</span>
												<MDBInput wrapperClass='mb-4' label='Confirm Password' id='form4' type='password' name={confirmPassword} onChange={(e) => { setConfirmPasssword(e.target.value) }} />
												<span style={{color:"red"}}>{errors?.confirmPasswordErr}</span>
												<MDBBtn className="mb-4" onClick={submitData} disabled={submitting}>{submitting === true? "Submitting...":"Sign Up"}</MDBBtn>
												<p className="text-center">Already have an account? <Link to="/login">Login</Link></p>
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

export default SignUp
