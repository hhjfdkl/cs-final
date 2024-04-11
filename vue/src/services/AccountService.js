import axios from 'axios';

export default {


    getAccount() {
        return axios.get(`/account`)
    },
    getGenres() {


        return axios.get(`/genres`)
    },
    addGenre(id) {

        return axios.post(`/genres/${id}`)
    }, removeGenre(id) {

        return axios.delete(`/genres/${id}`)
    }

}
