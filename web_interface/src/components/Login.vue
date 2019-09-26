<template>
  <div id="login">
    <div class="container-fluid bg">
      <div class="row justify-content-center">
        <div class="col-12 col-sm-6">
          <form class="form-container">
            <div class="form-group">
              <label for="exampleInputEmail1">Email address</label>
              <input
                v-model="user.email"
                type="email"
                class="form-control"
                id="exampleInputEmail1"
                aria-describedby="emailHelp"
                placeholder="Enter email"
                required
              />
              <small
                id="emailHelp"
                class="form-text text-muted"
              >We'll never share your email with anyone else.</small>
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">Password</label>
              <input
                v-model="user.password"
                type="password"
                class="form-control"
                id="exampleInputPassword1"
                placeholder="Password"
                required
              />
            </div>
            <button @click="login" type="submit" class="btn btn-info btn-block">Sign in</button>
          </form>
        </div>
        <p>{{ this.user.test }}</p>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable */

import axios from "axios";
import store from "../store"

export default {
  props: [],
  data() {
    return {
      user: {
        username: "",
        email: "",
        password: "",
        token: ""
      }
    };
  },
  methods: {
    login: function(e) {
      e.preventDefault();
      if (this.user.password.length > 0) {
        axios
          .post("http://localhost:4002/api/users/sign_in", {
            user: {
              email: this.user.email,
              password: this.user.password
            }
          })
          .then(response => {
            this.user.token = response.data.jwt;
            let config = {
              headers: {
                Authorization: "Bearer " + this.user.token
              }
            };
            console.log(config);
            localStorage.setItem("jwt", response.data.jwt);
            axios
              .get("http://localhost:4002/api/my_user", config)
              .then(response => {
                console.log(response);
                localStorage.setItem("user", JSON.stringify(response.data))
                this.user.username = response.data.username;
                this.user.email = response.data.email;
                store.commit('setUsername', this.user.username)
                
                if (localStorage.getItem('jwt') != null) {
                  this.$router.push('/user')
                }
                
                const Toast = Swal.mixin({
                  toast: true,
                  position: "top-end",
                  showConfirmButton: false,
                  timer: 3000
                });

                Toast.fire({
                  type: "success",
                  title: "User signed in successfully"
                });
              })
              .catch(err => {
                console.log(err);
              });
          })
          .catch(err => console.log(err));
        // if (response) {
        //   this.$router.push("/users");
        // }
      }
    }
  }
};
</script>

<style scoped>
.form-container {
  margin-top: 15vh;
  background: #fff;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0px 0px 10px 0px #000;
}

.bg {
  background: rgb(231, 231, 231);
  height: 100vh;
}
</style>