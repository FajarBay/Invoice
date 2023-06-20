<script setup>
    import axios from 'axios';
import { onMounted, ref } from 'vue';

    let form = ref({
        id: ''
    })
    let allcustomers = ref([])

const showModal = ref(false)
const hideModal = ref(true)
let listproduct = ref({ 'data': [] })

    onMounted(async () => {
        getInvoice()
        getAllCustomers()
        getProduct()
    })

    const props = defineProps({
        id:{
            type:String,
            default: ''
        }
    })

    const getInvoice = async () => {
        let response = await axios.get(`/api/edit_invoice/${props.id}`)
        console.log('form', response.data.invoice)
        form.value = response.data.invoice
    }

    const getAllCustomers = async () => {
        let response = await axios.get('/api/customers')
        // console.log('response', response)
        allcustomers.value = response.data.customers
    }

    function formatMoney(value) {
        return new Intl.NumberFormat("id-ID", {
            style: "currency",
            currency: "IDR"
        }).format(value)
    }

    const deleteinvoiceItem = (id, i) => {
        // console.log(form.value.invoice_items)
        form.value.invoice_items.splice(i,1)
        if(confirm('Apakah anda ingin menghapus data?')){
            if ( id != undefined ) {
                axios.get('/api/delete_invoice_items/'+id)
            }
        }else {
                getInvoice()
            }
    }

    const addCart = (item) => {
    const itemcart = {
        product_id: item.id,
        item_code: item.item_code,
        description: item.description,
        unit_price: item.unit_price,
        quantity: item.quantity,
        satuan: item.satuan
    }
    form.value.invoice_items.push(itemcart)
    closeModel()
}

    const removeItem = (i) => {
        form.value.invoice_items.splice(i, 1)
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
        if (form.value.invoice_items){

            form.value.invoice_items.map((data) => {
                sub_total = sub_total + (data.quantity * data.unit_price)
            })
        }
        return sub_total
    }

    const Total = () => {
        let total = 0
        if (form.value.invoice_items) {
            form.value.invoice_items.map((data) => {
                total = SubTotal() - form.value.discount
            })
        }
        return total
    }

</script>
<template>
    <div class="container">
        <!--==================== EDIT INVOICE ====================-->
    <div class="invoices">
        
        <div class="card__header">
            <div>
                <h2 class="invoice__title">Edit Invoice</h2>
            </div>
            <div>
                
            </div>
        </div>

        <div class="card__content">
            <div class="card__content--header">
                <div>
                    <p class="my-1">Customer</p>
                    <input type="text" class="input" v-model="form.customer_id">
                </div>
                <div>
                    <p class="my-1">Date</p> 
                    <input id="date" placeholder="dd-mm-yyyy" type="date" class="input" v-model="form.date"> <!---->
                    <p class="my-1">Due Date</p> 
                    <input id="due_date" type="date" class="input" v-model="form.due_date">
                </div>
                <div>
                    <p class="my-1">Numero</p> 
                    <input type="text" class="input" v-model="form.number" disabled> 
                    <p class="my-1">Reference(Optional)</p> 
                    <input type="text" class="input" v-model="form.reference">
                </div>
            </div>
            <br><br>
            <div class="table">

                <div class="table--heading2">
                    <p>Item Description</p>
                    <p>Unit Price</p>
                    <p>Qty</p>
                    <p>Satuan</p>
                    <p>Total</p>
                    <p></p>
                </div>
    
                <!-- item 1 -->
                <div class="table--items2" v-for="(itemcart, i) in form.invoice_items" :key="itemcart.id">
                    <p v-if="itemcart.product">
                        {{ i+1 }}. {{ itemcart.product.item_code }} - {{ itemcart.product.description }}
                    </p>
                    <p v-else>
                        {{ i+1 }}. {{ itemcart.item_code }} - {{ itemcart.description }}
                    </p>
                    <p>
                        <input type="text" class="input" v-model="itemcart.unit_price">
                    </p>
                    <p>
                        <input type="text" class="input" v-model="itemcart.quantity">
                    </p>
                    <p>
                        <input type="text" class="input" v-model="itemcart.satuan">
                    </p>
                    <p>
                        {{ formatMoney(itemcart.quantity * itemcart.unit_price)}}
                    </p>
                    <span v-if="itemcart.id">
                        <p style="color: red; font-size: 24px;cursor: pointer;" @click="deleteinvoiceItem(itemcart.id, i)">
                            &times;
                        </p>
                    </span>
                    <span v-else>
                        <p style="color: red; font-size: 24px;cursor: pointer;" @click="removeItem(i)">
                            &times;
                        </p>
                    </span>
                </div>
                <div style="padding: 10px 30px !important;">
                    <button class="btn btn-sm btn__open--modal" @click="openModel()">Add New Line</button>
                </div>
            </div>

            <div class="table__footer">
                <div class="document-footer" >
                    <p>Keterangan</p>
                    <textarea cols="50" rows="7" class="textarea" v-model="form.term_and_conditions"></textarea>
                </div>
                <div>
                    <div class="table__footer--subtotal">
                        <p>Sub Total</p>
                        <span>{{formatMoney(SubTotal())}}</span>
                    </div>
                    <div class="table__footer--discount">
                        <p>Diskon / DP</p>
                        <input type="text" class="input" v-model="form.discount">
                    </div>
                    <div class="table__footer--total">
                        <p>Grand Total</p>
                        <span>{{ formatMoney(Total()) }}</span>
                    </div>
                </div>
            </div>

           
        </div>
        <div class="card__header" style="margin-top: 40px;">
            <div>
                
            </div>
            <div>
                <a class="btn btn-secondary">
                    Save
                </a>
            </div>
        </div>
        
    </div>
    </div>
    <!--==================== add modal items ====================-->
    <div class="modal main__modal " :class="{ show: showModal }">
        <div class="modal__content">
            <span class="modal__close btn__close--modal" @click="closeModel()">×</span>
            <h3 class="modal__title">Add Item</h3>
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