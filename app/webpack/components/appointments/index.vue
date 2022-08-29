<template>
<div class="card card-primary">
  <div class="card-body p-0">
    <div class="row">
      <div class="col-sm-6 col-md-6">
        <label>Staff</label>
        <select v-if="staffs" v-model="idStaff" id="staffSelector" class="form-control select2">
          <option value="">All</option>
          <option v-for="staff in staffs" :key="staff.id" :value="staff.id">{{staff.name}}</option>
        </select>
      </div>
      <div class="col-sm-6 col-md-6">
        <label>Status</label>
        <select v-model="statusSelected" id="statusSelector" class="form-control select2">
          <option value="">All</option>
          <option value="pending">Pending</option>
          <option value="done">Done</option>
          <option value="cancelled">Cancelled</option>
        </select>
      </div>
    </div>
    <!-- THE CALENDAR -->
    <FullCalendar :key="appointmentsCount" :options="calendarOptions" />
  </div>
</div>
</template>
<script>
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import interactionPlugin from '@fullcalendar/interaction'
import axios from 'axios'
import toastr from 'toastr'
import '../../stylesheets/appointments';
require('select2')
export default {
  components: {
    FullCalendar // make the <FullCalendar> tag available
  },
  data: function() {
    return {
      calendarOptions: {
        plugins: [dayGridPlugin, interactionPlugin],
        initialView: 'dayGridMonth',
        events: null,
        dateClick: this.addEvent
      },
      appointmentsCount: 0,
      appointments: null,
      idStaff: '',
      staffs: null,
      statusSelected: ''
    }
  },
  mounted() {
    axios
      .get('/api/appointments')
      .then(response => {
        this.appointments = response.data;
        this.appointmentsCount = this.appointments.length;
        this.loadEvents(this.appointments);
      })
      .catch(error => {
        if (error.response.status == 500) {
          toastr.error("There was an error trying get the appointments.");
        }
        console.log(error.response);
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
    if (vueInstance.statusSelected == '') {
      $('#statusSelector').select2();
      $('#statusSelector').on('select2:select', function(e) {
        var data = e.params.data;
        vueInstance.statusSelected = data.id;
      });
    }
  },
  computed:{
    filteredAppointments(){
      let result = this.appointments;
      result = result.filter(a => this.idStaff == '' || a.staffId == this.idStaff);
      result = result.filter(a => this.statusSelected == '' || a.status == this.statusSelected);
      return result;
    }
  },
  watch:{
    idStaff(newId, previousId) {
      this.loadEvents(this.filteredAppointments);
    },
    statusSelected(newStatus, previousStatus) {
      this.loadEvents(this.filteredAppointments);
    }
  },
  methods: {
    loadEvents(appointments) {
      this.calendarOptions.events = appointments.map(e => {
          let startDate = moment(e.date);
          let endDate = moment(e.date);
          let startTime = moment.utc(e.startTime);
          let endTime = moment.utc(e.endTime);
          return {
            id: e.id,
            url: '/appointments/' + e.id + '/edit',
            title: e.id,
            start: (startDate.add(startTime.hour(), 'h').add(startTime.minute(), 'm')).toDate(),
            end: (endDate.add(endTime.hour(), 'h').add(endTime.minute(), 'm')).toDate(),
            allDay: false,
            backgroundColor: '#00c0ef', //Info (aqua)
            borderColor: '#00c0ef' //Info (aqua)
          }
        });
    },
    addEvent(info) {
      window.location.href = '/appointments/new?datePreselected=' + info.dateStr;
    }
  }
}
</script>
