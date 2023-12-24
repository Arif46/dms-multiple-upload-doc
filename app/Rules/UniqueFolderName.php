<?php

namespace App\Rules;

use Illuminate\Contracts\Validation\Rule;
use App\Models\Folder;

class UniqueFolderName implements Rule
{
    /**
     * Create a new rule instance.
     *
     * @return void
     */

    protected $parent_id;

    public function __construct($parent_id)
    {
        $this->parent_id = $parent_id;
    }

    /**
     * Determine if the validation rule passes.
     *
     * @param  string  $attribute
     * @param  mixed  $value
     * @return bool
     */

     public function passes($attribute, $value)
     {
         $count = Folder::where('name', $value)
                       ->where('parent_id', $this->parent_id)
                       ->count();
 
         return $count === 0;
     }

    /**
     * Get the validation error message.
     *
     * @return string
     */
    public function message()
    {
        return 'The validation error message.';
    }
}
