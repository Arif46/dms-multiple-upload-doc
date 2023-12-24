<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Folder extends Model
{
    protected $table = "folders";
    public $timestamps = false;

    protected $fillable = ['name'];

    public function aws_files(){
        return $this->hasMany('App\Models\AwsMedia','model_id','id');
    }

    public function user() {
        return $this->belongsTo('App\Models\User','user_id', 'id'); 
    }

    public function user_info() {
        return $this->hasOne('App\Models\UserFolderRelationship','folder_id', 'id'); 
    }
}
