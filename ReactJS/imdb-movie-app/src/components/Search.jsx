import React from "react";

const Search = () => {
    return <div className="container">
        <form role="search" method="get" className="search-form form" action="">
            <label>
                <span className="screen-reader-text">Search for...</span>
                <input type="search" className="search-field" placeholder="Type something..." value="" name="s" title="" />
            </label>
            <input type="submit" className="search-submit button" value="Search" />
        </form>
    </div>
}

export default Search;