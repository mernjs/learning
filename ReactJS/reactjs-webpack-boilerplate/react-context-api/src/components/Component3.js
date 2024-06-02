import React, {useEffect, useContext} from "react";
import Component4 from "./Component4";
import { UserContext } from "../App";

function Component3() {

	const { users, getUsers } = useContext(UserContext)

    useEffect(() => {
        getUsers()
    }, [])

	return (
		<div>
			<Component4 />
			{users.map((user, i) => {
				return <div style={{border: '1px solid red', width: '200px', margin: '20px'}}>
					<h4>{user.name}</h4>
					<p>{user.email}</p>
				</div>
			})}
			
		</div>
	);
}

export default Component3