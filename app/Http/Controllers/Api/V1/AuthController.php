<?php

namespace App\Http\Controllers\Api\V1;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\HasApiTokens;

class AuthController extends Controller{
    public function email_login(Request $req){
        $v=validate_ajax([
            'email'=>'required|exists:users',
            'password'=>'required'
        ]);

        if($v->error) return $v->msg;

        $user=User::where([
            'email'=>$req->email,
            'status'=>1
        ])->first();

        if(Hash::check($req->password, $user->password)){

            return res_msg('User logged in successfully!.', 200, [
                'token'=>$user->createToken('token-name')->plainTextToken,
                'user'=>[
                    'id'=>$user->id,
                    'name'=>$user->name,
                    'email'=>$user->email
                ]
            ]);
            
        }else{

            return res_msg('Invalid login information', 422);

        }
    }

    public function social_login(Request $req){

        if($req->google_id){

            $user=User::where(
                'google_id', $req->google_id
            )->first();

        }elseif($req->facebook_id){
            
            $user=User::where(
                'facebook_id', $req->facebook_id
            )->first();

        }

        if(empty($req->google_id) && empty($req->facebook_id)){

            return response([
                'msg'=>'Please!, insert facebook id or google id.'
            ], 422);

        }

        if(empty($user)){

            $user=User::where(
                'email', $req->email
            )->whereNotNUll(
                'email'
            )->first();

            if(empty($user)){

                $v=validate_ajax([
                    'first_name'=>'required|string',
                    'email'=>'nullable|unique:users'
                ]);
        
                if($v->error) return $v->msg;

                $user=User::create([
                    'facebook_id'=>$req->facebook_id,
                    'google_id'=>$req->google_id,
                    'first_name'=>$req->first_name,
                    'last_name'=>$req->last_name,
                    'email'=>$req->email,
                    'image_url'=>$req->image_url,
                    'phone'=> $req->phone ? ltrim_phone_code($req->phone) : NULL
                ]);

            }else{

                if($req->facebook_id) $user->facebook_id=$req->facebook_id;

                if($req->google_id) $user->google_id=$req->google_id;

                if($req->first_name && is_string($req->first_name)){
                    $user->first_name=$req->first_name;
                }

                if($req->last_name  && is_string($req->last_name)){
                    $user->last_name=$req->last_name;
                }
                
                $user->update();

            }

        }

        // if($req->google_id && $req->email){

        //     $user_exists=User::where([
        //         'email'=>$req->email
        //     ])->first();

        //     if($user_exists){
                $user->first_name=$req->first_name;
                $user->last_name=$req->last_name;
                $user->email=$req->email;
                $user->image_url=$req->image_url;
                $user->update();
        //     }

        // }

        return res_msg('User logged in successfully!.', 200, [
            'token'=>$user->createToken('token-name')->plainTextToken,
            'user'=>[
                'id'=>$user->id,
                'first_name'=>$user->first_name,
                'last_name'=>$user->last_name,
                'email'=>$user->email,
                'image_url'=>$user->image_url
            ]
        ]);

    }
}