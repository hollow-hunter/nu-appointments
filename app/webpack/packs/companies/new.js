import NewCompany from '../../components/companies/new.vue';
import { createApp } from 'vue'

const app = createApp({})
app.component('NewCompany', NewCompany)
app.mount('#app')
