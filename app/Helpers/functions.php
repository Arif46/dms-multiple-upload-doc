<?php

function validate_ajax(array $rules, array $msg=[]){

    $validator=\Validator::make(request()->all(), $rules, $msg);

    if($validator->fails()){

        $errors=$validator->errors()->all();

        $result=[
            'error'=>TRUE,
            'msg'=>response(['msg'=>$errors[0]], 422)
        ];            

    }else{

        $result=[
            'error'=>FALSE,
            'msg'=>NULL
        ];

    }
    return (Object) $result;
}

function res_msg(String $msg, Int $code=200, Array $data=NULL){

    return response(['msg'=>$msg, 'data'=>$data], $code);
}
function laravel_paginate_array($total, $per_page, $current_page=NULL, $array_data=[]){

    if(empty($current_page)) $current_page=1;

    $current_url=url()->current();
    $query_string=request()->getQueryString();
    if($query_string){

        $query_string=str_replace([
            // "&page={$current_page}&",
            "&page={$current_page}",
            "page={$current_page}&",
            "page={$current_page}"
        ], '', $query_string);

    }

    if($total > 0) $last_page=ceil($total / $per_page);
    else $last_page=$current_page;

    if($current_page==$last_page) $next_page=NULL;
    else $next_page=$current_page+1;

    if($next_page && $query_string){
        $next_page_url="{$current_url}?{$query_string}&page={$next_page}";
    }elseif($next_page){
        $next_page_url="{$current_url}?page={$next_page}";
    }else $next_page_url=NULL;

    if($current_page > 1 && $query_string){
        $prev_page_url="{$current_url}?{$query_string}&page=".($current_page-1);
    }if($current_page > 1){
        $prev_page_url="{$current_url}?page=".($current_page-1);
    }else $prev_page_url=NULL;

    if($current_page==$last_page){

        $from=($per_page*($current_page-1))+1;
        $to=($per_page*($current_page-1))+($total%$per_page);

    }elseif($current_page > 1){

        $from=($per_page*($current_page-1))+1;
        $to=($per_page*($current_page-1))+$per_page;

    }else{

        $from=1;
        $to=$per_page;

    }

    if($query_string){
        $first_page_url="{$current_url}?{$query_string}&page=1";
        $last_page_url="{$current_url}?{$query_string}&page={$last_page}";
    }else{
        $first_page_url="{$current_url}?page=1";
        $last_page_url="{$current_url}?page={$last_page}";
    }

    return [
        'total'=>$total,
        'per_page'=>$per_page,
        'current_page'=>$current_page,
        'last_page'=>$last_page,
        'first_page_url'=>$first_page_url,
        'last_page_url'=>$last_page_url,
        'next_page_url'=>$next_page_url,
        'prev_page_url'=>$prev_page_url,
        'path'=>$current_url,
        'from'=>$from,
        'to'=>$to,
        'data'=>$array_data
    ];

}

function model($name){
    return "\\App\\Models\\{$name}";
}

function ltrim_phone_code(String $pn, String $code="88"){

    return preg_replace("/^\+?{$code}/", '',$pn);
}

function download_aws_media($aws_media_id, string $suffix=NULL){

	$aws_media=\App\Models\AwsMedia::find($aws_media_id);

	if(empty($aws_media)) return abort(404);

	$file_exists=\Storage::disk('s3')->exists($aws_media->folder_path.'/'.$aws_media->file);

	if(!$file_exists) return abort(404);

	/*$new_filename='download_'.uniqid();
	$lead=$aws_media->lead;

	if($lead){

		$new_filename=str_slug("{$lead->given_name}_{$lead->family_name}_{$aws_media->document_type}", "_");

	}

	if($suffix){

		$new_filename.='_'.str_slug($suffix, '_').'.'.$aws_media->extension;

	}else $new_filename.='.'.$aws_media->extension;*/

	$new_filename=named_aws_media($aws_media, $suffix);

    $headers=[];

    return \Storage::disk('s3')->download(
        $aws_media->folder_path.'/'.$aws_media->file,
        $new_filename,
        $headers
    );

}

