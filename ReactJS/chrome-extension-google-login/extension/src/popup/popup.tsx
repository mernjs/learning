import React, { useState, useEffect } from 'react'
import axios from 'axios'
import './popup.css'

const Popup = () => {

    const [user, setUser] = useState({})

    useEffect(() => {
        axios.get('http://localhost:3000/auth/me').then(response => setUser(response.data))
    }, [])

    const handleLogin = () => {
        chrome.tabs.create({ url: 'http://localhost:3000/auth/google', selected: true, active: true })
    }

    const handleLogout = () => {
        axios.get('http://localhost:3000/auth/logout').then(response => window.location.reload())
    }

    return (
        <div className="h-screen" >
            <div style={{padding: '20px'}}>
                {user ?
                    <>
                        <p>{user?.name}</p>
                        <p>{user?.email}</p>
                        <button onClick={handleLogout} className="py-4 px-3 bg-red-500 text-white m-2">
                            Logout
                        </button> 
                    </>:
                    <button onClick={handleLogin} className="py-4 px-3 bg-red-500 text-white m-2">
                        Login with Google
                    </button>}
            </div>
        </div >

    )
};

export default Popup;