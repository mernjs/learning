import React from 'react'

function Header({ handleChange }) {
	return (
		<nav class="navbar navbar-default ps-5 bg-white">
			<div class="container-fluid">
				<div class="navbar-brand">
					<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKYmBDxj9J93VG_IA5qjPCFGvDaFY5RkvfEw&usqp=CAU" alt="" width="" height="30" class="d-inline-block align-text-top" />
					<b> Image Gallery</b>
				</div>
				<ul className='nav navbar-nav navbar-right'>
					<li><label className="label">
						<input type="file" onChange={handleChange}
						/>
						<span>Upload Image</span>
					</label></li>
				</ul>
			</div>
		</nav>
	)
}

export default Header
