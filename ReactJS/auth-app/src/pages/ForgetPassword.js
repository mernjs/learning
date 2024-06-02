import React from 'react'
import { Link } from 'react-router-dom'
const ForgetPassword = () => {
  return (
    <div>
      <h1>Forget password</h1>
      <div className="d-flex justify-content-between mx-3 mb-4">
        <Link to='/resetpassword'>Reset password?</Link>
      </div>
    </div>
  )
}

export default ForgetPassword
