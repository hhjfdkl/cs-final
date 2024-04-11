import axios from 'axios';

export default {


    getMoviePage(moviePerPage, page, sortBy) {
        return axios.get(`/movies/${moviePerPage}/${page}/${sortBy}`);
    },
    getUserFavMovie(moviePerPage, page, sortBy) {
        return axios.get(`/movies/favorites/${moviePerPage}/${page}/${sortBy}`);
    },
    addFav(movieId) {
        console.log(movieId)
        return axios.post(`/favorites/${movieId}`);
    },
    isFav(movieId) {
        return axios.get(`/favorites/${movieId}`);
    },
    deleteFav(movieId) {
        return axios.delete(`/favorites/${movieId}`);
    }


}
