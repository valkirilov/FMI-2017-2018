<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    protected $fillable = [
    	'title',
    	'description',
    	'url',
    	'category_id',
    	'author_id',
    	'date_published'
    ];

    /**
     * Get the category that the article belongs to
     */
    public function category()
    {
        return $this->belongsTo('App\Category');
    }

    /**
     * Get the author that the article belongs to
     */
    public function author()
    {
        return $this->belongsTo('App\Author');
    }

    /**
     * The tags that belong to the article.
     */
    public function tags()
    {
        return $this->belongsToMany('App\Tag');
    }
}
