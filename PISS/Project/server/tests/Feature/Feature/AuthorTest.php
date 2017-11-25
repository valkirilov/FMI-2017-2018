<?php

namespace Tests\Feature\Feature;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

use App\Author;

class AuthorTest extends TestCase
{
    public function testsAuthorsAreCreatedCorrectly()
    {
        $headers = [];
        $payload = [
            'name' => 'Test Author - CREATE',
            'url' => 'https://fmi.uni-sofia.bg'
        ];

        $this->json('POST', '/api/authors', $payload, $headers)
            ->assertStatus(201)
            ->assertJson([
              'name' => 'Test Author - CREATE',
              'url' => 'https://fmi.uni-sofia.bg'
            ]);
    }

    public function testsAuthorsAreUpdatedCorrectly()
    {
        $headers = [];
        $author = factory(Author::class)->create([
            'name' => 'Test Author - UPDATE',
            'url' => 'https://fmi.uni-sofia.bg'
        ]);

        $payload = [
            'name' => 'Test Author - UPDATED',
            'url' => 'https://fmi.uni-sofia.bg/updated/'
        ];

        $response = $this->json('PUT', '/api/authors/' . $author->id, $payload, $headers)
            ->assertStatus(200)
            ->assertJson([
                'id' => $author->id,
                'name' => 'Test Author - UPDATED',
                'url' => 'https://fmi.uni-sofia.bg/updated/'
            ]);
    }

    public function testsAuthorsAreDeletedCorrectly()
    {
        $headers = [];
        $author = factory(Author::class)->create([
            'name' => 'Test Author - DELETE',
            'url' => 'https://fmi.uni-sofia.bg'
        ]);

        $this->json('DELETE', '/api/authors/' . $author->id, [], $headers)
            ->assertStatus(204);
    }

    public function testAuthorsAreListedCorrectly()
    {
        factory(Author::class)->create([
            'name' => 'First Test Author',
            'url' => 'https://fmi.uni-sofia.bg'
        ]);

        factory(Author::class)->create([
            'name' => 'Second Test Author',
            'url' => 'https://fmi.uni-sofia.bg'
        ]);

        $headers = [];

        $response = $this->json('GET', '/api/authors', [], $headers)
            ->assertStatus(200)
            ->assertJson([
                [ 'name' => 'First Test Author', 'url' => 'https://fmi.uni-sofia.bg' ],
                [ 'name' => 'Second Test Author', 'url' => 'https://fmi.uni-sofia.bg' ]
            ])
            ->assertJsonStructure([
                '*' => ['id', 'name', 'url', 'created_at', 'updated_at'],
            ]);
    }
}
