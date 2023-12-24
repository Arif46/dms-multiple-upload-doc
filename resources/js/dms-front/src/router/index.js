import { createRouter, createWebHashHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  // history: createWebHistory(import.meta.env.BASE_URL),
  history: createWebHashHistory(),
  routes: [
    {
      path: '/',
      // name: 'home',
      meta: { auth: false, name: 'Editable' },
      component: () => import('../views/Login.vue')
    },{
      path: '/folders/:parent_id?',
      name: 'folders',
      meta: { auth: true, name: 'Editable' },
      component: HomeView
    },
    {
      path: '/about',
      name: 'about',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../views/AboutView.vue')
    },
    {
      path: '/contact-us',
      name: 'about_us',
      component: () => import('../views/ContactUsView.vue')
    },
    {
      path: '/user-list',
      name: 'user_list',
      component: () => import('../views/UserListView.vue')
    }
    // {
    //   path: '/login',
    //   name: 'login',
    //   meta: { auth: false, name: 'Editable' },
    //   component: () => import('../views/Login.vue')
    // }
  ]
})

export default router
