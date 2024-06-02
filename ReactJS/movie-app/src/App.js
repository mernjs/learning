import { useEffect, useState } from 'react';
import Loader from './components/Loader';
import Card from './components/Card';
import ReactPaginate from 'react-paginate';
import Footer from './components/Footer';

function App() {

	const [data, setData] = useState([]);
	const [isLoading, setIsLoading] = useState(false);
	const [query, setQuery] = useState("spider")
	const [year, setYear] = useState('')
	const [totalPage, setTotalPage] = useState(null)
	const [curretPage, setCurrentPage] = useState(1)


	const getData = () => {
		setIsLoading(true)
		fetch(`https://api.themoviedb.org/3/search/movie?api_key=d4fbc0cd7f3b6b7ea3c3b8e5c74b8f46&language=en-US&query=${query || "spider"}&year=${year}&page=${curretPage}`)
			.then((result) => result.json()).then((resp) => {
				setData(resp.results) 
				setTotalPage(resp.total_pages)
				setIsLoading(false)
			}).catch((err) => {
				setIsLoading(false)
			})
	}

	useEffect(() => {
		getData()
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, [year, curretPage])

	const handleSearch = () => {
		resetPage()
		getData()
	}

	const onChangeYear = (e) => {
		resetPage()
		setYear(e.target.value)

	}
	const handleChange = (event) => {
		setQuery(event.target.value)
	}

	const handlePageClick = (event) => {
		setCurrentPage(event.selected + 1)
	}

	const resetPage = () => {
		setCurrentPage(1)
	}

	const startYear = 1990;
	const endYear = 2023
	const years = []

	for (let year = startYear; year <= endYear; year++) {
		years.push(year)
	}
	console.log(curretPage)
	return (
		<div className="App">
			<div className='container'>
				<div className='container mt-5'>
					<div className='row'>
						<div className='col-sm-2'></div>
						<div className='col-sm-8'>
							<div className='row'>
								<div className='col-sm-4'>

									<select onChange={onChangeYear} className='form-select form-control '>
										<option>Select Year</option>
										{
											years.map((item, i) => {
												return (
													<option value={item}>{item}</option>
												)
											})
										}
									</select>

								</div>
								<div className='col-sm-8'>
									<div className='input-group'>
										<input type='text' onChange={handleChange} placeholder='Search Movies' defaultValue={query} className='form-control' />
										<button className='btn btn-warning' onClick={handleSearch}>Search</button>
									</div>
								</div>

							</div>
						</div>
						<div className='col-sm-2'></div>
					</div>
				</div>
			</div>
			<div className='container p-5 mb-3'>
				<div className='row'>
					<div className='col-sm-2' ></div>
					<div className='col-sm-8'>

						<Loader isLoading={isLoading} />
						{
							(!isLoading && data.length === 0) &&
							<div className='text-center'>
								<b>No Match Found Data</b>
							</div>
						}
						{
							!isLoading && data.map((item, i) => {
								return (
									<Card key={i} item={item} />
								)
							})
						}
						<ReactPaginate
							breakLabel="..."
							nextLabel="next >"
							onPageChange={handlePageClick}
							pageRangeDisplayed={5}
							pageCount={totalPage}
							previousLabel="< previous"
							renderOnZeroPageCount={null}
							containerClassName={"pagination"}
							previousLinkClassName={"link"}
							nextLinkClassName={"link"}
							disabledClassName={"disabled"}
							activeClassName={"active"}
						/>

					</div>
					<div className='col-sm-2 '></div>

				</div>
			</div>
			<Footer />
		</div>
	);
}

export default App;
