<template>
  <div id="capstone-app">

    <nav id="nav-bar">
      <router-link v-bind:to="{ name: 'title' }">

        <img src="../src\assets\Light Theme Logo.png" alt="BOB Light Logo" class="logo">


        <link href='https://fonts.googleapis.com/css?family=League Spartan' rel='stylesheet'>
      </router-link>
      <router-link v-bind:to="{ name: 'login' }" class="nav-button"
        v-if="this.$store.state.token == ''">Login</router-link>&nbsp;&nbsp;
      <!-- <router-link v-bind:to="{ name: 'favorites' }" class="nav-button">fav</router-link> -->
      <router-link v-bind:to="{ name: 'register' }" class="nav-button" v-if="this.$store.state.token == ''">Sign
        Up</router-link>
      <router-link v-bind:to="{ name: 'logout' }" class="nav-button" v-else>Log out</router-link>


      <router-link v-bind:to="{ name: 'favorites', params: { pageSize: 9, page: 1, sort: 'movie_id' } }"
        class="nav-button" v-if="this.$store.state.token != ''">
        Favorites
      </router-link>
      <router-link v-bind:to="{ name: 'movies', params: { pageSize: 9, page: 1, sort: 'movie_id' } }" class="nav-button"
        v-if="this.$store.state.token != ''">
        Movies
      </router-link>
      <router-link v-bind:to="{ name: 'account', params: { pageSize: 9, page: 1, sort: 'movie_id' } }" class="nav-button"
        v-if="this.$store.state.token != ''">
        Account
      </router-link>
    </nav>

    <nav class="top-bar">
      <form class="top-bar-search" @submit.prevent="searchMovies">
        <input class="search" type="text" v-model="searchTerm" placeholder="Search movies">
        <button class="search-submit" type="submit">Search
        </button>
      </form>
    </nav>
    <div id="outofnav">
      <router-view />
    </div>
  </div>
</template>



<style>
html {
  background-color: #fff0cb;
}

.search-submit {
  width: 55px;
  height: 25px;
  font-size: 14px;
  border: none;

}

.search {
  width: 6000px;
  margin-right: 10px;
  height: 25px;
  font-size: 14px;
}



.top-bar-search {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 1100px;
  height: 25px;
  font-size: 14px;

}

.top-bar {

  background-color: #890304;
  grid-area: top;
  display: flex;
  align-items: center;
  justify-content: center;
}






body {
  margin: 0px;
  padding: 0px;
  border: 0px;
}

#capstone-app {
  display: grid;
  grid-template-rows: 1fr 16fr;
  grid-template-areas:
    "top top"
    "nav main"
  ;
  /* grid-area */
  margin: 0px;
  padding: 0px;
  border: 0px;

}

#nav-bar {
  grid-area: nav;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  /* border-bottom: 1px solid #002263; */
  /* padding: 1rem; */
  background-color: #890304;
  height: 100vh;
  position: sticky;
  width: 400px;
  /* position: fixed; */
  /* added */
  top: 0;
  /* added */
}


.logo {
  width: 40%;
  min-width: 100px;
  height: auto;
}

#nav-bar .logo {
  width: 100%;
}


#nav-bar .nav-button {
  display: inline-block;
  padding: 0.5rem 1rem;
  margin-bottom: 10px;
  min-width: 2rem;
  width: 50%;
  text-align: center;

  font-family: 'League Spartan';
  font-weight: 600;
  font-size: 1.25rem;
  background-color: #f8f2bf;
  color: #7B3911;
  text-decoration: none;
  transition: all 0.3s ease-in-out;
  border-radius: 0.5rem;
}


#nav-bar .nav-button:hover {
  background-color: #7B3911;
  border-color: #f8f2bf;
  border-radius: 0.5rem;
  color: #f8f2bf;
  cursor: pointer;
}

#outofnav {
  /* grid-area: main; */

  /* margin-left: 150px;
  margin-left: 10%; */

}

* {
  font-family: 'League Spartan';
}

@media screen and (max-width: 600px) {
  #capstone-app {
    grid-template-columns: 1fr;
    grid-template-areas:
      "nav"
      "main"
    ;
  }

  #nav-bar {
    height: auto;
    padding: 1rem 0;
    width: 100%;
  }

  #nav-bar .nav-button {
    font-size: 1rem;
  }

  #nav-bar .logo {
    width: 100%;
    height: auto;
  }

  #outofnav {
    margin-left: 0;
  }

}

@media screen and (max-width: 800px) {

  #capstone-app {
    grid-template-columns: 1fr;
    grid-template-areas:
      "nav"
      "main"
    ;
  }

  #nav-bar {
    height: auto;
    padding: 1rem 0;
    width: 100%;
    max-width: 30%;
  }

  #nav-bar .nav-button {
    font-size: 1rem;

  }

  #nav-bar .logo {
    width: 100%;
    height: auto;
  }

}
</style>
