<?php

use Faker\Generator as Faker;

$factory->define(App\Article::class, function (Faker $faker) {
    return [
        'title' => $faker->paragraph,
        'description' => $faker->text,
        'url' => $faker->url,
        'date_published' => $faker->unixTime,
    ];
});
