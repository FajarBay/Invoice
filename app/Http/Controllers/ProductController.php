<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    public function all_product() {
        $product = Product::orderBy('id', 'DESC')->get();
        return response()->json([
            'products' => $product
        ], 200);
    }
}
