<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Redirect;

use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    public function all_product() {
        $product = Product::orderBy('id', 'DESC')->paginate(5);
        return response()->json([
            'products' => $product
        ], 200);
    }

    public function get_all_product() {
        $product = Product::orderBy('id', 'desc')->paginate(5);
        return response()->json([
            'products' => $product
        ], 200);
    }

    // public function search_product(Request $request) {
    //     $search = $request->get('s');
    //     if($search != null) {
    //         $products = Product::where('description', 'LIKE', "%".$search."%")->paginate(5);
    //         return response()->json([
    //             'products' => $products
    //         ],200);
    //     }else {
    //         return $this->get_all_product();
    //     }
    // }

    public function search_product(Request $request) {
        $search = $request->s;
        if($search != null) {
            $products = Product::where(function($q) use ($search) {
                $q->where('description', 'LIKE', "%".$search."%");
            })->orderBy('id', 'DESC')->paginate(5);
            return response()->json([
                'products' => $products
            ],200);
        }else {
            return $this->all_product();
        }
    }

    public function create_product(Request $request) {

        $product = Product::orderBy('id', 'DESC')->first();
        if($product){
            $product = $product->id+1;
        }

        $formData = [
            'item_code' => "IC-",
            'description' => null,
            'unit_price' => null,
        ];
        return response()->json($formData);
    }

    public function add_product(Request $request){

        $productdata['item_code'] = $request->input("item_code");
        $productdata['description'] = $request->input("description");
        $productdata['unit_price'] = $request->input("unit_price");

        $product = Product::create($productdata);

        return Redirect::back()->with('message','Operation Successful !');
    }
}
