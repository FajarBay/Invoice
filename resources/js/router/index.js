import { createRouter, createWebHistory } from "vue-router";

import invoiceIndex from '../components/invoices/index.vue'
import invoiceNew from '../components/invoices/new.vue'
import product from '../components/invoices/product.vue'

import notFound from '../components/invoices/NotFound.vue'

const routes = [
    {
        path:'/',
        component: invoiceIndex
    },
    {
        path:'/invoice/new',
        component: invoiceNew
    },
    {
        path:'/product',
        component: product
    },
    {
        path:'/:pathMatch(.*)*',
        component: notFound
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router;