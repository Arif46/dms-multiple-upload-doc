<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserFolderRelationship extends Model
{
    protected $table = "user_folder_relationships";
    public $timestamps = false;

    public function user(){
        return $this->belongsTo('App\Models\User','user_id'); 
    }
}
