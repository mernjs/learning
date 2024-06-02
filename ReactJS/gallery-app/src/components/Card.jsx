import React from "react"
const Card = ({ selectImage, setSelectImage, deleteImage }) => {
	return (
		<div className="row" style={{ marginBottom: "70px" }} >
			{
				selectImage === "" && <b className="text-center mt-5">Image Not Found</b>
			}
			{
				selectImage && selectImage.map((item) => {
					return (
						<div className="col-sm-6 col-lg-4 text-center">
							<img src={item.image} alt="gallery" height="250px" width="300px" className="m-4" />
							<button onClick={() => { deleteImage(item.id) }}>x</button>
						</div>
					)
				}
				)
			}
		</div>
	)
}
export default Card;