# Import flask dependencies
from flask import Blueprint, request, render_template, redirect

# Define the blueprint: 'auth', set its url prefix: app.url/auth
from app.article.services.article_service import ArticleService

article_mod = Blueprint(
    'article_mod',
    __name__,
    template_folder='templates'
)


# Set the route and accepted methods
@article_mod.route('/')
def articles():
    category_id = request.args.get('category', None)
    article_service = ArticleService()
    if category_id:
        all_articles = article_service.get_articles({
            'category_id': category_id
        })
    else:
        all_articles = article_service.get_articles()

    context = {
        'categories': article_service.get_categories(),
        'media_url': article_service.media_url,
        'articles': all_articles,
        'latest_articles': article_service.get_articles({
            'count': 15,
            'orderBy': 'date_published',
            'orderDirection': 'desc'
        }),
        'most_viewed_articles': article_service.get_articles({
            'count': 15
        })
    }
    return render_template('article/list.html', context=context)


@article_mod.route('/article/<int:article_id>')
def article(article_id):
    article_service = ArticleService()
    context = {
        'article': article_service.get_article(article_id),
        'media_url': article_service.media_url,
        'suggested_articles': article_service.get_articles({
            'count': 3
        })
    }
    return render_template('article/single.html', context=context)
