import requests


class ArticleService:
    def __init__(self):
        self.media_url = 'http://fmipiss.server/storage/images/'
        self.api_url = 'http://fmipiss.server/api'

    def get_categories(self):
        endpoint = self.api_url + '/categories'
        r = requests.get(endpoint)
        return r.json()

    def get_articles(self, params=()):
        endpoint = self.api_url + '/articles'
        r = requests.get(endpoint, params)
        return r.json()

    def get_article(self, article_id, params=()):
        endpoint = self.api_url + '/articles/' + str(article_id) + '/'
        r = requests.get(endpoint, params)
        return r.json()
