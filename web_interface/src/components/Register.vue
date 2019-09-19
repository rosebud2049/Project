<template>
  <div id="register">
    <div class="container-fluid bg">
      <div class="row justify-content-center">
        <div class="col-12 col-sm-6">
          <form class="form-container">
            <div class="form-group">
              <label for="exampleInputEmail1">Username</label>
              <input
                v-model="user.username"
                type="text"
                class="form-control"
                id="exampleInputUsername1"
                aria-describedby="emailHelp"
                placeholder="Enter username"
              />
            </div>
            <div class="form-group">
              <label for="exampleInputEmail1">Email address</label>
              <input
                v-model="user.email"
                type="email"
                class="form-control"
                id="exampleInputEmail1"
                aria-describedby="emailHelp"
                placeholder="Enter email"
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
              />
            </div>
            <!-- <label for="exampleInputPassword1">Role</label>
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <label class="input-group-text" for="inputGroupSelect01">Options</label>
              </div>
              <select class="custom-select" id="inputGroupSelect01" >
                <option
                  class="custom-select" id="inputGroupSelect01"
                >{{ role.text }}</option>
              </select>
            </div> -->
            <button type="submit" class="btn btn-info btn-block">Sign Up</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable */
import axios from "axios";

export default {
  props: [],
  data() {
    return {
      user: {
        username: "",
        email: "",
        password: ""
      },
      // idx: "",
      // selected: "Choose...",
      // roles: [
      //   { text: "admin", value: "admin" },
      //   { text: "user", value: "user" }
      // ]
    };
  },
  methods: {
    // getIdx: function(idx) {
    //   this.idx = idx
    // },
    register: function(index) {
      // console.log(this.roles[this.idx])
      axios
        .post("http://localhost:4001/api/users", {
          user: {
            username: this.user.username,
            email: this.user.email,
            password: this.user.password,
            role: this.role
          }
        })
        .then(response => {
          console.log(response.data.data);
          const Toast = Swal.mixin({
            toast: true,
            position: "top-end",
            showConfirmButton: false,
            timer: 3000
          });

          Toast.fire({
            type: "success",
            title: "User registered successfully"
          });

          this.info = response;
          // eslint-disable-next-line
          console.log(this.info);
          console.log(response.data.data);
        })
        .catch(err => {
          // eslint-disable-next-line
          console.log(err);
        });
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