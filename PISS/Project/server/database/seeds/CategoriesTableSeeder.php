<?php

use Illuminate\Database\Seeder;
use App\Category;

class CategoriesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Let's truncate our existing records to start from scratch.
        Category::truncate();

        $faker = \Faker\Factory::create();

        // And now, let's create a few categories in our database:
        for ($i = 0; $i < 10; $i++) {
            Category::create([
                'name' => $faker->name
            ]);
        }
    }
}
