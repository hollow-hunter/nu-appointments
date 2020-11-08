<template lang="html">
  <div>
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Appointments Status</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/">Home</a></li>
              <li class="breadcrumb-item active">Appointments Status</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="col-md-12 col-sm-12">
          <!-- general form elements -->
          <div class="card card-primary">
            <div class="card-header">
              <h3 class="card-title">Status</h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <div id="kanbanContainer" class="">

              </div>
            </div>
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
require('jkanban');
import axios from 'axios'
import toastr from 'toastr'
export default {
  data() {
    return {
      events: null,
      kanban: null
    }
  },
  mounted() {
    axios
      .get('/api/appointments')
      .then(response => {
        this.appointmentsCount = response.data.length;
        this.events = response.data.map(e => {
          let startDate = moment(e.date);
          let endDate = moment(e.date);
          let startTime = moment.utc(e.startTime);
          let endTime = moment.utc(e.endTime);
          return {
            id: e.id,
            url: '/appointments/' + e.id + '/edit',
            status: e.status,
            title: e.id,
            start: (startDate.add(startTime.hour(), 'h').add(startTime.minute(), 'm')).toDate(),
            end: (endDate.add(endTime.hour(), 'h').add(endTime.minute(), 'm')).toDate(),
            allDay: false,
            backgroundColor: '#00c0ef', //Info (aqua)
            borderColor: '#00c0ef' //Info (aqua)
          }
        });
        this.loadKanban();
        this.kanban.findBoard('board-cancelled').className += ' card card-danger';
        this.kanban.findBoard('board-pending').className += ' card card-warning';
        this.kanban.findBoard('board-done').className += ' card card-success';
      })
      .catch(error => {
        console.log(error);
        if (error.response.status == 500) {
          toastr.error("There was an error trying get the appointments.");
          console.log(error.response);
        }
      });
  },
  methods: {
    loadKanban() {
      let pendingItems = this.events.filter(e => {
        return e.status == 'pending'
      });
      let cancelledItems = this.events.filter(e => {
        return e.status == 'cancelled'
      });
      let doneItems = this.events.filter(e => {
        return e.status == 'done'
      });
      this.kanban = new jKanban({
        element: '#kanbanContainer',
        dropEl: this.changeStatus,
        dragBoards: false,
        boards: [{
            id: "board-pending",
            title: "Pending",
            class: 'pending-board,card-header',
            item: pendingItems.map(p => {
              return {
                id: "item-id-" + p.id.toString(),
                appointmentId: p.id,
                title: "Appointment " + p.id.toString()
              }
            })
          },
          {
            id: "board-cancelled",
            class: 'cancelled-board,card-header',
            title: "Cancelled",
            item: cancelledItems.map(p => {
              return {
                id: "item-id-" + p.id.toString(),
                appointmentId: p.id,
                title: "Appointment " + p.id.toString()
              }
            })
          },
          {
            id: "board-done",
            class: 'done-board,card-header',
            title: "Done",
            item: doneItems.map(p => {
              return {
                id: "item-id-" + p.id.toString(),
                appointmentId: p.id,
                title: "Appointment " + p.id.toString()
              }
            })
          }
        ]
      });
    },
    changeStatus(el, target, source, sibling) {
      axios
        .put('/api/appointments/' + el.dataset.appointmentid, {
          status: this.newStatus(target.previousSibling.className)
        })
        .then(response => {
          if (response.status == 200) {
            toastr.success("Change saved.");
          }
        })
        .catch(error => {
          toastr.error("Change couldn't be saved. Try again.");
          console.log(error.response);
        })
    },
    newStatus(className) {
      if (className.includes("done")) {
        return 'done';
      }
      if (className.includes("cancelled")) {
        return 'cancelled';
      }
      if (className.includes("pending")) {
        return 'pending';
      }
    }
  }
}
</script>

<style lang="scss">
@import 'jkanban/dist/jkanban';
</style>
