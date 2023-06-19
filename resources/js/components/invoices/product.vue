<script setup>
import axios from 'axios';
import { onMounted, ref } from 'vue';
import { useRouter } from "vue-router";
import { Bootstrap5Pagination } from 'laravel-vue-pagination';


const router = useRouter()

    let products = ref({'data' : []})
    let searchProducts = ref([])
    let form = ref([])

    const showModal = ref(false)
    const hideModal = ref(true)

    onMounted(async () => {
        getProduct()
        newProduct()
        search()
    })

    const getProduct = async (page = 1) => {
            let response = await axios.get(`/api/get_all_product?page=${page}`)
            products.value = response.data.products
            // console.log('response', products)
        }

    const openModel = () => {
    showModal.value = !showModal.value
    }

    const closeModel = () => {
        showModal.value = !hideModal.value
    }

    const search = async (page = 1) => {
        let response = await axios.get(`/api/search_product?page=${page}&s=`+searchProducts.value)
        // console.log('response', response.data.invoices)
        products.value = response.data.products
    }

    const newProduct = async () => {
        let response = await axios.get("/api/create_product")
        // console.log('form', response.data)
        // router.push('/product')
        form.value = response.data
    }

    const onSave = () => {

        const formData = new FormData()
        formData.append('item_code', form.value.item_code)
        formData.append('description', form.value.description)
        formData.append('unit_price', form.value.unit_price)

        axios.post("/api/add_product", formData)
        // router.push('/product')
        getProduct()
        closeModel()
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
                <h2 class="invoice__title">Product</h2>
            </div>
            <!-- <div>
                <a class="btn btn-secondary" @click="newInvoice()">
                    New Invoice
                </a>
            </div> -->
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
                                <router-link to="/" style="text-decoration: none; color: black;">
                                    <a class="btn btn-secondary">Kembali</a>
                                </router-link>
                                    
                            </p>
                        </li>
                        <li>
                            <p class="table--filter--link ">
                                <a class="btn tambah" @click="openModel() | newProduct()">
                                   + Tambah Produk
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
                    <input class="table--search--input" type="text" placeholder="Search product"
                    v-model="searchProducts" @keyup="search()">
                </div>
            </div>

            <div class="table--heading">
                <p>No</p>
                <p>Kode Produk</p>
                <p>Nama</p>
                <p>Harga</p>
                <p>Opsi</p>
            </div>

            <!-- item 1 -->
            <div class="table--items" v-for="item, index in products.data" :key="item.id" v-if="products.data.length > 0">
                <a href="#" class="table--items--transactionId">#{{index + 1}}</a>
                <p>{{item.item_code}}</p>
                <p>{{item.description}}</p>
                <p>{{formatMoney(item.unit_price) }}</p>
                <p>
                    <a class="btn btn-warning" style="margin-right: 5px;">
                        <img :src="'/assets/edit.png'" class="icon">
                    </a>
                    <a class="btn btn-danger">
                        <img :src="'/assets/delete.png'" class="icon">
                    </a>
                </p>
            </div>
            <div class="table--items" v-else>
                <p>Product not found</p>
            </div>
            <br>
                <ul style="list-style: none;">
                <Bootstrap5Pagination :data="products" @pagination-change-page="search"/>
                </ul>
        </div>
        
    </div>


    <div class="modal main__modal " :class="{ show: showModal }">
        <div class="modal__content">
            <span class="modal__close btn__close--modal" @click="closeModel()">×</span>
            <h3 class="modal__title">Produk Baru</h3>
            <hr><br>
            <div class="modal__items">
                <div class="card__content--header">
                <div>
                    <p class="my-1">Kode Barang</p>
                    <input id="kode barang" placeholder="Kode Barang" type="text" class="input" v-model="form.item_code">
                </div>
                <div>
                    <p class="my-1">Nama Barang</p> 
                    <input id="nama barang" placeholder="Nama Barang" type="text" class="input" v-model="form.description">
                </div>
                <div>
                    <p class="my-1">Harga</p> 
                    <!-- <input type="number" class="input" v-model="form.unit_price"> -->
                    <CurrencyInput v-model="form.unit_price" :options="{ currency: 'IDR' }" class="input"/>
                </div>
            </div>
            </div>
            <br><hr>
            <div class="model__footer">
                <button class="btn btn-light mr-2 btn__close--modal" @click="closeModel()">
                    Cancel
                </button>
                <button type="button" class="btn btn-light btn__close--modal" @click="onSave()">Save</button>
            </div>
        </div>
    </div>

    
    </div>
</template>
<script>
import CurrencyInput from "./CurrencyInput.vue";

export default {
  name: "product",
  components: {
    CurrencyInput,
  },
  data() {
    return {
      value: 1234,
    };
  },
};

// let num = products.unit_price;
// let text = num.toLocaleString("id-ID", {style:"currency", currency:"IDR"});

// document.getElementById("demo").innerHTML = text;
</script>