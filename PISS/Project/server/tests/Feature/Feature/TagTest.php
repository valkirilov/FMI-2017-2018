<?php

namespace Tests\Feature\Feature;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

use App\Tag;

class TagTest extends TestCase
{
    public function testsTagsAreCreatedCorrectly()
    {
        $headers = [];
        $payload = [
            'name' => 'Test Tag - CREATE'
        ];

        $this->json('POST', '/api/tags', $payload, $headers)
            ->assertStatus(201)
            ->assertJson(['name' => 'Test Tag - CREATE']);
    }

    public function testsTagsAreUpdatedCorrectly()
    {
        $headers = [];
        $tag = factory(Tag::class)->create([
            'name' => 'Test Tag - UPDATE',
        ]);

        $payload = [
            'name' => 'Test Tag - UPDATED',
        ];

        $response = $this->json('PUT', '/api/tags/' . $tag->id, $payload, $headers)
            ->assertStatus(200)
            ->assertJson([
                'id' => $tag->id,
                'name' => 'Test Tag - UPDATED'
            ]);
    }

    public function testsTagsAreDeletedCorrectly()
    {
        $headers = [];
        $tag = factory(Tag::class)->create([
            'name' => 'Test Tag - DELETE',
        ]);

        $this->json('DELETE', '/api/tags/' . $tag->id, [], $headers)
            ->assertStatus(204);
    }

    public function testTagAreListedCorrectly()
    {
        factory(Tag::class)->create([
            'name' => 'First Test Tag',
        ]);

        factory(Tag::class)->create([
            'name' => 'Second Test Tag',
        ]);

        $headers = [];

        $response = $this->json('GET', '/api/tags', [], $headers)
            ->assertStatus(200)
            ->assertJson([
                [ 'name' => 'First Test Tag' ],
                [ 'name' => 'Second Test Tag' ]
            ])
            ->assertJsonStructure([
                '*' => ['id', 'name', 'created_at', 'updated_at'],
            ]);
    }
}
