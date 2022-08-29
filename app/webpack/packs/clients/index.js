import { createApp } from 'vue'
import Index from '../../components/clients/index.vue'

const app = createApp({})
app.component('Index', Index)
app.mount('#app')
