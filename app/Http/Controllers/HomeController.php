<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        // $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    
    public function index($id, $data=[]){

        // function travel_all_parents($id, $data=[]){

        //     $folder = model('Folder')::find($id);

        //     echo $folder->name."=====";
        //     array_push($data, $folder);

        //     if($folder->parent_id){
        //         return travel_all_parents($folder->parent_id, $data);
        //     }else return $data;

        // }

        // return travel_all_parents($id);

        $folder = model('Folder')::find($id);

        echo $folder->name."===";
        array_push($data, $folder);

        if($folder->parent_id){
            return $this->index($folder->parent_id, $data);
        }else return $data;
    }

    public function return_parent($id){
        
    }

    public function test(){

        return "testing";
    }
}
