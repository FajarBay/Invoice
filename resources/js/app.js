import './bootstrap';

import { createApp  } from 'vue';

import app from './components/app.vue';

import router from './router/index.js'

// createApp(app).use(router).mount("#app")

const App = createApp(app).use(router);

// App.config.globalProperties.filters = {
//     formatCurrency(value) {
//         value = (value/100)
//         return value.toLocaleString('id-ID', {
//             style: 'currency',
//             currency: 'IDR'
//         })
//     }
// }

App.mount("#app")