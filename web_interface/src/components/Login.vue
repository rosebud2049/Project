<template>
  <div id="login">
    <div class="container-fluid bg">
      <div class="row justify-content-center">
          <div class="col-12 col-sm-6">

        <form class="form-container">
          <div class="form-group">
            <label for="exampleInputEmail1">Email address</label>
            <input
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
              type="password"
              class="form-control"
              id="exampleInputPassword1"
              placeholder="Password"
            />
          </div>
          <button type="submit" class="btn btn-info btn-block">Sign in</button>
        </form>
          </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {};
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