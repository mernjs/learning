import React from "react";

const Card = () => {
    return <figure className="movie">
        <div className="movie__hero">
            <img src="https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png" alt="Rambo" className="movie__img" />
        </div>
        <div className="movie__content">
            <div className="movie__title">
                <h1 className="heading__primary">First Blood Part II <i className="fas fa-fire"></i></h1>
            </div>
            <p className="movie__description">
                First Blood is a 1982 American action film directed by Ted Kotcheff, and co-written by Sylvester
                Stallone, who also stars as Vietnam War veteran John Rambo.
            </p>
            <div className="movie__details">
                <p className="movie__detail">Release Date</p>
                <p className="movie__detail">12-Jan-2023</p>
                <p className="movie__detail">12872 Votes</p>
            </div>
        </div>
        <div className="movie__price">Popularity 2796.055</div>
    </figure>
}

export default Card;