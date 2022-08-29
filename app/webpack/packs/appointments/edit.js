import EditAppointment from '../../components/appointments/edit.vue'
import { createApp } from 'vue'

const app = createApp({})
app.component('EditAppointment', EditAppointment)
app.mount('#app')
