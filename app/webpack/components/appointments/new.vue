<template>
<div>
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>New Appointment</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="/">Home</a></li>
            <li class="breadcrumb-item active">New Appointment</li>
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
            <h3 class="card-title">Appointment</h3>
          </div>
          <!-- /.card-header -->
          <!-- form start -->
          <form v-on:submit.prevent="saveAppointment" role="form">
            <div class="card-body">
              <label for="client">Client</label>
              <div class="input-group input-group-md mb-3">
                <input id="client" placeholder="Id or Code" type="text" v-model="clientParameter" class="form-control">
                <div class="input-group-append">
                  <button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown">
                    Search
                  </button>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item client-button-search" v-on:click="findClient('/api/clients/')">
                      By Id
                    </li>
                    <li class="dropdown-item client-button-search" v-on:click="findClient('/api/clients/code/')">
                      By Code
                    </li>
                  </ul>
                </div>
                <!-- /btn-group -->
              </div>
              <div class="form-group">
                <label for="">Name</label> <span>{{clientName}}</span>
              </div>
              <div class="form-group">
                <label>Staff</label>
                <select v-if="staffs" required v-model="idStaff" id="staffSelector" class="form-control select2">
                  <option v-for="staff in staffs" :value="staff.id">{{staff.name}}</option>
                </select>
              </div>
              <div class="form-group">
                <label>Date</label>
                <div class="input-group date" id="reservationdate" data-target-input="nearest">
                  <input type="text" v-model="date" class="form-control datetimepicker-input" data-target="#reservationdate" />
                  <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                  </div>
                </div>
              </div>
              <div class="bootstrap-timepicker">
                <div class="form-group">
                  <label>Start Time</label>
                  <div class="input-group date" id="starttimepicker" data-target-input="nearest">
                    <input type="text" v-model="startTime" class="form-control datetimepicker-input" data-target="#starttimepicker" />
                    <div class="input-group-append" data-target="#starttimepicker" data-toggle="datetimepicker">
                      <div class="input-group-text"><i class="far fa-clock"></i></div>
                    </div>
                  </div>
                  <!-- /.input group -->
                </div>
                <!-- /.form group -->
              </div>
              <div class="bootstrap-timepicker">
                <div class="form-group">
                  <label>End Time</label>
                  <div class="input-group date" id="endtimepicker" data-target-input="nearest">
                    <input type="text" v-model="endTime" class="form-control datetimepicker-input" data-target="#endtimepicker" />
                    <div class="input-group-append" data-target="#endtimepicker" data-toggle="datetimepicker">
                      <div class="input-group-text"><i class="far fa-clock"></i></div>
                    </div>
                  </div>
                  <!-- /.input group -->
                </div>
                <!-- /.form group -->
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
require('select2')
require('tempusdominus-bootstrap-4')
import '../../stylesheets/appointments';
export default {
  props: ['datePreselected'],
  data: function() {
    return {
      clientParameter: '',
      idClient: '',
      clientName: '',
      idStaff: '',
      staffs: null,
      date: this.datePreselected,
      startTime: '',
      endTime: ''
    }
  },
  mounted() {
    var vueInstance = this;
    $('#reservationdate').datetimepicker({
      format: 'Y-MM-DD'
    });
    $('#reservationdate').on('change.datetimepicker', function(e) {
      vueInstance.date = e.date.format('Y-MM-DD');
    });
    $('#starttimepicker').datetimepicker({
      format: 'HH:mm'
    });
    $('#starttimepicker').on('change.datetimepicker', function(e) {
      vueInstance.startTime = e.date.format('HH:mm');
    });
    $('#endtimepicker').datetimepicker({
      format: 'HH:mm'
    });
    $('#endtimepicker').on('change.datetimepicker', function(e) {
      vueInstance.endTime = e.date.format('HH:mm');
    });
    axios
      .get('/api/staffs')
      .then(response => {
        this.staffs = response.data;
      })
      .catch(error => {
        if (error.response.status == 500) {
          toastr.error("There was an error trying get the staffs.");
        }
        console.log(error.response);
      });
  },
  updated() {
    let vueInstance = this;
    if (vueInstance.idStaff == '') {
      $('#staffSelector').select2();
      $('#staffSelector').on('select2:select', function(e) {
        var data = e.params.data;
        vueInstance.idStaff = data.id;
      });
    }
  },
  methods: {
    saveAppointment: function() {
      axios
        .post('/api/appointments', {
          date: this.date,
          startTime: this.startTime,
          endTime: this.endTime,
          clientId: this.idClient,
          staffId: this.idStaff
        })
        .then(response => {
          toastr.success('Appointment created.');
          window.location.href = '/appointments';
        })
        .catch(error => {
          if (error.response.status == 500) {
            toastr.error("Appointment couldn't be created due to an unexpected error.");
          } else if (error.response.status == 400) {
            let message = '';
            for (const [key, value] of Object.entries(error.response.data)) {
              message += key + ': ' + value.join(', ') + '<br/>';
            }
            toastr.warning(message);
          }
          console.log(error.response);
        });
    },
    findClient: function(route) {
      axios
        .get(route + this.clientParameter)
        .then(response => {
          if (response.status == 200) {
            this.idClient = response.data.id;
            this.clientName = response.data.name;
          }
        })
        .catch(error => {
          if (error.response.status == 500) {
            toastr.error("There was an error trying get the client.");
          }
          console.log(error.response);
        });
    },
    changeDate: function(date) {
      this.date = date;
    }
  }
}
</script>
<style lang="scss" media="screen">
@import 'tempusdominus-bootstrap-4/build/css/tempusdominus-bootstrap-4';
</style>
