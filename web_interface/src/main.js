import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'
import Users from './components/Users'
import Home from './components/Home'
import Login from './components/Login'
import Register from './components/Register'

Vue.config.productionTip = false

Vue.use(VueRouter)

const routes = [
  { path: '/', component: Home},
  { path: '/users', component: Users },
  { path: '/login', component: Login },
  { path: '/register', component: Register }
]

const router = new VueRouter({
  routes
})

new Vue({
  render: h => h(App),
  router
}).$mount('#app')
