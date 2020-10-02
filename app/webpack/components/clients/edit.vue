<template>
<div>
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>New Client</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="/">Home</a></li>
            <li class="breadcrumb-item active">New Client</li>
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
            <h3 class="card-title">Client</h3>
          </div>
          <!-- /.card-header -->
          <!-- form start -->
          <form v-on:submit.prevent="saveClient" role="form">
            <div class="card-body">
              <div class="form-group">
                <label for="name">Name</label>
                <input v-model="name" required type="text" class="form-control" id="name" placeholder="Name">
              </div>
              <div class="form-group">
                <label for="phone">Phone</label>
                <input v-model="phone" required type="tel" class="form-control" id="phone" placeholder="Phone">
              </div>
              <div class="form-group">
                <label for="email">Email</label>
                <input v-model="email" required type="email" class="form-control" id="email" placeholder="Email">
              </div>
              <div class="form-group">
                <label for="code" class="control-label">Code</label>
                <input v-model="code" type="text" class="form-control" id="code" placeholder="Code">
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
  props: ['id'],
  data: function() {
    return {
      name: '',
      phone: '',
      email: '',
      code: null
    }
  },
  mounted() {
    axios
      .get('/api/clients/' + this.id)
      .then(response => {
        this.name = response.data.name;
        this.phone = response.data.phone;
        this.email = response.data.email;
        this.code = response.data.code;
      })
      .catch(error => {
        if (error.response.status == 500) {
          toastr.error("There was an error trying get the client.");
        }
        console.log(error.response);
      });
  },
  methods: {
    saveClient: function() {
      axios
        .put('/api/clients/' + this.id, {
          name: this.name,
          phone: this.phone,
          email: this.email,
          code: this.code
        })
        .then(response => {
          toastr.success('Client updated.');
          window.location.href = '/clients';
        })
        .catch(error => {
          if (error.response.status == 500) {
            toastr.error("Client couldn't be edited due to an unexpected error.");
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
