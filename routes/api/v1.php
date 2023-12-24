<?php

Route::group([
    'prefix'=>'auth'
], function(){
    Route::post('email-login', 'AuthController@email_login');
    Route::post('social-login', 'AuthController@social_login');
});

Route::group([
    'prefix'=>'auth',
    'middleware'=>'auth:sanctum'
], function(){
    Route::get('user-info', 'AccountController@user_info');
    Route::get('ajax/{name}', 'AjaxController@get')->name('get-ajax');
    Route::post('ajax/{name}', 'AjaxController@post')->name('ajax-post');
});

Route::get('testing', 'HomeController@test');
Route::get('get-folders-list', 'HomeController@get_folders_list');
Route::get('get-file/{folder_id}', 'HomeController@get_file');

