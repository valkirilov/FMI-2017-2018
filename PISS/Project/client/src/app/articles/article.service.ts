
import { Injectable } from '@angular/core';
import { Http, Response, Headers, RequestOptions } from '@angular/http';

import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';
import 'rxjs/add/observable/throw';

import { environment } from './../../environments/environment';

import { Article } from './../models/article.model';

@Injectable()
export class ArticleService {
  private getUrl = environment.apiUrl + 'articles';

  constructor (private http: Http) {}

  getArticles(params: any): Observable<Article[]> {
    let apiUrl = this.getUrl;
    let headers = new Headers({
      'Content-Type': 'application/json',
    });
    let options = new RequestOptions({
      headers: headers,
      params: params
    });

    return this.http.get(apiUrl, options)
                    .map(this.extractArticlesData)
                    .catch(this.handleError);
  }

  getArticle(id: number): Observable<Article> {
    let apiUrl = this.getUrl + '/' + id + '/';
    let headers = new Headers({
      'Content-Type': 'application/json',
    });
    let options = new RequestOptions({
      headers: headers
    });

    return this.http.get(apiUrl, options)
                    .map(this.extractArticleData)
                    .catch(this.handleError);
  }

  // Helper methods

  /**
   * Extract the body data from the response and serialize it
   * @param {Response} res HttpResponse object
   */
  private extractArticlesData(res: Response) {
    let body = res.json();

    if (body.data !== undefined) {
      return body.data || {};
    }
    else {
      return body || {};
    }
  }

   /**
   * Extract the body data from the response and serialize it
   * @param {Response} res HttpResponse object
   */
  private extractArticleData(res: Response) {
    let body = res.json();

    return body || {};
  }

  /**
   * Extract the error message from the response
   * @param {Response | any} error [description]
   */
  private handleError (error: Response | any) {
    let errMsg: string;
    if (error instanceof Response) {
      const body = error.json() || '';
      const err = body.error || JSON.stringify(body);
      errMsg = `${error.statusText || ''} ${err}`;
    } else {
      errMsg = error.message ? error.message : error.toString();
    }
    console.error(errMsg);
    if (errMsg === '{"isTrusted":true}') {
      return Observable.throw('Could\'t fetch Articles data from the server.');
    }
    return Observable.throw(errMsg);
  }
}
