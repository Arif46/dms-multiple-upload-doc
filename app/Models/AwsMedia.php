<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AwsMedia extends Model{

	protected $guarded=['id'], 
	$table='aws_media';

	// public function lead(){

	// 	return $this->belongsTo('App\Models\Lead', 'lead_id');

	// }

	// public function creator(){

	// 	$creator_type=$this->creator_type;
	// 	$model='App\Models\Agent';

	// 	if($creator_type=='admin'){
	// 		$model='App\Models\Admin';
	// 	}elseif($creator_type=='agent' || $creator_type=='sub_agent'){
	// 		$model='App\Models\Agent';
	// 	}elseif($creator_type=='applyuser'){
	// 		$model='App\Models\Applyuser';
	// 	}elseif($creator_type=='student'){
	// 		$model='App\Models\Student';
	// 	}

	// 	return $this->belongsTo($model, 'creator_id');

	// }

	// public function attachment_by(){

    // 	return $this->belongsTo('App\Models\ManageTicket','model_id','id');
    // }

}
