import axios from 'axios';

export default {


    getAccount() {
        return axios.get(`/account`)
    },

}
