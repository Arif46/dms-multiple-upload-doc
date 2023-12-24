<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    protected $table = "posts";
    public function author(){
        return $this->belongsTo('App\Models\User','creator_id','id'); 
    }
}
