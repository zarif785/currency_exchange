<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Recent;
use Illuminate\Support\Facades\DB;

class RecentController extends Controller
{
    public function store(Request $request){
        

        $fields = $request->validate(
            [

                'amount_from'=>'required',
                'currency_from'=>'required',
                'currency_to'=>'required',
            ]
        );
        
        $data = Recent::create(
            [
                'from_id'=> $request->from_id,
                'to_id'=> $request->to_id,
                'amount_from'=> $fields['amount_from'],
                'amount_to'=> $request->amount_to,
                'currency_from'=> $request->currency_from,
                'currency_to'=> $request->currency_to,

            ]
            );
            
            return[
                'message'=> "OK",
                'data'=> $data,
                'status'=>true
              ];

    }

    public function recent_conv(){

        $data= Recent::orderBy('id', 'desc')->take(10)->get();

        if(!empty($data)){
            return[
                'message'=> "OK",
                'data'=> $data,
                'status'=>true
              ];
        }
        else{
            return[
                'message'=> "NOT OK",
                'data'=> [],
                'status'=>false
              ];
        }
        

    }

    public function popular(){

        $data = DB::table('recents')
        ->select(['recents.currency_from','recents.currency_to',(DB::raw('COUNT(recents.from_id)'))])
        ->groupBy('recents.currency_from','recents.currency_to')
        ->orderBy((DB::raw('COUNT(recents.from_id)')),'desc')
        ->take(10)
        ->get();
        
         return[
            'message'=> "OK",
            'data'=> $data,
            'status'=>true
          ];
    }
}
