<?php

namespace App\Http\Controllers\Api\V1;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
class AccountController extends Controller
{
    public function user_info(Request $req)
    {
        return $req->user();
    }
}