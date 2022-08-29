import NewClient from '../../components/clients/new.vue'
import { createApp } from 'vue'

const app = createApp({})
app.component('NewClient', NewClient)
app.mount('#app')
