<?php

namespace App\Http\Controllers\Api\V1;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\AwsMedia;
use App\Models\Friend;
use App\Models\LikeAndDislike;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Post;
use App\Models\PostTag;
use Illuminate\Support\Facades\Validator;

class AjaxController extends Controller
{
    public function get(Request $req, $name)
    {
        $auth_user=$req->user();
        $carbon=new \Carbon\Carbon;

        if($name=="my_friend_request_list"){

            $friend = Friend::with('user')->where('status',1)->where('recipient',$auth_user->id)->get();

            $data=[];
            foreach($friend as $row){
                array_push($data,[
                    'id'=>$row->id,
                    'name'=>@$row->user->first_name,
                    'status'=>$row->status,
                ]);
            }

            return res_msg('My Friend Request List', 200, [
                'list'=>$data
            ]);
        }elseif($name=='private_wall'){
            $user = User::find($auth_user->id);
            $posts = Post::with('author')->where('creator_id',$auth_user->id)->orderBy('id','DESC')->get();

            foreach($posts as $row){
                $exists = LikeAndDislike::where([
                    'post_id'=>$row->id,
                    'user_id'=>$auth_user->id
                ])->first();
                $row->like_and_dislike_status=0;
                if($exists){
                    $row->like_and_dislike_status=$exists->type;
                }

                $row->media=asset("/post").'/'.$row->media;
            }
            return res_msg('My private wall', 200, [
                'user'=>$user,
                'posts'=>$posts,
            ]);
        }elseif($name=='public_wall'){
            $posts = Post::with('author')->orderBy('id','DESC')->get();
            foreach($posts as $row){
                $exists = LikeAndDislike::where([
                    'post_id'=>$row->id,
                    'user_id'=>$auth_user->id
                ])->first();
                $row->like_and_dislike_status=0;
                if($exists){
                    $row->like_and_dislike_status=$exists->type;
                }
                $row->media=asset("/post").'/'.$row->media;
            }
            return res_msg('Public wall', 200, [
                'posts'=>$posts,
            ]);
        }elseif($name=="my_friend_list"){

            $friend = Friend::with('user')->where('status',2)->where('recipient',$auth_user->id)->get();

            $data=[];
            foreach($friend as $row){
                array_push($data,[
                    'id'=>@$row->user->id,
                    'name'=>@$row->user->first_name,
                    'status'=>$row->status,
                ]);
            }

            return res_msg('My Friend List', 200, [
                'list'=>$data
            ]);
        }elseif($name=="user_list"){

            $user_list = model('User')::all();

            return res_msg('All User List', 200, [
                'list'=>$user_list
            ]);

        }elseif($name=="file_folder_list"){

            $user_wise_folder = model('UserFolderRelationship')::where('user_id', $req->user_id)->pluck('folder_id')->toArray();

            $user_info = model('User')::find($req->user_id);

            $folder_list = model('Folder')::with(['aws_files', 'user_info.user'])->whereIn('id', $user_wise_folder);

            // return ($folder_list->get());

            if($req->parent_id == 0){
                $folder_list = $folder_list->where('parent_id', 0);
            }elseif($req->parent_id > 0){
                $folder_list = $folder_list->where('parent_id', $req->parent_id);
            }

            $folder_list = $folder_list->get();

            $file_list = [];
            $files = model('AwsMedia')::where('model_id', $req->parent_id)->get();

            if($files){
                foreach($files as $key=>$file){
                    $file_list[$key]['original_name'] = $file->original_name;
                    $file_list[$key]['name'] = $file->name;
                    $file_list[$key]['size'] = $file->size;
                    $file_list[$key]['url'] = tmp_aws_media($file);
                    $file_list[$key]['id'] = $file->id;
                    $file_list[$key]['extension'] = $file->extension;
                    $file_list[$key]['user_name'] = $user_info->name;
                    $file_list[$key]['data_created'] = $user_info->created_at;
                }
            }

            return res_msg('Folder or File List', 200, [
                'folder_list'=>$folder_list,
                'file_list'=>$file_list
            ]);

        }elseif($name=="bread_crumbs"){

            function travel_all_parents($id, $data=[]){

                $folder = model('Folder')::find($id);
                array_push($data, $folder);

                if($folder->parent_id>0){
                    return travel_all_parents($folder->parent_id, $data);
                }else return array_reverse($data);
            }

            return travel_all_parents($req->id);
            // return $req->id;
        }elseif($name=="download_media"){
        // public function ($id, $suffix=NULL){

            $aws_media = model('AwsMedia')::find($req->id);

            // if(in_array($aws_media->type,['image/png','image/jpeg'])){
            //     return $this->download_image_to_pdf($aws_media,$req->suffix);
            // }else{
                return download_aws_media($req->id, $req->suffix);
            // }

        }
        return response(['msg'=>'Name argument not specified.'], 403);
    }

