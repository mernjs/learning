import React from 'react'

function Card({ item }) {
	return (
		<div className='row my-4 bg-white'>
			<div className='col-lg-5 col-md-12'>
				<img src={`https://image.tmdb.org/t/p/original${item.poster_path}`} alt="poster" />
			</div>
			<div className='col-lg-7 col-md-12'>
				<div className='card-body my-5'>
					<b className='title'>{item.original_title}</b>
					<p className='overview'>{item.overview.length > 100 ? item.overview.substr(0, 100) + "..." : item.overview}</p>
					<p clasName="realease-date"> Release Date <span className='ms-4'> {item.release_date} </span> <span className='ms-4'> {item.vote_count} Votes</span></p>
				</div>
			</div>
		</div>
	)
}

export default Card;
