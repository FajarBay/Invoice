<script setup>
import axios from 'axios';
import { onMounted, ref } from 'vue';
import router from '../../router';
import { Bootstrap5Pagination } from 'laravel-vue-pagination';

    let form = ref([])
    let allcustomers = ref([])
    let customer_id = ref([])
    let item = ref([])
    let listCart = ref([])
    let searchProducts = ref([])

const showModal = ref(false)
const hideModal = ref(true)
let listproduct = ref({ 'data': [] })

onMounted(async () => {
    indexForm()
    getAllCustomers()
    getProduct()
})

const indexForm = async () => {
    let response = await axios.get('/api/create_invoice')
    // console.log('form', response.date)
    form.value = response.data
}

const getAllCustomers = async () => {
    let response = await axios.get('/api/customers')
    // console.log('response', response)
    allcustomers.value = response.data.customers
}

const addCart = (item) => {
    const itemcart = {
        id: item.id,
        item_code: item.item_code,
        description: item.description,
        unit_price: item.unit_price,
        quantity: item.quantity,
        satuan: item.satuan
    }
    listCart.value.push(itemcart)
    closeModel()
}

const removeItem = (i) => {
    listCart.value.splice(i, 1)
}

const openModel = () => {
    showModal.value = !showModal.value
}
const closeModel = () => {
    showModal.value = !hideModal.value
}

const getProduct = async (page = 1) => {
    let response = await axios.get(`/api/products?page=${page}`)
    // console.log('products', response)
    listproduct.value = response.data.products
}

const SubTotal = () => {
    let sub_total = 0
    listCart.value.map((data) => {
        sub_total = sub_total + (data.quantity * data.unit_price)
    })
    return sub_total
}

const Total = () => {
    let total = 0
    listCart.value.map((data) => {
        total = SubTotal() - form.value.discount
    })
    return total
}

const onSave = () => {
    if (listCart.value.length >= 1) {

        let subtotal = 0
        subtotal = SubTotal()

        let total = 0
        total = Total()

        const formData = new FormData()
        formData.append('invoice_item', JSON.stringify(listCart.value))
        formData.append('customer_id', customer_id.value)
        formData.append('date', form.value.date)
        formData.append('due_date', form.value.due_date)
        formData.append('number', form.value.number)
        formData.append('reference', form.value.reference)
        formData.append('discount', form.value.discount)
        formData.append('subtotal', subtotal)
        formData.append('total', total)
        formData.append('term_and_conditions', form.value.term_and_conditions)

        axios.post("/api/add_invoice", formData)
        listCart.value = []
        router.push('/')
    }
}

function formatMoney(value) {
        return new Intl.NumberFormat("id-ID", {
            style: "currency",
            currency: "IDR"
        }).format(value)
    }

    const search = async ( page = 1) => {
        let response = await axios.get(`/api/search_product?page=${page}&s=`+searchProducts.value)
        // console.log('response', response.data.invoices)
        listproduct.value = response.data.products
    }

