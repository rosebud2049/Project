<template>
  <div id="users">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <button
        type="button"
        id="sidebarCollapse"
        class="btn btn-info mr-sm-2"
        data-toggle="modal"
        data-target="#exampleModal"
      >
        <span>Create User</span>
      </button>
      <form class="form-inline my-2 my-lg-0">
        <input
          id="search-input"
          v-model="search"
          class="form-control mr-sm-2"
          type="search"
          placeholder="Search"
          aria-label="Search"
        />
        <button @click="getUser()" class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
      </form>
    </nav>
    <table class="table table-striped">
      <thead class="thead-info">
        <tr>
          <th scope="col">id</th>
          <th scope="col">username</th>
          <th scope="col">email</th>
          <th scope="col">options</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(user, index) in users" v-bind:key="index">
          <th scope="row">{{ user.id }}</th>
          <td>{{ user.username }}</td>
          <td>{{ user.email }}</td>
          <td>
            <button
              type="button"
              id="sidebarCollapse"
              class="btn btn-outline-dark mr-sm-2"
              data-toggle="modal"
              data-target="#exampleModal1"
              @click="getIdAndIdx(user.id, index)"
            >
              <i class="fa fa-pencil" aria-hidden="true"></i>
            </button>
            <button
              @click="deleteUser(user.id, index)"
              type="button"
              id="sidebarCollapse"
              class="btn btn-outline-dark mr-sm-2"
            >
              <i class="fa fa-trash" aria-hidden="true"></i>
            </button>
          </td>
        </tr>
      </tbody>
    </table>
    <div
      class="modal fade"
      id="exampleModal"
      tabindex="-1"
      role="dialog"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-dialog-centered" role="document" id="exampleModal">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Create User</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form>
              <div class="form-group">
                <label>Username</label>
                <input
                  v-model="user.username"
                  id="modal-username-input"
                  type="text"
                  name="username"
                  class="form-control"
                />
              </div>

              <div class="form-group">
                <label>email</label>
                <input
                  v-model="user.email"
                  id="modal-email-input"
                  type="email"
                  name="email"
                  class="form-control"
                />
              </div>
              <div class="form-group">
                <label>Password</label>
                <input
                  v-model="user.password"
                  id="modal-password-input"
                  type="password"
                  name="password"
                  class="form-control"
                />
              </div>
              <div class="form-group">
                <label>Role</label>
                <input
                  v-model="user.role"
                  id="modal-role-input"
                  type="text"
                  name="role"
                  class="form-control"
                />
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button id="test" @click.prevent="createUser" type="button" class="btn btn-info">Create</button>
          </div>
        </div>
      </div>
    </div>
    <div
      class="modal fade"
      id="exampleModal1"
      tabindex="-1"
      role="dialog"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-dialog-centered" role="document" id="exampleModal1">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Update User</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form>
              <div class="form-group">
                <label>Username</label>
                <input
                  v-model="user.username"
                  id="modal-username-input1"
                  type="text"
                  name="username"
                  class="form-control"
                />
              </div>

              <div class="form-group">
                <label>email</label>
                <input
                  v-model="user.email"
                  id="modal-email-input1"
                  type="email"
                  name="email"
                  class="form-control"
                />
              </div>
              <div class="form-group">
                <label>Password</label>
                <input
                  v-model="user.password"
                  id="modal-password-input1"
                  type="password"
                  name="password"
                  class="form-control"
                />
              </div>
              <div class="form-group">
                <label>Role</label>
                <input
                  v-model="user.role"
                  id="modal-role-input1"
                  type="text"
                  name="role"
                  class="form-control"
                />
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button
              id="test"
              @click.prevent="updateUser(user.id)"
              type="button"
              class="btn btn-info"
            >Update</button>
          </div>
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
        password: "",
        role: ""
      },
      users: null,
      userId: "",
      userIdx: "",
      search: ""
    };
  },
  methods: {
    getIdAndIdx: function(id, idx) {
      this.user.userId = id;
      this.user.userIdx = idx;
      $("button").click(function() {
        $("#modal-username-input").val("");
        $("#modal-email-input").val("");
        $("#modal-password-input").val("");
        $("#modal-role-input").val("");
        $("#modal-username-input1").val("");
        $("#modal-email-input1").val("");
        $("#modal-password-input1").val("");
        $("#modal-role-input1").val("");
      });
    },
    createUser: function() {
      axios
        .post("http://localhost:4001/api/users", {
          user: {
            username: this.user.username,
            email: this.user.email,
            password: this.user.password,
            role: this.user.role
          }
        })
        .then(response => {
          this.users.push(response.data.data);
          const Toast = Swal.mixin({
            toast: true,
            position: "top-end",
            showConfirmButton: false,
            timer: 3000
          });

          Toast.fire({
            type: "success",
            title: "User created successfully"
          });
          $("#exampleModal").modal("hide");
          $("button").click(function() {
            $("#modal-username-input").val("");
            $("#modal-email-input").val("");
            $("#modal-passsword-input").val("");
            $("#modal-role-input").val("");
            $("#modal-username-input1").val("");
            $("#modal-email-input1").val("");
            $("#modal-password-input1").val("");
            $("#modal-role-input1").val("");
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
    },
    updateUser: function() {
      axios
        .put("http://localhost:4001/api/users/" + this.user.userId, {
          user: {
            username: this.user.username,
            email: this.user.email,
            password: this.user.password,
            role: this.user.role
          }
        })
        .then(response => {
          this.users.push(response.data.data);
          this.users.splice(this.user.userIdx, 1);
          const Toast = Swal.mixin({
            toast: true,
            position: "top-end",
            showConfirmButton: false,
            timer: 3000
          });

          Toast.fire({
            type: "success",
            title: "User updated successfully"
          });
          $("#exampleModal1").modal("hide");
          $("button").click(function() {
            $("#modal-username-input").val("");
            $("#modal-email-input").val("");
            $("#modal-username-input1").val("");
            $("#modal-email-input1").val("");
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
    },
    getUsers: function() {
      axios
        .get("http://localhost:4001/api/users")
        .then(response => {
          this.users = response.data.data;
          // eslint-disable-next-line
          console.log(response.data.data);
        })
        .catch(err => {
          // eslint-disable-next-line
          console.log(err);
        });
    },
    getUser: function() {
      console.log(this.search);
      axios
        .get("http://localhost:4001/api/users?email=" + this.search)
        .then(response => {
          console.log(response);
          this.users = response.data.data;
        })
        .catch(err => {
          console.log(err);
        });
    },
    deleteUser: function(id, idx) {
      Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!"
      }).then(result => {
        if (result.value) {
          Swal.fire("Deleted!", "Your file has been deleted.", "success");
          axios
            .delete("http://localhost:4001/api/users/" + id)
            .then(response => {
              this.users.splice(this.user.userIdx, 1);
              // eslint-disable-next-line
              console.log(response);
            })
            .catch(err => {
              // eslint-disable-next-line
              console.log(err);
            });
        }
      });
    }
  },
  beforeMount() {
    this.getUsers();
  }
};
</script>

<style>
</style>