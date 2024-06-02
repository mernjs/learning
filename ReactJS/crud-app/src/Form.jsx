import React, { useState } from 'react'
import { BiUserCircle, BiLockAlt } from "react-icons/bi";
import { HiOutlineMail } from "react-icons/hi";

function Form({onSubmit,onClose}) {
    const [formData, setFormData] = useState('')

    const handleChange = (e) => {
        setFormData({ ...formData,[e.target.name]: e.target.value })
    }

    const handleSubmit =() =>{
        // console.log(formData)
        onSubmit(formData)
    }

    return (
        <div className='conatainer'>
            <div className='row'>
                <div className='col-sm-12'>
                    <h4 className='text-center mb-4'>Add User <b className='float-end me-2'onClick={onClose} >X</b></h4>
                    <div className='input-group'>
                        <span className='input-group-text text-primary fs-5'><BiUserCircle /></span><input type='text' placeholder='Enter Name' name="name" className='form-control' onChange={handleChange} value={formData?.name || ""} />
                    </div><br />
                    <div className='input-group'>
                        <span className='input-group-text text-primary fs-5'><HiOutlineMail /></span><input type='email' placeholder='Enter Email' name="email" className='form-control' value={formData?.email|| ""} onChange={handleChange} />
                    </div><br />
                    <div className='input-group'>
                        <span className='input-group-text text-primary fs-5'><BiLockAlt /></span><input type='password' placeholder='Enter Password' name='password' className='form-control' value={formData?.password || ""} onChange={handleChange} />
                    </div><br />
                    <div className='input-group'>
                        <span className='input-group-text text-primary fs-5'><BiLockAlt /></span><input type='password' placeholder='Confirm Password' name="confirm_password" className='form-control' value={formData?.confirm_password || ""} onChange={handleChange} />
                    </div><br />
                    <input type='button' className='btn btn-primary float-end' value="Submit" onClick={handleSubmit} />
                </div>
            </div>
        </div>
    )
}

export default Form
