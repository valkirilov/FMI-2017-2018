<?php

namespace App\Http\Controllers;

use App\Article;
use Illuminate\Http\Request;

class ArticleController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $isPaginated = $request->get('paginate');
        $count = $request->get('count');
        $orderBy = $request->get('orderBy');
        $orderDirection = $request->get('orderDirection');
        $categoryId = $request->get('category_id');

        $articles = new Article();
        $articles = $articles->with('author')->with('category')->with('tags');

        if ($orderBy && $orderDirection) {
            $articles = $articles->orderBy($orderBy, $orderDirection);
        }
        else {
            $articles = $articles->orderBy('date_published', 'desc');
        }

        if ($categoryId) {
            $articles = $articles->where('category_id', $categoryId);
        }

        if ($isPaginated) {
            $articles = $articles->paginate();
        }
        else if ($count) {
            $articles = $articles->take($count)->get();
        }
        else {
            $articles = $articles->get();
        }

        return $articles;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Article  $article
     * @return \Illuminate\Http\Response
     */
    public function show(Article $article)
    {
        $article->category;
        $article->author;
        $article->tags;
        return $article;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $article = Article::create($request->all());

        return response()->json($article, 201);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Article  $article
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Article $article)
    {
        $article->update($request->all());

        return response()->json($article, 200);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Article  $article
     * @return \Illuminate\Http\Response
     */
    public function destroy(Article $article)
    {
        $article->delete();

        return response()->json(null, 204);
    }
}
