//import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
// import {useToast} from 'vue-toast-notification';
// import 'vue-toast-notification/dist/theme-sugar.css';
// import './index.css'

import {BootstrapVue3}  from 'bootstrap-vue-3'
// import { BootstrapVue3, BootstrapVueIcons } from 'bootstrap-vue-3'
import VueSweetalert2 from 'vue-sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';


// Since every component imports their Bootstrap functionality,
// the following line is not necessary:
// import 'bootstrap'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue-3/dist/bootstrap-vue-3.css'
import helper_mixin from './helper_mixin'

import VueSimpleContextMenu from 'vue-simple-context-menu';
import 'vue-simple-context-menu/dist/vue-simple-context-menu.css';

router.beforeEach((to, from, next) => {
    var apiToken = localStorage.getItem('token_name')
  
    if (to.matched.some(record => record.meta.auth) && !apiToken) {
      sessionStorage.setItem('redirectPath', to.path)
      next('/')
      // next({ name: 'account-signin', query: { next: to.fullPath } })
    } else {
      next()
    }
})

const app = createApp(App)
app.component('vue-simple-context-menu', VueSimpleContextMenu);

app.use(router)
app.use(BootstrapVue3)
// app.use(BootstrapVueIcons)
app.use(VueSweetalert2);
// var toastrConfigs = {
//   position: 'top right',
//   showDuration: 2000
// }

app.mixin(helper_mixin)

app.mount('#app')
