<?php

namespace App\Http\Controllers;

use App\Models\Currencies;
use App\Models\Recent;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;


class CurrencyController extends Controller
{
    public function insert()
    {
        $response = Http::get('https://api.getgeoapi.com/v2/currency/list?api_key=41a5c00289e5130d182d9441bdd51866b67e3af8&format=json')['currencies'];

    
        $response_body = $response;
        

        $array = (array) $response_body;


        $currency = [];

        foreach ($array as $key => $value) {
            array_push($currency, ['code' => $key, 'name' =>$value]);

            $is_exist = Currencies::where('currency_short',$key)->first();

            if(!$is_exist){
                $data = Currencies::create([
                    'currency_short'=>$key,
                     'currency_long'=>$value,
                ]);
            }


        }
        if(!empty($currency)){
            return $currency;
        }




    }

    // public function index(Request $request){
    //     $data = Currencies::orderBy('currency_short', 'asc')->get();

    //     if(!empty($data)){
    //         return[
    //             'message'=> "OK",
    //             'data'=> $data,
    //             'status'=>true
    //           ];
    //     }
    //     else{
    //         return[
    //             'message'=> "Could not generate currency List. Try Again Later",
    //             'data'=> [],
    //             'status'=>false
    //           ];
    //     }
    // }


    public function index(Request $request){
        $data = Currencies::orderBy('currency_short', 'asc')->get();

        if($data->isEmpty()){

         $data = $this->insert();
         return[
            'message'=> "OK",
            'data'=> $data,
            'status'=>true
          ];

        }
        else{
            return[
                'message'=> "OK",
                'data'=> $data,
                'status'=>true
              ];
        }
    }


    public function search($currency_long){
        
        $data = Currencies::where('currency_long','like','%'.$currency_long.'%')->get();
        return[
            'message'=> "OK",
            'data'=> $data,
            'status'=>true
          ];
    
    }

    public function tableJoin(){

        $data = DB::table('currencies')
        ->select(['currencies.id', 'currencies.currency_short','currencies.currency_long','recents.id as recent_id','recents.amount_from','recents.amount_to',])
        ->join('recents','currencies.id','=','recents.from_id')
        // ->join('recents','currencies.id','=','recents.to_id')
        ->orderBy('recents.created_at','desc')
        ->take(10)
        ->get();
        
         return[
            'message'=> "OK",
            'data'=> $data,
            'status'=>true
          ];
    }

    public function toJoin(){

        $data = DB::table('currencies')
        ->select(['currencies.currency_short','currencies.currency_long','recents.amount_from','recents.amount_to','recents.currency_from'])
        ->join('recents','currencies.id','=','recents.to_id')
        ->orderBy('recents.created_at','desc')
        ->take(10)
        ->get();
        
         return[
            'message'=> "OK",
            'data'=> $data,
            'status'=>true
          ];
    }

}
