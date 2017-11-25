<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Author extends Model
{
    protected $fillable = ['name', 'url'];

    /**
     * Get the articles of the author.
     */
    public function articles()
    {
        return $this->hasMany('App\Article');
    }
}