    public function post(Request $req, $name){
        $auth_user=$req->user();
        $carbon=new \Carbon\Carbon;

        if($name=="store_post"){
            $v=validate_ajax([
                'media_type'=>'nullable|numeric',
            ]);

            if($v->error) return $v->msg;


            $post = new Post;
            $post->caption = $req->caption;
            $post->media_type = $req->media_type;
            $post->like = 0;
            $post->dislike = 0;
            $post->creator_id = $auth_user->id;
            $post->save();

            if($req->media){
                $destinationPath =   public_path('/post');
                $file = $req->media;
                $ext = $req->media->getClientOriginalExtension();
                $fileName = 'post_'.uniqid().'.'.$ext;
                if(file_exists($destinationPath.'/'.$fileName)){
                        @unlink($destinationPath.'/'.$fileName);
                }
                $file->move($destinationPath, $fileName);
                $post->media= $fileName;
                $post->update();
            }

            if($req->user_ids){
                foreach($req->user_ids as $row){
                    $post_tag = new PostTag();
                    $post_tag->user_id = $row;
                    $post_tag->post_id = $post->id;
                    $post_tag->save();
                }
            }

            return [
                'msg'=>"Successfully post created.",
            ];

        }elseif($name=="store_like_and_dislike"){

            $v=validate_ajax([
                'post_id'=>'required|numeric',
                'type'=>'required|numeric',
            ]);

            if($v->error) return $v->msg;

            $exists = LikeAndDislike::where([
                'post_id'=>$req->post_id,
                'user_id'=>$auth_user->id
            ])->first();
            if($exists){
                $post = Post::find($req->post_id);

                if($exists->type == $req->type){
                    LikeAndDislike::where([
                        'post_id'=>$req->post_id,
                        'user_id'=>$auth_user->id
                    ])->delete();

                    if($req->type == 1){
                        $post->like= $post->like - 1;
                    }
                    if($req->type == 2){
                        $post->dislike= $post->dislike - 1;
                    }
                    $post->Update();
                    return [
                        'msg'=>"Successfully data removed.",
                    ];
                }elseif($exists->type == 1 && $req->type==2){

                    LikeAndDislike::where([
                        'post_id'=>$req->post_id,
                        'user_id'=>$auth_user->id
                    ])->delete();

                    $post->like= $post->like - 1;
                    $post->dislike= $post->dislike + 1;
                    $post->Update();

                    $info= New LikeAndDislike;
                    $info->post_id=$req->post_id;
                    $info->user_id=$auth_user->id;
                    $info->type=$req->type;
                    $info->save();
                    return [
                        'msg'=>"Successfully data update.",
                    ];
                }elseif($exists->type == 2 && $req->type==1){

                    LikeAndDislike::where([
                        'post_id'=>$req->post_id,
                        'user_id'=>$auth_user->id
                    ])->delete();

                    $post->like= $post->like + 1;
                    $post->dislike= $post->dislike - 1;

                    $post->Update();

                    $info= New LikeAndDislike;
                    $info->post_id=$req->post_id;
                    $info->user_id=$auth_user->id;
                    $info->type=$req->type;
                    $info->save();
                    return [
                        'msg'=>"Successfully data updated.",
                    ];
                }
            }else{

                $post = Post::find($req->post_id);

                if($req->type == 1){
                    $post->like= $post->like +1;
                }
                if($req->type == 2){
                    $post->dislike= $post->dislike + 1;
                }

                $post->Update();

                $info= New LikeAndDislike;
                $info->post_id=$req->post_id;
                $info->user_id=$auth_user->id;
                $info->type=$req->type;
                $info->save();
                return [
                    'msg'=>"Successfully data updated.",
                ];
            }


        }elseif($name=="send_frined_request"){

            $v=validate_ajax([
                'recipient'=>'required|numeric',
            ]);

            if($v->error) return $v->msg;

            $friend = New Friend;
            $friend->sender = $auth_user->id;
            $friend->recipient = $req->recipient;
            $friend->status = 1;
            $friend->save();
            return [
                'msg'=>"Friend request sent.",
            ];

        }elseif($name=="accept_frined_request"){

            $v=validate_ajax([
                'row_id'=>'required|numeric',
            ]);

            if($v->error) return $v->msg;

            $friend = Friend::find($req->row_id);
            $friend->status = 2;
            $friend->Update();
            return [
                'msg'=>"Accept friend request.",
            ];

        }elseif($name=="cancel_frined_request"){

            $v=validate_ajax([
                'row_id'=>'required|numeric',
            ]);

            if($v->error) return $v->msg;

            $friend = Friend::find($req->row_id);
            $friend->status = 3;
            $friend->Update();

            return [
                'msg'=>"Cancel friend request.",
            ];

        }elseif($name=='search'){
            $q=$req->search;
            $user = User::where(function($query) use ($q) {
                $query->where('email', 'LIKE', '%'.$q.'%')->orWhere('first_name', 'LIKE', '%'.$q.'%');
            })->get();

            return res_msg('Search User', 200, [
                'users'=>$user,
            ]);
        }elseif($name=='create-user'){

            if($req->id){
                $v = validate_ajax([
                    'name'=>'required',
                    'email'=>"required|email",
                    'phone'=>'required',
                ]);
            }else{
                $v = validate_ajax([
                    'name'=>'required',
                    'email'=>"required|email|unique:users,email",
                    'phone'=>'required',
                ]);
            }

            if($v->error) return $v->msg;

            if($req->id){
                $post = model('User')::find($req->id);
                $msg = "Successfully user updated.";
            }else{
                $post = new \App\Models\User;
                $msg = "Successfully user created.";
            }

            $post->name = $req->name;
            $post->password = bcrypt('123456');
            $post->email = $req->email;
            $post->phone = $req->phone;
            $post->save();

            return [
                'msg'=> $msg,
            ];
        }elseif($name=="user_delete"){

            model('User')::find($req->id)->delete();
            return [
                'msg'=> 'Removed Successfully',
            ];

        }elseif($name=="create_folder"){

            // $v = validate_ajax([
            //     'name'=>'required'
            // ]);

            // if($v->error) return $v->msg;

            // $v = validate_ajax([
            //     'name' => ['required', new \App\Rules\UniqueFolderName($req->parent_id)],
            // ]);

            // if($v->error) return $v->msg;

            $folder_exists= model('Folder')::where([
                'name'=>$req->name,
                'parent_id'=>$req->parent_id
            ])->exists();

            if($folder_exists){
                return response([
                    'msg'=>'Select folder name already exists please choose another name.'
                 ], 403);
            }

            $post = new \App\Models\Folder;
            $post->name = $req->name;
            $post->parent_id = $req->parent_id;
            $post->level_id = $req->level_id;
            $post->status = $req->status??1;
            $post->created_at = now();
            $post->created_by = \Auth::user()->id;
            $post->save();

            $rela = new \App\Models\UserFolderRelationship;
            $rela->user_id = \Auth::user()->id;
            $rela->folder_id = $post->id;
            $rela->level_id = 0;
            $rela->save();

            return [
                'msg'=> 'Create Successfully',
            ];

        }elseif($name=="upload_file"){

            // $v = validate_ajax([
            //     'name'=>'nullable',
            //     'file.*' => 'required'
            // ]);

            // if($v->error) return $v->msg;
            // return $req->all();
            // foreach($request->file as $key=>$val){
                // dd($val);
                // $parent_id = $req->parent_id;
                // if($req->file instanceof \Illuminate\Http\UploadedFile){
                //     upload_aws_media($req->file,[
                //         'model' =>'App\Models\Folder',
                //         // 'model' =>get_class($sav),
                //         'model_id'=>$parent_id,
                //         'name'=>$req->name
                //     ]);
                // }
            // }

            $v = validate_ajax([
                'name' => 'nullable',
                // 'files.*' => 'required|mimes:png,jpg,jpeg|max:2048' // Note the 'files.*' to validate each uploaded file
            ]);

            if($v->error) {
                return $v->msg;
            }

            $parent_id = $req->parent_id;
            info($req->all());
            // return;
            // if($req->hasFile('files')) {
                foreach($req->file('files') as $file) {

                    if($file instanceof \Illuminate\Http\UploadedFile){
                        upload_aws_media($file,[
                            'model' =>'App\Models\Folder',
                            'model_id'=>$parent_id,
                            // 'original_name'=> $req->name
                        ]);
                    }
                }

            return [
                'msg'=> 'Upload Successfully',
            ];

        } else if($name == 'file_delete') {

            $fileId = model('AwsMedia')::find($req->id)->delete();

            if (!$fileId) {
                return [
                    'msg'=> 'Data Not Found',
                ];
            }

            return [
                'msg'=> 'Removed Successfully',
            ];
        } elseif($name == 'folder_delete') {

            // $folderId = model('Folder')::find($req->id)->delete();
            $folderId = model('Folder')::find($req->id)->delete();

            if (!$folderId) {
                return [
                    'msg'=> 'Data Not Found',
                ];
            }

            return [
                'msg'=> 'Removed Successfully',
            ];

        } else if ($name == 'update_folder_data') {

            $validate = Validator::make($req->all(), [
                'name' => 'required',
            ],[
                'name.required' => 'The Name id is required'
            ]);

            if ($validate->fails()) {
                return response()->json([
                    'status' => false,
                    'message' => 'validation error',
                    'errors' => $validate->errors()
                ], 422);
            }

            try {

                $FolderNameUpdate = model('Folder')::find($req->id);

                // return $FolderNameUpdate;

                $FolderNameUpdate->update([
                    'name' => $req->name
                ]);

                return response()->json([
                    'success' => true,
                    'message' => 'Data updated successfully',
                    'data'  => $FolderNameUpdate
                ], 200);

            } catch (\Throwable $th) {
                return response()->json([
                    'success' => false,
                    'message' => $th->getMessage()
                ], 500);
            }

        } else if ($name == 'update_file_data') {

            $validate = Validator::make($req->all(), [
                'original_name' => 'required',
            ],[
                'original_name.required' => 'The Original Name is required'
            ]);

            if ($validate->fails()) {
                return response()->json([
                    'status' => false,
                    'message' => 'validation error',
                    'errors' => $validate->errors()
                ], 422);
            }

            $fileNameUpdate = model('AwsMedia')::find($req->id);

            try {

                $fileNameUpdate->update([
                    'original_name' => $req->original_name
                ]);

              } catch (\Throwable $th) {
                return response()->json([
                    'success' => false,
                    'message' => $th->getMessage()
                ], 500);
            }

            return response()->json([
                'success' => true,
                'message' => 'Data updated successfully',
                'data'  => $fileNameUpdate
            ], 200);
        } else if ($name == 'all_user_delete') {

            $ids = $req->input($req->id);

            // Delete users where their IDs are present in the received array
            $deleted = User::whereIn('id', $ids)->delete();

            return [
                'msg' => $deleted > 0 ? 'Removed Successfully' : 'No users deleted',
            ];

            

        }
        else return response(['mag'=>'No name argument found.'], 403);
    }
}
