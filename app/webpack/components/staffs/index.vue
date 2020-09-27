<template>
<div>
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>Staff Members</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="/">Home</a></li>
            <li class="breadcrumb-item active">Staff Members</li>
          </ol>
        </div>
      </div>
    </div><!-- /.container-fluid -->
  </section>

  <!-- Main content -->
  <section class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header">
              <h3 class="card-title">Staff</h3>
              <div class="card-tools">
                <div class="input-group input-group-sm">
                  <div class="input-group-append">
                    <a href="/staffs/new" title="Create new" class="btn btn-default">
                      <i class="fas fa-plus"></i>
                    </a>
                  </div>
                </div>
              </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body table-responsive p-0">
              <table class="table table-hover text-nowrap">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th></th>
                  </tr>
                </thead>
                <tbody v-if="staffs">
                  <tr v-for="staff in staffs" :key="staff.id">
                    <td>{{staff.id}}</td>
                    <td>{{staff.name}}</td>
                    <td>
                      <a target="_blank" :href="editUrl(staff.id)">
                        <i class="fa fa-edit"></i>
                      </a>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
      </div>
      <!-- /.row -->
    </div><!-- /.container-fluid -->
  </section>
  <!-- /.content -->
</div>
</template>
<script>
import axios from 'axios'
export default {
  data: function() {
    return {
      staffs: null
    }
  },
  mounted() {
    axios.get('/api/staffs')
      .then(response => {
        this.staffs = response.data;
      })
      .catch(error => {
        console.log(error.response);
      });
  },
  methods: {
    editUrl: function(id) {
      return '/staffs/' + id + '/edit';
    }
  }
}
</script>
