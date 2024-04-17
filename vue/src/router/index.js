import { createRouter as createRouter, createWebHistory } from 'vue-router'
import { useStore } from 'vuex'

// Import components
import HomeView from '../views/HomeView.vue';
import LoginView from '../views/LoginView.vue';
import LogoutView from '../views/LogoutView.vue';
import RegisterView from '../views/RegisterView.vue';
import TitlepageView from '../views/TitlepageView.vue';
import FavView from '../views/FavView.vue';
import AccountView from '../views/AccountView.vue';
import AdvanceFilter from '../components/AdvanceFilter.vue';
import FilteredMovie from '../views/FilteredMovieView.vue';
import FullMovieDetail from '../views/FullMovieDetailView.vue';
import UserReviews from '../views/UserReviewsView.vue';
import ArticleView from '../views/ArticleView.vue';

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */
const routes = [
  {//remove this
    path: '/',
    name: 'home',
    component: TitlepageView,
    meta: {
      requiresAuth: true
    }
  },
  {
    path: "/login",
    name: "login",
    component: LoginView,
    meta: {
      requiresAuth: false
    }
  },
  {
    path: "/logout",
    name: "logout",
    component: LogoutView,
    meta: {
      requiresAuth: false
    }
  },
  {
    path: "/register",
    name: "register",
    component: RegisterView,
    meta: {
      requiresAuth: false
    }
  },
  {
    path: "/title",
    name: "title",
    component: TitlepageView,
    meta: {
      requiresAuth: false
    }
  },
  {
    path: "/movies/:pageSize/:page/:sort/",
    name: "movies",
    component: HomeView,
    meta: {
      requiresAuth: true
    }
  },
  {
    path: "/movies/favorites/:pageSize/:page/:sort/",
    name: "favorites",
    component: FavView,
    meta: {
      requiresAuth: true
    }
  },
  {
    path: "/account/:pageSize/:page/:sort/"
    , name: "account"
    , component: AccountView
    , meta: {
      requiresAuth: true
    }
  },
  {
    path: "/filter",
    name: "filterSearch",
    component: AdvanceFilter,
    meta: {
      requiresAuth: true
    }
  },
  {
    path: "/filterMovies/:pageSize/:page/:sort/",
    name: "filterMovies",
    component: FilteredMovie,
    meta: {
      requiresAuth: true
    }

  },
  {
    path: "/movies/view/:movieId/",
    name: "fullMovieDetails",
    component: FullMovieDetail,
    meta: {
      requiresAuth: true
    }
  },
  {
    path: "/reviews",
    name: "reviews",
    component: UserReviews,
    meta: {
      requiresAuth: true
    }

  },
  {
    path: "/articles/:articleId/",
    name: "articles",
    component: ArticleView,
    meta: {
      requiresAuth: false
    }
  }
  // {
  //   path: "/movies/:pageSize/:page/:sort/:search/",
  //   name: "moviesTitleSearch",
  //   component: HomeView,
  //   meta: {
  //     requiresAuth: true
  //   }
  // }
];

// Create the router
const router = createRouter({
  history: createWebHistory(),
  routes: routes
});

router.beforeEach((to) => {

  // Get the Vuex store
  const store = useStore();

  // Determine if the route requires Authentication
  const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

  // If it does and they are not logged in, send the user to "/login"
  if (requiresAuth && store.state.token === '') {
    return { name: "login" };
  }
  // Otherwise, do nothing and they'll go to their next destination
});

export default router;
