<template>
  <div id="app">
    <nav id="navbar" class="navbar navbar-expand-lg navbar-dark bg-dark">
      <router-link to="/">
        <a href="#" class="navbar-brand text-white">Time Manager</a>
      </router-link>
      <ul class="navbar-nav mr-auto">
        <li class="nav-item">
          <router-link to="/login" v-if="!this.$store.state.userIsAuthorized">
            <a href="#" class="nav-link">Login</a>
          </router-link>
        </li>
        <li class="nav-item">
          <router-link to="/login" v-if="this.$store.state.userIsAuthorized">
            <a @click="logout" href="#" class="nav-link">Logout</a>
          </router-link>
        </li>
        <li class="nav-item">
          <router-link to="/register" v-if="!this.$store.state.userIsAuthorized">
            <a href="#" class="nav-link">Register</a>
          </router-link>
        </li>
          <Clock class="ml-5"/>
      </ul>
    </nav>
    <div class="wrapper">
      <!-- Sidebar -->
      <nav id="sidebar">
        <ul class="list-unstyled components">
          <p v-if="this.$store.state.userIsAuthorized">{{ this.$store.state.user }}</p>
          <li>
            <router-link to="/User">
              <a href="#">User</a>
            </router-link>
          </li>
          <li>
            <router-link v-if="this.$store.state.isAdmin" to="/Admin">
              <a v-if="this.$store.state.isAdmin" href="#">Admin</a>
            </router-link>
          </li>
          <li class="active">
            <a
              href="#homeSubmenu"
              data-toggle="collapse"
              aria-expanded="false"
              class="dropdown-toggle"
            >Home</a>
            <ul class="collapse list-unstyled" id="homeSubmenu">
              <li>
                <a href="#">Home 1</a>
              </li>
              <li>
                <a href="#">Home 2</a>
              </li>
              <li>
                <a href="#">Home 3</a>
              </li>
            </ul>
          </li>
        </ul>
      </nav>
      <div id="content">
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable */
import store from "./store";
import Clock from "./components/Clock"

export default {
  name: "app",
  components: {
    Clock
  },
  data() {
    return {
      childData: "",
      user: {
        username: "",
        email: ""
      }
    };
  },
  methods: {
    logout: function() {
      localStorage.removeItem("jwt");
      localStorage.removeItem("user");
      store.commit("setUserIsAdmin", false);
      store.commit("setUserIsAuthenticated", false);
    }
  }
};
</script>

<style scoped>
@import "https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700";

.wrapper {
  display: flex;
  width: 100%;
  align-items: stretch;
}

#content {
  width: 100%;
}

body {
  font-family: "Poppins", sans-serif;
  background: #fafafa;
}

p {
  font-family: "Poppins", sans-serif;
  font-size: 1.1em;
  font-weight: 300;
  line-height: 1.7em;
  color: #999;
}

a,
a:hover,
a:focus {
  color: inherit;
  text-decoration: none;
  transition: all 0.3s;
}

#sidebar {
  /* don't forget to add all the previously mentioned styles here too */
  background: #7386d5;
  color: #fff;
  transition: all 0.3s;
  min-width: 250px;
  max-width: 250px;
  min-width: 250px;
  max-width: 250px;
  min-height: 100vh;
}

#sidebar .sidebar-header {
  padding: 20px;
  background: #6d7fcc;
}

#sidebar ul.components {
  padding: 20px 0;
  border-bottom: 1px solid #47748b;
}

#sidebar ul p {
  color: #fff;
  padding: 10px;
}

#sidebar ul li a {
  padding: 10px;
  font-size: 1.1em;
  display: block;
}
#sidebar ul li a:hover {
  color: #7386d5;
  background: #fff;
}

#sidebar ul li.active > a,
a[aria-expanded="true"] {
  color: #fff;
  background: #6d7fcc;
}
ul ul a {
  font-size: 0.9em !important;
  padding-left: 30px !important;
  background: #6d7fcc;
}
</style>
