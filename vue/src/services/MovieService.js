import axios from 'axios';

export default {


    getMoviePage(moviePerPage, page, sortBy) {
        return axios.get(`/movies/${moviePerPage}/${page}/${sortBy}`);
    },
    getMoviePageOrdered(moviePerPage, page, sortBy, asc) {
        return axios.get(`/movies/${moviePerPage}/${page}/${sortBy}?asc=${asc}`);
    },
    getUserFavMovie(moviePerPage, page, sortBy) {
        return axios.get(`/movies/favorites/${moviePerPage}/${page}/${sortBy}`);
    },
    addFav(movieId) {
        return axios.post(`/favorites/${movieId}`);
    },
    isFav(movieId) {
        return axios.get(`/favorites/${movieId}`);
    },
    deleteFav(movieId) {
        return axios.delete(`/favorites/${movieId}`);
    },
    getFilterMovies(moviePerPage, page, sortBy, genres, mpaas, years) {
        console.log(mpaas)

        return axios.post(`/movies/filter/${moviePerPage}/${page}/${sortBy}`, {
            genres: genres,
            mpaas: mpaas,
            years: years

        });
    },
    filterMoviesByTitle(moviePerPage, page, sortBy, title) {

        return axios.get(`http://localhost:9000/movies?moviePerPage=${moviePerPage}&page=${page}&sortBy=${sortBy}&titleContains=${title}`);
    }


}
