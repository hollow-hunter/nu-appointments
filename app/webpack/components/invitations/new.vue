<template>
<div>
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>New Invitation</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="/">Home</a></li>
            <li class="breadcrumb-item active">New Invitation</li>
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
            <h3 class="card-title">Invitation</h3>
          </div>
          <!-- /.card-header -->
          <!-- form start -->
          <form v-on:submit.prevent="saveInvitation" role="form">
            <div class="card-body">
              <div class="form-group">
                <label for="email">Email</label>
                <input v-model="email" required type="text" class="form-control" id="email" placeholder="Email">
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
      email: ''
    }
  },
  methods: {
    saveInvitation: function() {
      axios
        .post('/api/invitations', {
            email: this.email
        })
        .then(response => {
          toastr.success('Invitation created.');
          setTimeout(() => {
            window.location.href = '/';
          }, 1000);
        })
        .catch(error => {
          if (error.response.status == 500) {
            toastr.error("Invitation couldn't be created due to an unexpected error.");
          } else if (error.response.status == 400) {
            let message = '';
            for (const [key, value] of Object.entries(error.response.data)) {
              message += key + ': ' + value.join(', ') + '<br/>';
            }
            toastr.warning(message);
          }
          console.log(error.response);
        });
    }
  }
}
</script>
