<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DownloadController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function download_media($id, $suffix=NULL){ 

        //dd($id, "testing ==========");
        $aws_media = model('AwsMedia')::find($id);

        // if(in_array($aws_media->type,['image/png','image/jpeg'])){ 
        //     return $this->download_image_to_pdf($aws_media,$suffix);
        // }else{

        // }  
        return download_aws_media($id, $suffix);

    }

    
}
