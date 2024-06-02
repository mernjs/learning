import React from 'react'
import { TailSpin } from 'react-loader-spinner'
function Loader({ isLoading }) {
    return (
        <>
            {isLoading ?
                <div style={{ paddingLeft: "50%" }}>
                    <TailSpin
                        height="80"
                        width="80"
                        color="#4fa94d"
                        ariaLabel="tail-spin-loading"
                        radius="1"
                        wrapperStyle={{}}
                        wrapperClass=""
                        visible={true}
                    />
                </div> : null
            }
        </>
    )
}

export default Loader;
