<template>
<div class="card card-primary">
  <div class="card-body p-0">
    <!-- THE CALENDAR -->
    <FullCalendar :key="appointmentsCount" :options="calendarOptions" />
  </div>
</div>
</template>
<script>
import FullCalendar from '@fullcalendar/vue'
import dayGridPlugin from '@fullcalendar/daygrid'
import interactionPlugin from '@fullcalendar/interaction'
import axios from 'axios'
import toastr from 'toastr'
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
      appointmentsCount: 0
    }
  },
  mounted() {
    axios
      .get('/api/appointments')
      .then(response => {
        this.appointmentsCount = response.data.length;
        this.calendarOptions.events = response.data.map(e => {
          let startDate = moment(e.date);
          let endDate = moment(e.date);
          let startTime = moment.utc(e.start_time);
          let endTime = moment.utc(e.end_time);
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
      })
      .catch(error => {
        if (error.response.status == 500) {
          toastr.error("There was an error trying get the appointments.");
        }
        console.log(error.response);
      });
  },
  methods: {
    addEvent(info) {
      window.location.href = '/appointments/new?datePreselected=' + info.dateStr;
    }
  }
}
</script>
