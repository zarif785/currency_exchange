<?php

use App\Http\Controllers\CurrencyController;
use App\Http\Controllers\RecentController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('/currency',[CurrencyController::class, 'insert']);
Route::get('/currency/get',[CurrencyController::class, 'index']);
Route::get('/currency/from',[CurrencyController::class, 'tableJoin']);
Route::get('/currency/to',[CurrencyController::class, 'toJoin']);
Route::post('/recent',[RecentController::class, 'store']);
Route::get('/recent',[RecentController::class, 'recent_conv']);
Route::get('/popular',[RecentController::class, 'popular']);


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});