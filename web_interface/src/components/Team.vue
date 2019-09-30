<template>
  <div id="team">
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
     <button
      type="button"
      id="sidebarCollapse"
      class="btn btn-info mr-sm-2"
      data-toggle="modal"
      data-target="#exampleModal"
    >
      <span>Create Team</span>
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
        <button @click="getTeam()" class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
      </form>
    </nav>
     <table class="table table-striped">
      <thead class="thead-info">
        <tr>
          <th scope="col">id</th>
          <th scope="col">name</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(team, index) in teams" v-bind:key="index">
          <th scope="row">{{ team.id }}</th>
          <td>{{ team.name }}</td>
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
            <h5 class="modal-title" id="exampleModalLabel">Create Team</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form>
              <div class="form-group">
                <label>Name</label>
                <input
                  v-model="team.name"
                  id="modal-name-input"
                  type="text"
                  name="name"
                  class="form-control"
                />
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button id="test" @click.prevent="createTeam" type="button" class="btn btn-info">Create</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
/*eslint-disable*/

import axios from "axios";

export default {
  data() {
    return {
      team: {
        name: ""
      },
      teams: [],
      search: ""
    };
  },
  methods: {
    createTeam() {
      axios
        .post("http://localhost:4002/api/teams", {
          team: {
            name: this.team.name
          }
        })
        .then(response => {
          console.log(response);
            this.teams.push(response.data.data)
          const Toast = Swal.mixin({
            toast: true,
            position: "top-end",
            showConfirmButton: false,
            timer: 3000
          });

          Toast.fire({
            type: "success",
            title: "Team created successfully"
          });

          $("#exampleModal").modal("hide");
          $("button").click(function() {
            $("#modal-name-input").val("");
          });
        })
        .catch(err => {
          console.log(err);
        });
    },
    getTeam: function() {
      console.log(this.search);
      axios
        .get("http://localhost:4002/api/teams/" + this.search)
        .then(response => {
          console.log(response);
          this.teams = [response.data.data];
        })
        .catch(err => {
          console.log(err);
        });
    },
  getTeams: function() {
      axios
        .get("http://localhost:4002/api/teams")
        .then(response => {
          this.teams = response.data.data;
          // eslint-disable-next-line
          console.log(response.data.data);
        })
        .catch(err => {
          // eslint-disable-next-line
          console.log(err);
        });
    }
  },
    beforeMount() {
        this.getTeams();
    }
};
</script>

<style>
</style>