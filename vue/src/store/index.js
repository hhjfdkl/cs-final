import { createStore as _createStore } from 'vuex';
import axios from 'axios';
import AccountService from '../services/AccountService';

export function createStore(currentToken, currentUser) {
  let store = _createStore({
    state: {
      token: currentToken || '',
      user: currentUser || {},
      genres: [],
      filteredGenres: [],
      filteredYears: [],
      filteredRating: []
    },
    mutations: {
      SET_AUTH_TOKEN(state, token) {
        state.token = token;
        localStorage.setItem('token', token);
        axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      },
      SET_USER(state, user) {
        state.user = user;
        localStorage.setItem('user', JSON.stringify(user));
      },
      LOGOUT(state) {
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        state.token = '';
        state.user = {};
        axios.defaults.headers.common = {};
      },

      UPDATE_GENRES(state) {
        AccountService.getGenres().then(response => {
          state.genres = response.data
        });
      },

      FILTER_GENRES(state, genres) {
        state.filteredGenres = genres
      },
      FILTER_YEARS(state, years) {
        state.filteredYears = years
      },
      FILTER_RATINGS(state, ratings) {
        confirm("--" + ratings)
        state.filteredRating = ratings
      }
    },
  });





  return store;
}
