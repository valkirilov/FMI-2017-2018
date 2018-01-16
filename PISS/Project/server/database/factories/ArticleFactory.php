<?php

use Faker\Generator as Faker;

$factory->define(App\Article::class, function (Faker $faker) {

    $author = App\Author::inRandomOrder()->first();
    $category = App\Category::inRandomOrder()->first();

    return [
        'title' => $faker->sentence,
        'description' => $faker->text,
        'content' => $faker->paragraphs(5, true),
        'image' => $faker->image('public/storage/images', 640, 480, null, false),
        'url' => $faker->url,
        'date_published' => $faker->dateTime,
        'views' => $faker->randomNumber,

        'author_id' => $author ? $author->id : factory(App\Author::class)->create()->id,
        'category_id' => $category ? $category->id : factory(App\Category::class)->create()->id,
    ];
});
