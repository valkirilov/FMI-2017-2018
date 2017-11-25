<?php

use Illuminate\Http\Request;

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

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['prefix' => 'categories/'], function () {
    Route::get('/', 'CategoryController@index');
    Route::get('/{category}', 'CategoryController@show');
    Route::post('/', 'CategoryController@store');
    Route::put('/{category}', 'CategoryController@update');
    Route::delete('/{category}', 'CategoryController@destroy');
});

Route::group(['prefix' => 'tags/'], function () {
    Route::get('/', 'TagController@index');
    Route::get('/{tag}', 'TagController@show');
    Route::post('/', 'TagController@store');
    Route::put('/{tag}', 'TagController@update');
    Route::delete('/{tag}', 'TagController@destroy');
});

Route::group(['prefix' => 'authors/'], function () {
    Route::get('/', 'AuthorController@index');
    Route::get('/{author}', 'AuthorController@show');
    Route::post('/', 'AuthorController@store');
    Route::put('/{author}', 'AuthorController@update');
    Route::delete('/{author}', 'AuthorController@destroy');
});

Route::group(['prefix' => 'articles/'], function () {
    Route::get('/', 'ArticleController@index');
    Route::get('/{article}', 'ArticleController@show');
    Route::post('/', 'ArticleController@store');
    Route::put('/{article}', 'ArticleController@update');
    Route::delete('/{article}', 'ArticleController@destroy');
});