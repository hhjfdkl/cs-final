import axios from 'axios';

export default {


    getMoviePage(moviePerPage, page, sortBy) {
        return axios.get(`/movies/${moviePerPage}/${page}/${sortBy}`)
    },

}
