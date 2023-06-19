<script setup>
import axios from 'axios';
import { onMounted, ref } from 'vue';
import { useRouter } from "vue-router";
import { Bootstrap5Pagination } from 'laravel-vue-pagination';

const router = useRouter()

    let invoices = ref({'data' : []})
    let searchInvoice = ref([])
    // let products = ref([])

    onMounted(async () => {
        getInvoices()
        search()
    })

    const getInvoices = async (page = 1) => {
        let response = await axios.get(`/api/get_all_invoice?page=${page}`)
        // console.log('response', response)
        invoices.value = response.data.invoices
    }

    const Product = async () => {
        let product = await axios.get("/api/get_all_product")
        // console.log('response', response)
        router.push('/product')
        // products.value = response.data.products
    }

    const search = async ( page = 1) => {
        let response = await axios.get(`/api/search_invoice?page=${page}&s=`+searchInvoice.value)
        // console.log('response', response.data.invoices)
        invoices.value = response.data.invoices
    }

    const newInvoice = async () => {
        let form = await axios.get("/api/create_invoice")
        console.log('form', form.data)
        router.push('/invoice/new')
    }
    
    function formatMoney(value) {
        return new Intl.NumberFormat("id-ID", {
            style: "currency",
            currency: "IDR"
        }).format(value)
    }

</script>
<template>
    <div class="container">
        <!--==================== INVOICE LIST ====================-->
    <div class="invoices">
        
        <div class="card__header">
            <div>
                <h2 class="invoice__title">Invoices</h2>
            </div>
            <div>
                <a class="btn btn-secondary" @click="newInvoice()">
                    Invoice Baru
                </a>
            </div>
        </div>

        <div class="table card__content">
            <div class="table--filter">
                <span class="table--filter--collapseBtn ">
                    <i class="fas fa-ellipsis-h"></i>
                </span>
                <div class="table--filter--listWrapper">
                    <ul class="table--filter--list">
                        <li>
                            <p class="table--filter--link table--filter--link--active">
                                <a class="btn btn-secondary">All</a>
                            </p>
                        </li>
                        <li>
                            <p class="table--filter--link ">
                                <a class="btn btn-secondary">Paid</a>
                            </p>
                        </li>
                        <li>
                            <p class="table--filter--link ">
                                <a class="btn btn-secondary" @click="Product()">
                                    Produk
                                </a>
                            </p>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="table--search">
                <div class="table--search--wrapper">
                    <select class="table--search--select" name="" id="">
                        <option value="">Filter</option>
                    </select>
                </div>
                <div class="relative">
                    <i class="table--search--input--icon fas fa-search "></i>
                    <input class="table--search--input" type="text" placeholder="Search invoice"
                    v-model="searchInvoice" @keyup="search()">
                </div>
            </div>

            <div class="table--heading">
                <p>ID</p>
                <p>Tanggal</p>
                <p>Invoice</p>
                <p>Customer</p>
                <p>Due Date</p>
                <p>Total</p>
            </div>

            <!-- item 1 -->
            <div class="table--items" v-for="item in invoices.data" :key="item.id" v-if="invoices.data.length > 0">
                <a href="#" class="table--items--transactionId">#{{item.id}}</a>
                <p>{{item.date}}</p>
                <p>{{item.number}}</p>
                <p v-if="item.customer">{{item.customer.firstname}}</p>
                <p v-else
                ></p>
                <p>{{item.due_date}}</p>
                <p>{{formatMoney(item.total)}}</p>
            </div>
            <div class="table--items" v-else>
                <p>Invoice not found</p>
            </div>
            <br>
            <ul class="pagination">
            <Bootstrap5Pagination :data="invoices" @pagination-change-page="search"/>
        </ul>
        </div>
        
    </div>

    <br><br><br>
    
    </div>
</template>