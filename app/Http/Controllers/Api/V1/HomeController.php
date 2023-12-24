<?php

namespace App\Http\Controllers\Api\V1;
use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use App\Models\Folder;

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
    public function index()
    {
        dd('exit');
        // return view('home');
    }

    public function test(){

        return "testing";
    }

    public function get_folders_list(){

        $folders = Folder::where('status', 1)->get();

        return res_msg('Folder List', 200, [
            'list'=>$folders
        ]);
    }

    public function get_file($folder_id){

        $files = Folder::where('parent_id', $folder_id)->get();

        return res_msg('File List', 200, [
            'list'=>$files
        ]);
    }
}
