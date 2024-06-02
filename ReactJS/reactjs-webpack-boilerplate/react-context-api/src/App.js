import React, { useState, createContext } from "react";
import Component1 from './components/Component1';

export const UserContext = createContext()

function App() {
	
	const [users, setUsers] = useState([]);
	const [user, setUser] = useState([]);

	const getUsers = () => {
		fetch("http://api.mern.co.in/api/v1/user/get-all?page=1", {method: 'GET'})
		.then(response => response.json())
		.then(result => {
			setUsers(result.data.users)
		})
		.catch(error => {
			console.log('error', error)
		});
	}

	const getUser = (id) => {
		fetch(`http://api.mern.co.in/api/v1/user/get/${id}`, {method: 'GET'})
		.then(response => response.json())
		.then(result => {
			setUser(result.data)
		})
		.catch(error => {
			console.log('error', error)
		});
	}

  	return (
		<UserContext.Provider value={{users, getUsers, user, getUser}}>
		 	<Component1/>
		</UserContext.Provider>
    
  );
}

export default App;
