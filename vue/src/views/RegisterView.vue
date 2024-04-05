<template>
  <div id="register" class="text-center">
    <img src="src\assets\Dark Theme Logo.png" alt="BOB Dark Logo" class="logo">
    <form v-on:submit.prevent="register">
      <h1>Create Account</h1>
      <div role="alert" v-if="registrationErrors">
        {{ registrationErrorMsg }}
      </div>
      <div class="form-input-group">
        <label for="username">Username</label>
        <input type="text" id="username" v-model="user.username" required autofocus />
      </div>
      <div class="form-input-group">
        <label for="password">Password</label>
        <input type="password" id="password" v-model="user.password" required />
      </div>
      <div class="form-input-group">
        <label for="confirmPassword">Confirm Password</label>
        <input type="password" id="confirmPassword" v-model="user.confirmPassword" required />
      </div>
      <button type="submit">Create Account</button>
      <p><router-link v-bind:to="{ name: 'login' }">Already have an account? Log in.</router-link></p>
    </form>
  </div>
</template>

<script>
import authService from '../services/AuthService';

export default {
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        role: 'user',
      },
      registrationErrors: false,
      registrationErrorMsg: 'There were problems registering this user.',
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = 'Password & Confirm Password do not match.';
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: '/login',
                query: { registration: 'success' },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = 'Bad Request: Validation Errors';
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = 'There were problems registering this user.';
    },
  },
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
  /* added styles */
}

a {
  /* text-decoration: none; */
  color: #7B3911;
  margin-left: 1rem;
}

#register {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 80vh;

}

img {
  width: 35%;
  margin: 0 auto;

}

label {
  width: 75px;
  color: #7B3911;
}


h1 {
  font-size: 2rem;
  color: #7B3911;
  text-align: center;
  margin-bottom: 2rem;
}

div[role=alert] {
  background-color: #dc3545;
  color: white;
  padding: 0.5rem;
  border-radius: 4px;
  margin-bottom: 1rem;
  text-align: center;
}

p {
  text-align: center;

}
</style>
