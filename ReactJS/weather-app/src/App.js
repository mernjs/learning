import React from 'react'
import { Rings } from 'react-loader-spinner'
import { useEffect } from 'react'
import { useState } from 'react'
import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap/dist/js/bootstrap.min.js"

const App = () => {

	const [data, setData] = useState(null)
	const [query, setQuery] = useState("")

	const [lat, setLat] = useState("")
	const [long, setLong] = useState("")

	const [isIsLoading, setIsLoading] = useState(false)

	const getCurrentLoaction = () => {

		navigator.geolocation.getCurrentPosition((position) => {
			// console.log("success",position)
			setLat(position.coords.latitude)
			setLong(position.coords.longitude)
		}, (err) => {
			console.log("err", err)
		});
	}

	useEffect(() => {
		getCurrentLoaction()
	}, [])

	const getData = () => {
		setIsLoading(true)
		fetch(`https://api.openweathermap.org/data/2.5/weather?q=${query}&lat=${lat}&lon=${long}&appid=fe4feefa8543e06d4f3c66d92c61b69c&units=metric`, {
			method: "get"
		}).then((res) => {
			return res.json()
		}).then((resp) => {
			console.log(resp)
			setData(resp)
			setIsLoading(false)
		}).catch((err) => {
			console.log("Error==>", err)
			setIsLoading(false)
		})
	}

	useEffect(() => {
		getData()
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, [lat, long])

	const handleChange = (e) => {
		setQuery(e.target.value)
	}

	const handleSearch = () => {
		getData()
	}

	return (
		<div>

			<section className="vh-100" style={{ "backgroundColor": "#f5f6f7" }}>
				<div className="container py-5 h-100">
					<div className="row d-flex justify-content-center align-items-center h-100">
						<div className="col-md-10 col-lg-8 col-xl-6">
							<h3 className="mb-4 pb-2 fw-normal">Check the weather forecast</h3>
							<div className="input-group rounded mb-3">
								<input type="search" className="form-control rounded" placeholder="City" aria-label="Search"
									aria-describedby="search-addon" onChange={handleChange} />
								<button className='btn btn-secondary input-group-text border-0 fw-bold' id="search-addon" onClick={handleSearch}>Check!</button>
							</div>

							<div className="card bg-dark text-white" style={{ "border-radius": "40px" }}>

								<div className="bg-image" style={{ "border-radius": "35px" }}>
									{
										isIsLoading ?
											<Rings
												height="80"
												width="80"
												color="white"
												radius="6"
												wrapperStyle={{}}
												wrapperClass=""
												visible={true}
												ariaLabel="rings-loading"
											/> : null
									}
									<img src="https://i.imgur.com/dpqZJV5.jpg" height={"400px"}
										className="card-img" alt="weather" />
									<div className="mask" style={{ "background-color": "rgba(190, 216, 232, .5)" }}>
									</div>
								</div>
								<div className="card-img-overlay text-dark p-5">
									<>
										<h4 className="mb-0" style={{ "color": "white" }}>{data?.name}, {data?.sys?.country} </h4>
										<p className="display-2 my-3 " style={{ "color": "white" }}> {data?.main?.temp} °C</p>
										<p style={{ "color": "white" }}>Pressure : <strong> {data?.main?.pressure}</strong> | Humidity :  <strong>  {data?.main?.humidity}</strong></p>
										<p className="mb-2" style={{ "color": "white" }}>Feels Like :  <strong > {data?.main?.feels_like} °C </strong></p>
										<p style={{ "color": "white" }}>Max : <strong> {data?.main?.temp_max} °C</strong>, Min : <strong> {data?.main?.temp_min}°C</strong></p>
										{data?.weather?.map((item) => {
											return (
												<b style={{ "color": "white" }} >{item.main}<span>&nbsp;&nbsp; </span><i className="fas fa-cloud fa-3x" style={{ "color": "#eee" }}></i></b>
											)
										})}
									</>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	)
}

export default App