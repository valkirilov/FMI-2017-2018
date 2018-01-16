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
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        Category::truncate();
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        Category::create(['name' => 'News']);
        Category::create(['name' => 'Politics']);
        Category::create(['name' => 'Culture']);
        Category::create(['name' => 'Sport']);
        Category::create(['name' => 'Debate']);
        Category::create(['name' => 'Enterntainment']);
    }
}
