import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
    state: {
        userIsAuthorized: false,
        isAdmin: false,
        user: "",
        workingtime: null
    },
    mutations: {
        setUserIsAuthenticated(state, replacement) {
            state.userIsAuthorized = replacement 
        },
        setUserIsAdmin(state, replacement) {
            state.isAdmin = replacement
        },
        setUsername(state, replacement) {
            state.user = replacement
        },
        setWorkingtime(state, replacement) {
            state.workingtime = replacement
        }
    },
    actions: {

    }
})