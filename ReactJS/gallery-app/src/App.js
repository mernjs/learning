import React, { useEffect, useState } from "react";
import Header from "./components/Header";
import Card from "./components/Card";
import Footer from "./components/Footer";
import axios from "axios";


function App() {
	const [selectImage, setSelectImage] = useState([])

	const handleChange = (e) => {
		const files = e.target.files[0]
		const fileReader = new FileReader()
		fileReader.readAsDataURL(files)
		fileReader.onload = () => {
			uploadImage({ image: fileReader.result })
		}
	}


	const uploadImage = (data) => {
		axios({
			method: "post",
			url: "http://api.mern.co.in/api/v1/image/gallery",
			data: data
		}).then((response) => {
			getImage()
		}).catch((err) => {
			console.log(err)
		})
	}
	const getImage = () => {
		axios({
			method: "get",
			url: 'http://api.mern.co.in/api/v1/image/gallery?page=1'
		}).then((response) => {
			console.log(response)
			setSelectImage(response.data.data.images)
		}).catch((err) => {
			console.log(err)
		})
	}
	const deleteImage = (id) => {
		axios({
			method: "delete",
			url: 'http://api.mern.co.in/api/v1/image/gallery/' + id
		}).then((response) => {
			console.log(response)
			setSelectImage(response.data.data.images)
			getImage()
		}).catch((err) => {
			console.log(err)
		})
	}

	useEffect(() => {
		getImage()
	}, [])
	return (
		<React.Fragment>
			<Header handleChange={handleChange} />
			<div className="container">
				<Card selectImage={selectImage}
					setSelectImage={setSelectImage}
					deleteImage={deleteImage}
				/>
				<Footer />
			</div>
		</React.Fragment>
	);
}

export default App;
