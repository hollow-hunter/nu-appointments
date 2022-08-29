import StatusAppointments from '../../components/appointments/status.vue';
import { createApp } from 'vue'

const app = createApp({})
app.component('StatusAppointments', StatusAppointments)
app.mount('#app')
