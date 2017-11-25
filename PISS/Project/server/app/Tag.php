<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Tag extends Model
{
    protected $fillable = ['name'];

    /**
     * The articles that belong to the tag.
     */
    public function articles()
    {
        return $this->belongsToMany('App\Article');
    }
}