</script>
<template>
    <div class="container">
        <!--==================== NEW INVOICE ====================-->
        <div class="invoices">

            <div class="card__header">
                <div>
                    <h2 class="invoice__title">Invoice baru</h2>
                </div>
                <div>

                </div>
            </div>

            <div class="card__content">
                <div class="card__content--header">
                    <div>
                        <p class="my-1">Customer</p>
                        <!-- <select name="" id="" class="input" v-model="customer_id">
                            <option :value="customer.id" v-for="customer in allcustomers" :key="customer.id">{{
                                customer.firstname }}</option>
                        </select> -->
                        <input type="text" class="input" v-model="customer_id">
                    </div>
                    <div>
                        <p class="my-1">Tanggal</p>
                        <input id="date" placeholder="dd-mm-yyyy" type="date" class="input" v-model="form.date"> <!---->
                        <p class="my-1">Due Date</p>
                        <input id="due_date" type="date" class="input" v-model="form.due_date">
                    </div>
                    <div>
                        <p class="my-1">Invoice</p>
                        <input type="text" class="input" v-model="form.number">
                        <p class="my-1">Reference(Optional)</p>
                        <input type="text" class="input" v-model="form.reference">
                    </div>
                </div>
                <br><br>
                <div class="table">

                    <div class="table--heading2">
                        <p>Nama Barang</p>
                        <p>Harga</p>
                        <p>Qty</p>
                        <p>Satuan</p>
                        <p>Jumlah</p>
                        <p></p>
                    </div>

                    <!-- item 1 -->
                    <div class="table--items2" v-for="(itemcart, i) in listCart" :key="itemcart.id">
                        <p>#{{ itemcart.item_code }} {{ itemcart.description }}</p>
                        <p>
                            <input type="number" class="input" v-model="itemcart.unit_price">
                        </p>
                        <p>
                            <input type="number" class="input" v-model="itemcart.quantity">
                        </p>
                        <p>
                            <input type="text" class="input" v-model="itemcart.satuan">
                        </p>
                        <p v-if="itemcart.quantity">
                            {{ formatMoney((itemcart.quantity) * (itemcart.unit_price)) }}
                        </p>
                        <p v-else></p>
                        <p style="color: red; font-size: 24px;cursor: pointer;" @click="removeItem(i)">
                            &times;
                        </p>
                    </div>
                    <div style="padding: 10px 30px !important;">
                        <button class="btn btn-sm btn__open--modal" @click="openModel()">Tambah Barang</button>
                    </div>
                </div>

                <div class="table__footer">
                    <div class="document-footer">
                        <p>Keterangan</p>
                        <textarea cols="50" rows="7" class="textarea" v-model="form.term_and_conditions"></textarea>
                    </div>
                    <div>
                        <div class="table__footer--subtotal">
                            <p>Sub Total</p>
                            <span>{{ formatMoney(SubTotal()) }}</span>
                        </div>
                        <div class="table__footer--discount">
                            <p>Diskon / DP</p>
                            <!-- <input type="number" class="input" v-model="form.discount"> -->
                            <CurrencyInput v-model="form.discount" :options="{ currency: 'IDR' }" class="input" />
                        </div>
                        <div class="table__footer--total">
                            <p>Total</p>
                            <span>{{ formatMoney(Total()) }}</span>
                        </div>
                    </div>
                </div>


            </div>
            <div class="card__header" style="margin-top: 40px;">
                <div>

                </div>
                <div>
                    <router-link to="/" style="text-decoration: none; color: black;">
                        <a class="btn btn-secondary">Kembali</a>
                    </router-link>
                    <a class="btn btn-secondary" style="margin-left: 10px;" @click="onSave()">
                        Save
                    </a>
                </div>
            </div>

        </div>
        
    </div>
        <div class="modal main__modal " :class="{ show: showModal }">
            <div class="modal__content">
                <span class="modal__close btn__close--modal" @click="closeModel()">×</span>
                <h3 class="modal__title">Tambah Item</h3>
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
                <hr><br>
                <div class="modal__items">
                    <ul style="list-style: none;">
                        <li v-for="(item, i) in listproduct.data" :key="item.id"
                            style="display:grid; grid-template-columns:30px 350px 15px; align-items: center; padding-bottom: 5px;">
                            <p>{{ i + 1 }}</p>
                            <a href="#">{{ item.item_code }} - {{ item.description }}</a>
                            <button @click="addCart(item)"
                                style="border: 1px solid #e0e0e0; width: 35px; height: 35px; cursor: pointer;">
                                +
                            </button>
                        </li>
                    </ul>
                </div>
            <ul class="pagination">
            <Bootstrap5Pagination :data="listproduct" @pagination-change-page="search"/>
            </ul>
            <br>
            <br><hr>
            <div class="model__footer">
                <button class="btn btn-light mr-2 btn__close--modal" @click="closeModel()">
                    Cancel
                </button>
                <button class="btn btn-light btn__close--modal ">Save</button>
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
</script>