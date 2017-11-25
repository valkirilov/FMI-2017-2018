<?php

namespace Tests\Feature\Feature;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

use App\Category;

class CategoryTest extends TestCase
{
    public function testsCategoriesAreCreatedCorrectly()
    {
        $headers = [];
        $payload = [
            'name' => 'Test Category - CREATE'
        ];

        $this->json('POST', '/api/categories', $payload, $headers)
            ->assertStatus(201)
            ->assertJson(['name' => 'Test Category - CREATE']);
    }

    public function testsCategoriesAreUpdatedCorrectly()
    {
        $headers = [];
        $category = factory(Category::class)->create([
            'name' => 'Test Category - UPDATE',
        ]);

        $payload = [
            'name' => 'Test Category - UPDATED',
        ];

        $response = $this->json('PUT', '/api/categories/' . $category->id, $payload, $headers)
            ->assertStatus(200)
            ->assertJson([
                'id' => $category->id,
                'name' => 'Test Category - UPDATED'
            ]);
    }

    public function testsCategoriesAreDeletedCorrectly()
    {
        $headers = [];
        $category = factory(Category::class)->create([
            'name' => 'Test Category - DELETE',
        ]);

        $this->json('DELETE', '/api/categories/' . $category->id, [], $headers)
            ->assertStatus(204);
    }

    public function testCategoriesAreListedCorrectly()
    {
        factory(Category::class)->create([
            'name' => 'First Test Category',
        ]);

        factory(Category::class)->create([
            'name' => 'Second Test Category',
        ]);

        $headers = [];

        $response = $this->json('GET', '/api/categories', [], $headers)
            ->assertStatus(200)
            ->assertJson([
                [ 'name' => 'First Test Category' ],
                [ 'name' => 'Second Test Category' ]
            ])
            ->assertJsonStructure([
                '*' => ['id', 'name', 'created_at', 'updated_at'],
            ]);
    }
}
