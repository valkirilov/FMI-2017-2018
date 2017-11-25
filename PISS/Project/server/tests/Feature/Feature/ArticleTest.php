<?php

namespace Tests\Feature\Feature;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

use App\Article;

class ArticleTest extends TestCase
{
    public function testsArticlesAreCreatedCorrectly()
    {
        $headers = [];
        $payload = [
            'title' => 'Test Article - CREATE',
            'description' => 'Test Article - CREATE',
            'url' => 'https://fmi.uni-sofia.bg',
            'date_published' => '2017-11-25 10:34:47'
        ];

        $this->json('POST', '/api/articles', $payload, $headers)
            ->assertStatus(201)
            ->assertJson([
	              'title' => 'Test Article - CREATE',
		            'description' => 'Test Article - CREATE',
		            'url' => 'https://fmi.uni-sofia.bg',
		            'date_published' => '2017-11-25 10:34:47'
            ]);
    }

    public function testsArticlesAreUpdatedCorrectly()
    {
        $headers = [];
        $article = factory(Article::class)->create([
            'title' => 'Test Article - UPDATE',
            'description' => 'Test Article - UPDATE',
            'url' => 'https://fmi.uni-sofia.bg',
            'date_published' => '2017-11-25 10:34:47'
        ]);

        $payload = [
            'title' => 'Test Article - UPDATED',
            'description' => 'Test Article - UPDATED',
            'url' => 'https://fmi.uni-sofia.bg',
            'date_published' => '2017-11-25 10:34:47'
        ];

        $response = $this->json('PUT', '/api/articles/' . $article->id, $payload, $headers)
            ->assertStatus(200)
            ->assertJson([
                'id' => $article->id,
              	'title' => 'Test Article - UPDATED',
            		'description' => 'Test Article - UPDATED',
            		'date_published' => '2017-11-25 10:34:47'
            ]);
    }

    public function testsArticlesAreDeletedCorrectly()
    {
        $headers = [];
        $article = factory(Article::class)->create([
            'title' => 'Test Article - DELETE',
            'description' => 'Test Article - DELETE',
            'url' => 'https://fmi.uni-sofia.bg',
            'date_published' => '2017-11-25 10:34:47'
        ]);

        $this->json('DELETE', '/api/articles/' . $article->id, [], $headers)
            ->assertStatus(204);
    }

    public function testArticlesAreListedCorrectly()
    {
        factory(Article::class)->create([
            'title' => 'First Test Article',
            'description' => 'First Test Article',
            'url' => 'https://fmi.uni-sofia.bg/article1/',
            'date_published' => '2017-11-25 10:34:47'
        ]);

        factory(Article::class)->create([
            'title' => 'Second Test Article',
            'description' => 'Second Test Article',
            'url' => 'https://fmi.uni-sofia.bg/article2/',
            'date_published' => '2017-11-25 10:34:47'
        ]);

        $headers = [];

        $response = $this->json('GET', '/api/articles', [], $headers)
            ->assertStatus(200)
            ->assertJson([
                [ 'title' => 'First Test Article', 'description' => 'First Test Article', 'url' => 'https://fmi.uni-sofia.bg/article1/' ],
                [ 'title' => 'Second Test Article', 'description' => 'Second Test Article', 'url' => 'https://fmi.uni-sofia.bg/article2/' ]
            ])
            ->assertJsonStructure([
                '*' => ['id', 'title', 'description', 'url', 'date_published', 'created_at', 'updated_at'],
            ]);
    }
}
