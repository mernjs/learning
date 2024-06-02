import React, { useContext, useEffect } from "react";

import { UserContext } from "../App";

function Component5() {

    const { users, getUsers, getUser, user } = useContext(UserContext)

    useEffect(() => {
        getUsers()
        getUser('64d91f8251472f131ad86fda')
    }, [])

console.log("user", user)

    return (
        <div>
            <h1>Users 5</h1>
            <table border="1">
                <thead>
                    <tr>
                        <th>SN</th>
                        <th>Name</th>
                        <th>EMail</th>
                    </tr>
                </thead>
                <tbody>
                    {users.map((user, index) => {
                        return <tr>
                            <td>{index+1}</td>
                            <td>{user.name}</td>
                            <td>{user.email}</td>
                        </tr>
                    })}
                </tbody>
            </table>
        </div>
    );
}

export default Component5