<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Recent extends Model
{
    use HasFactory;
    

    protected $fillable=[
        'from_id',
        'to_id',
        'amount_from',
        'amount_to',
        'currency_from',
        'currency_to'
    ];  
}
