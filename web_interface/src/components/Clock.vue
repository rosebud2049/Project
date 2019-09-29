<template>
  <div id="clock">
    <div class="btn-group" role="group" aria-label="Basic example">
      <button @click="getClockIn" type="button" class="btn btn-secondary">Clock in</button>
      <button @click="getClockOut" type="button" class="btn btn-secondary">Clock out</button>
    </div>
  </div>
</template>

<script>
/* eslint-disable */

import axios from "axios";
import store from "../store"

export default {
  name: "Clock",
  data() {
    return {
      clockIn: "",
      clockOut: "",
      workingtimes: ""
    };
  },
  methods: {
    getClockIn: function() {
      axios
        .post("http://localhost:4002/api/workingtimes/clock_in/4")
        .then(response => {
          console.log(response);
          if (response.data == "Ce user a déjà clockIn!") {
            const Toast = Swal.mixin({
              toast: true,
              position: "top-end",
              showConfirmButton: false,
              timer: 3000
            });

            Toast.fire({
              type: "error",
              title: response.data
            });
          } else {
            this.clockIn = response.data.data.start
            const Toast = Swal.mixin({
              toast: true,
              position: "top-end",
              showConfirmButton: false,
              timer: 3000
            });

            Toast.fire({
              type: "success",
              title: "Clocked in succefully at " + response.data.data.start
            });
          }
        })
        .catch(err => {
          console.log(err);
        });
    },
    getClockOut: function() {
        axios
        .put("http://localhost:4002/api/workingtimes/clock_out/4")
        .then(response => {
          console.log(response);
          if (response.data == "Ce user n'a pas clockIn. ClockOut impossible") {
            const Toast = Swal.mixin({
              toast: true,
              position: "top-end",
              showConfirmButton: false,
              timer: 3000
            });

            Toast.fire({
              type: "error",
              title: response.data
            });
          } else {
            this.clockOut = response.data.data.end
            const Toast = Swal.mixin({
              toast: true,
              position: "top-end",
              showConfirmButton: false,
              timer: 3000
            });

            Toast.fire({
              type: "success",
              title: "Clocked out succefully at " + response.data.data.end
            });
          }
        })
        .catch(err => {
          console.log(err);
        });
    },
    getWorkingtime: function() {
        let date1 = new Date(this.clockIn)
        let date2 = new Date(this.clockOut)

        let workingtimes = ((date2 - date1) / 3600000)
        this.workingtimes = workingtimes
        console.log(this.workingtimes)
        store.commit('setWorkingtime', this.workingtimes)
    }
  }
};
</script>

<style>
</style>