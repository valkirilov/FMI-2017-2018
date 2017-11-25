
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

  getArticles(): Observable<Article[]> {
    let apiUrl = this.getUrl;
    let headers = new Headers({
      'Content-Type': 'application/json',
    });
    let options = new RequestOptions({ headers: headers });

    return this.http.get(apiUrl, options)
                    .map(this.extractArticlesData)
                    .catch(this.handleError);
  }

  // Helper methods

  /**
   * Extract the body data from the response and serialize it
   * @param {Response} res HttpResponse object
   */
  private extractArticlesData(res: Response) {
    let body = res.json();

    // let user: User = new User();

    // if (body) {
    //   user.id = body.id;
    //   user.email = body.email_address;
    //   user.firstName = body.first_name;
    //   user.lastName = body.last_name;
    //   user.jobTitle = body.job_title;
    //   user.phoneNumber = body.phone_number;
    // }

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
