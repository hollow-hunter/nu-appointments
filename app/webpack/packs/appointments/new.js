import NewAppointment from '../../components/appointments/new.vue';
import { createApp } from 'vue'

const app = createApp({})
app.component('NewAppointment', NewAppointment)
app.mount('#app')