if(!function_exists('named_aws_media')){

	function named_aws_media(\App\Models\AwsMedia $aws_media, $suffix=NULL){

		$new_filename='download_'.uniqid();
		$lead=$aws_media->lead;

		if($lead){
			$new_filename=str_slug("{$lead->given_name}_{$lead->family_name}_{$aws_media->document_type}", "_");
		}

		if($suffix){

			$new_filename.='_'.str_slug($suffix, '_').'.'.$aws_media->extension;

		}else $new_filename.='.'.$aws_media->extension;

		return $new_filename;

	}

}

function upload_aws_media(
	\Illuminate\Http\UploadedFile $file,
	$args=[],
	string $folder_path=NULL
){

	if(empty($folder_path)) $folder_path='aws_media';
	else $folder_path=trim($folder_path, '/');

	$attr=[
		'model'=>NULL,
		'model_id'=>NULL,
		'folder_path'=>$folder_path
	];

	if($args) $attr=array_merge($attr, $args);

	$aws_media=\App\Models\AwsMedia::create($attr);
	$aws_media->original_name=$file->getClientOriginalName();
	$aws_media->extension=$file->getClientOriginalExtension();
	$aws_media->type=$file->getMimeType();
	$aws_media->size=$file->getSize();

	do{
    	$filename=uniqid($aws_media->id).'.'.$aws_media->extension;
	}while(\Storage::disk('s3')->exists($folder_path.'/'.$filename));

	$aws_media->file=$filename;
	$aws_media->save();

	$file->storeAs($folder_path, $filename, 's3');

	//\Storage::disk('media')->put($media->file, $file->getRealPath());

	return $aws_media;

}

function delete_aws_media($id_or_file){

	$aws_media=NULL;

	$aws_media=\App\Models\AwsMedia::where(
		'id', $id_or_file
	)->orWhere(
		'file', $id_or_file
	)->first();

	if(empty($aws_media)) return FALSE;

	if(empty($aws_media->folder_path)) $folder_path='aws_media';
	else $folder_path=$aws_media->folder_path;

	if(\Storage::disk('s3')->exists($folder_path.'/'.$aws_media->file)){

		\Storage::disk('s3')->delete($folder_path.'/'.$aws_media->file);

	}

	if($aws_media->delete()) return TRUE;
	return FALSE;

}

function aws_media_url($id_or_file){

	$aws_media=NULL;

	if(is_int($id_or_file)){

		$aws_media=\App\Models\AwsMedia::find($id_or_file);

	}elseif(is_string($id_or_file)){

		$aws_media=\App\Models\AwsMedia::Where('file', $id_or_file)->first();

	}

	if(empty($aws_media)) return FALSE;

	if(empty($aws_media->folder_path)) $folder_path='aws_media';
	else $folder_path=$aws_media->folder_path;

	return \Storage::disk('s3')->url($folder_path.'/'.$aws_media->file);

}

if(!function_exists('tmp_aws_media')){

    function tmp_aws_media(\App\Models\AwsMedia $aws_media){

		$file_exists = \Storage::disk('tmp_aws_media')->exists($aws_media->file);

        if(empty($file_exists)){ 
        	$aws_file_exists = \Storage::disk('s3')->exists($aws_media->folder_path.'/'.$aws_media->file);
        	if($aws_file_exists){
        		$content = \Storage::disk('s3')->get($aws_media->folder_path.'/'.$aws_media->file);  
            	\Storage::disk('tmp_aws_media')->put($aws_media->file, $content);
        	}else{
        		return no_img();
        	} 
        } 

        $url = \Storage::disk('tmp_aws_media')->url(
            $aws_media->file
        );
 
        return $url; 
    }  
}