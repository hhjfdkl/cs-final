import axios from 'axios';

export default {


    getArticle(id) {

        return axios.get(`/articles/${id}`);
    }

}
