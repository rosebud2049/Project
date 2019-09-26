/* eslint-disable */

import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'
import User from './components/User'
import Home from './components/Home'
import Login from './components/Login'
import Register from './components/Register'
import Admin from './components/Admin'
import store from './store'
import Workingtimes from './components/Workingtimes';


Vue.use(VueRouter)

const routes = [
  { path: '/', component: Home },
  {
    path: '/user',
    name: 'user',
    component: User,
    meta: { requiresAuth: true }
  },
  { path: '/login', component: Login },
  { path: '/register', component: Register },
  {
    path: '/admin',
    name: 'admin',
    component: Admin,
    meta: { requiresAuth: true }
  }
]

const router = new VueRouter({
  routes
})

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (localStorage.getItem('jwt') != null) {
      store.commit('setUserIsAuthenticated', true)
      let user = JSON.parse(localStorage.getItem('user'))
      if (user.role == 'admin') {
        store.commit('setUserIsAdmin', true)
      }
      next()
    } else {
      const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 3000
      });

      Toast.fire({
        type: "error",
        title: "Please log in first ..."
      });
    }
  } else {
    next()
  }
});

new Vue({
  store,
  router,
  render: h => h(App),
}).$mount('#app')

