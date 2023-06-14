<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

use App\Http\Controllers\InvoiceController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\ProductController;

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/get_all_invoice', [InvoiceController::class, 'get_all_invoice']);
Route::get('/get_all_product', [ProductController::class, 'get_all_product']);
Route::get('/search_invoice', [InvoiceController::class, 'search_invoice']);
Route::get('/search_product', [ProductController::class, 'search_product']);
Route::get('/create_invoice', [InvoiceController::class, 'create_invoice']);
Route::get('/create_product', [ProductController::class, 'create_product']);
Route::get('/customers', [CustomerController::class, 'all_customer']);
Route::get('/products', [ProductController::class, 'all_product']);
Route::post('/add_invoice', [InvoiceController::class, 'add_invoice']);
Route::post('/add_product', [ProductController::class, 'add_product']);
