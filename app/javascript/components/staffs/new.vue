<template>
<div>
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>New Staff</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="/">Home</a></li>
            <li class="breadcrumb-item active">New Staff</li>
          </ol>
        </div>
      </div>
    </div><!-- /.container-fluid -->
  </section>

  <!-- Main content -->
  <section class="content">
    <div class="container-fluid">
      <div class="col-md-6 col-sm-12">
        <!-- general form elements -->
        <div class="card card-primary">
          <div class="card-header">
            <h3 class="card-title">Staff</h3>
          </div>
          <!-- /.card-header -->
          <!-- form start -->
          <form v-on:submit.prevent="saveStaff" role="form">
            <div class="card-body">
              <div class="form-group">
                <label for="name">Name</label>
                <input v-model="name" required type="text" class="form-control" id="name" placeholder="Name">
              </div>
            </div>
            <!-- /.card-body -->

            <div class="card-footer">
              <button type="submit" title="save" class="btn btn-primary">
                <i class="fa fa-save"></i>
              </button>
            </div>
          </form>
        </div>
      </div>
      <!-- /.row -->
    </div><!-- /.container-fluid -->
  </section>
  <!-- /.content -->
</div>
<!-- /.content-wrapper -->
</template>
<script>
import axios from 'axios'
import toastr from 'toastr'
export default {
  data: function() {
    return {
      name: ''
    }
  },
  methods: {
    saveStaff: function() {
      axios
        .post('/api/staffs', {
            name: this.name
        })
        .then(response => {
          toastr.success('Staff created.');
          window.location.href = '/staffs';
        })
        .catch(error => {
          if (error.response.status == 500) {
            toastr.error("Staff couldn't be created due to an unexpected error.");
          } else if (error.response.status == 400) {
            let nameErrors = error.response.data.name.join(', ');
            toastr.warning("Couldn't not be created due to: <br/> Name: " + nameErrors);
          }
          console.log(error.response);
        });
    }
  }
}
</script>
