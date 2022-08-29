import EditClient from '../../components/clients/edit.vue'
import { createApp } from 'vue'

const app = createApp({})
app.component('EditClient', EditClient)
app.mount('#app')
