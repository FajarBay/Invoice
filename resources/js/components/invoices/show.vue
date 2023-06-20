<script setup>
    import axios from 'axios';
import { onMounted, ref } from 'vue';
import router from '../../router';

    let form = ref({ id: '' })

    const props = defineProps({
        id: {
            type:String,
            default:''
        }
    })

    onMounted(async () => {
        getInvoices()
    })

    const getInvoices = async () => {
        let response = await axios.get(`/api/show_invoice/${props.id}`)
        console.log('form', response.data.invoice)
        form.value = response.data.invoice
    }
    
    function formatMoney(value) {
        return new Intl.NumberFormat("id-ID", {
            style: "currency",
            currency: "IDR"
        }).format(value)
    }

    const print = () => {
        window.print()
        router.push('/').catch(() => {})
    }

    const onEdit = (id) => {
        router.push('/invoice/edit/'+id)
    }


</script>
<template>
    <div class="container">
        <!--==================== SHOW INVOICE ====================-->
    <div class="invoices">
        
        <div class="card__header">
            <div>
                <h2 class="invoice__title">Invoice</h2>
            </div>
            <div>
                
            </div>
        </div>
        <div>
            <div class="card__header--title ">
                <h1 class="mr-2">#{{form.id}}</h1>
                <p>{{form.created_at}}</p>
            </div>
    
            <div>
                <ul  class="card__header-list">
                    <li>
                        <!-- Select Btn Option -->
                        <button class="selectBtnFlat" @click="print()">
                            <i class="fas fa-print"></i>
                            Print
                        </button>
                        <!-- End Select Btn Option -->
                    </li>
                    <li>
                        <!-- Select Btn Option -->
                        <button class="selectBtnFlat" @click="onEdit(form.id)">
                            <i class=" fas fa-reply"></i>
                            Edit
                        </button>
                        <!-- End Select Btn Option -->
                    </li>
                    <li>
                        <!-- Select Btn Option -->
                        <button class="selectBtnFlat ">
                            <i class=" fas fa-pencil-alt"></i>
                            Delete
                        </button>
                        <!-- End Select Btn Option -->
                    </li>
                    <li>
                        <!-- Select Btn Option -->
                        <router-link to="/">
                            <button class="selectBtnFlat ">
                                <i class=" fas fa-pencil-alt"></i>
                                Kembali
                            </button>
                        </router-link>
                        <!-- End Select Btn Option -->
                    </li>
                    
                </ul>
            </div>
        </div>

        <div class="table invoice">
            <div class="logo">
                <img :src="'/assets/krisna.png'" class="logo">
                <div class="alamat">
                    <img :src="'/assets/whatsapp.png'" class="icon"> 0857-1090-7599<br><br>
                    <img :src="'/assets/maps.png'" class="icon"> Jl. Rupakpicis, Babakan, Kec. Kalimanah, Kab. Purbalingga, Jawa Tengah, 53371
                </div>
            </div>
            <div class="invoice__header--title">
                <p class="invoice__header--title-2">Al-Fazza Florist</p>
                <p class="invoice__header--title-1">Invoice</p>
                <p></p>
            </div>

            
            <div class="invoice__header--item">
                <div>
                    <h2>Invoice Kepada:</h2>
                    <p class="penerima">{{form.customer_id}}</p>
                </div>
                <div>
                        <div class="invoice__header--item1">
                            <p>Nomor</p>
                            <span>#{{form.number}}</span>
                        </div>
                        <div class="invoice__header--item2">
                            <p>Tanggal</p>
                            <span>{{form.date}}</span>
                        </div>
                        <!-- <div class="invoice__header--item2">
                            <p>Due Date</p>
                            <span>{{form.due_date}}</span>
                        </div> -->
                        <div class="invoice__header--item2">
                            <p>Reference</p>
                            <span>{{form.reference}}</span>
                        </div>
                    
                </div>
            </div>

            <div class="table py1">

                <div class="table--heading3">
                    <p>#</p>
                    <p>Nama Barang</p>
                    <p>Harga</p>
                    <p style="padding-left: 30px;">Qty</p>
                    <p>Satuan</p>
                    <p>Jumlah</p>
                </div>
    
                <!-- item 1 -->
                <div class="table--items3" v-for="(item, i) in form.invoice_items" :key="item.id">
                    <p>{{i+1}}</p>
                    <p>{{item.product.description}}</p>
                    <p>{{formatMoney(item.product.unit_price)}}</p>
                    <p style="padding-left: 40px;">{{item.quantity}}</p>
                    <p>{{item.satuan}}</p>
                    <p>{{formatMoney(item.product.unit_price * item.quantity)}}</p>
                </div>
            </div>

            <div  class="invoice__subtotal">
                <!-- <div class="materai">
                    <p>Materai</p>
                </div> -->
                <div>
                    <h4>Terima Kasih Atas Kerjasamanya</h4>
                    <p style="margin-top: 40px;">Hormat Kami,</p>
                    <p>Al-Fazza Florist</p>
                    <p class="materai">Materai</p>
                    <p>Krisna Bayu Pamungkas</p>
                </div>
                <div>
                    <div class="invoice__subtotal--item1">
                        <p>Sub Total</p>
                        <span>{{ formatMoney(form.sub_total) }}</span>
                    </div>
                    <div class="invoice__subtotal--item2">
                        <p>Diskon / DP</p>
                        <span>{{formatMoney(form.discount)}}</span>
                    </div>
                    
                </div>
            </div>

            <div class="invoice__total">
                <div>
                    <h3>Keterangan</h3><br>
                    <p>{{form.term_and_conditions}}</p>
                </div>
                <div>
                    <div class="grand__total" >
                        <div class="grand__total--items">
                            <p>Total</p>
                            <span>{{ formatMoney(form.total) }}</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <br><br>
        
    </div>

    </div>
</template>