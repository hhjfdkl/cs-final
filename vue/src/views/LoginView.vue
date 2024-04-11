<template>
  <div id="login">
    <img src="src\assets\Box_ffice__5_-removebg-preview.png" alt="BOB Dark Logo" class="logo">
    <link href='https://fonts.googleapis.com/css?family=League Spartan' rel='stylesheet'>
    <form v-on:submit.prevent="login">
      <h1>Please Sign In</h1>
      <div role="alert" v-if="invalidCredentials">
        Invalid username and password!
      </div>
      <div role="alert" v-if="this.$route.query.registration">
        Thank you for registering, please sign in.
      </div>
      <div class="form-input-group">
        <label for="username">Username</label>
        <input type="text" id="username" v-model="user.username" required autofocus />
      </div>
      <div class="form-input-group">
        <label for="password">Password</label>
        <input type="password" id="password" v-model="user.password" required />
      </div>
      <button type="submit">Sign in</button>
      <p>
        <router-link v-bind:to="{ name: 'register' }">Need an account? Sign up.</router-link>
      </p>
    </form>
  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {
  components: {},
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      invalidCredentials: false
    };
  },
  methods: {
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            this.$router.push("/movies/9/1/movie_id");
          }
        })
        .catch(error => {
          const response = error.response;

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    }
  }
};
</script>

<style scoped>
.form-input-group {
  margin-bottom: 1rem;
  display: flex;
  align-items: center;
  justify-content: center;
}

label {
  margin-right: 0.5rem;
  font-weight: bold;
  font-family: 'League Spartan';
  color: #7B3911;
}

img {
  width: 35%;
  margin: 0 auto;

}

input[type=text],
input[type=password] {
  padding: 0.5rem;
  border-radius: 4px;
  border: none;
  box-shadow: 0 2px 4px #7B3911;
  width: 20rem;
  margin-right: 1rem;
}

button[type=submit] {
  background-color: #DC661F;
  color: #f8f2bf;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
  display: block;
  margin: 0 auto;
  font-family: 'league spartan';
  /* added styles */
}

a {
  /* text-decoration: none; */
  color: #7B3911;
  margin-left: 1rem;
}

#login {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 80vh;
  background-color: #fff0cb;
}

h1 {
  font-size: 2rem;
  color: #7B3911;
  text-align: center;
  margin-bottom: 2rem;
  font-family: 'League Spartan';

}

div[role=alert] {
  background-color: #890304;
  color: white;
  padding: 0.5rem;
  border-radius: 4px;
  margin-bottom: 1rem;
  text-align: center;
}

p {
  text-align: center;
  font-family: 'league spartan';
}
</style>
