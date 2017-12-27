
import { Component, OnInit, OnDestroy, ViewContainerRef } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Router, ActivatedRoute, NavigationEnd } from '@angular/router';
import { Title } from '@angular/platform-browser';

import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ToastsManager } from 'ng2-toastr/ng2-toastr';
import * as moment from 'moment';

import { Observable } from 'rxjs/Observable';
import { Subscription }   from 'rxjs/Subscription';
import 'rxjs/add/operator/filter';
import 'rxjs/add/observable/forkJoin';

import { ArticleService } from './article.service';

import { Article } from './../models/article.model';

import { environment } from './../../environments/environment';

@Component({
  templateUrl: './article-view.component.html',
  styleUrls: ['./article-view.component.css']
})
export class ArticleViewComponent implements OnInit, OnDestroy {

  article: Article;
  suggestedArticles: Array<Article> = [];

  config = {
    pageTitle: 'Article',
    env: environment
  };

  routerSubscriber;

  isLoading = {
    articles: false,
  }

  constructor(
    //private rootService: RootService,
    private articleService: ArticleService,
    private toastr: ToastsManager,
    private vcr: ViewContainerRef,
    private modalService: NgbModal,
    private router: Router,
    private route: ActivatedRoute,
    private titleService: Title) {

    this.toastr.setRootViewContainerRef(vcr);
  }

  ngOnInit() {
    this.titleService.setTitle(`${this.config.pageTitle} - ${this.config.env.website.title}`);

    this.routerSubscriber = this.route.params.subscribe(params => {
      let articleId = +params['id'];

      let getArticle = this.articleService.getArticle(articleId);
      let getSuggestedArticles = this.articleService.getArticles({ count: 3 });

      Observable.forkJoin([
          getArticle,
        ])
        .subscribe(
          response => {
            this.article = response[0];
          },
          error => this.toastr.error(error, 'Error!', { positionClass: 'toast-bottom-right' })
        );

      Observable.forkJoin([
          getSuggestedArticles
        ])
        .subscribe(
          response => {
            this.suggestedArticles = response[0];
          },
          error => this.toastr.error(error, 'Error!', { positionClass: 'toast-bottom-right' })
        );
    });

  }

  ngOnDestroy() {
    this.routerSubscriber.unsubscribe();
  }

}
