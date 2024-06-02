import { createApp } from 'vue'
import App from './App.vue'
import Routes from './Routes'

const app = createApp(App)
app.use(Routes)
app.mount('#app')
