
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

//import { AddTimeReportComponent } from './../time-reports/add-time-report.component';
//import { ViewTimeReportComponent } from './../time-reports/view-time-report.component';

//import { RootService } from './../core/root.service';
import { ArticleService } from './article.service';
import { CategoryService } from './category.service';

import { Article } from './../models/article.model';
import { Category } from './../models/category.model';

import { environment } from './../../environments/environment';

@Component({
  templateUrl: './article-list.component.html',
  styleUrls: ['./article-list.component.css']
})
export class ArticleListComponent implements OnInit, OnDestroy {

  articles: Array<Article> = [];
  latestArticles: Array<Article> = [];
  mostViewedArticles: Array<Article> = [];

  config = {
    pageTitle: 'Articles',
    env: environment
  };

  routerSubscriber;
  articlesSubscription: Subscription;

  isLoading = {
    articles: false,
  }

  constructor(
    //private rootService: RootService,
    private articleService: ArticleService,
    private categoryService: CategoryService,
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

    let getArticles = this.articleService.getArticles({ paginate: true });
    let getLatestArticles = this.articleService.getArticles({ count: 15, orderBy: 'date_published', orderDirection: 'desc' });
    let getMostViewedArticles = this.articleService.getArticles({ count: 15 });

    Observable.forkJoin([
        getArticles,
        getLatestArticles,
        getMostViewedArticles,
      ])
      .subscribe(
        response => {
          this.articles = response[0];
          this.latestArticles = response[1];
          this.mostViewedArticles = response[2];

          // Check for query params which are already in the URL
          this.handleQueryParamsFilters(this.route.snapshot.queryParams);
        },
        error => this.toastr.error(error, 'Error!', { positionClass: 'toast-bottom-right' })
      );

    this.routerSubscriber = this.router.events.subscribe(
      event => {
        if (event instanceof NavigationEnd) {
          let params = this.route.snapshot.queryParams;
          this.handleQueryParamsFilters(params);
        }
      }
    );

    // this.timeReportsSubscription = this.timeReportsService.refreshTimeReportsSource$
    //                                                       .subscribe(response => this.getTimeReportsData());
  }

  ngOnDestroy() {
    this.routerSubscriber.unsubscribe();
  }

  /**
   * Apply the query params to the filters form and forche new fetch of the data
   * @param {any} params [description]
   */
  handleQueryParamsFilters(params: any) {
    // Get time reports data according to the filters above
    this.getArtclesData(params);
  }

    /**
   * Get the stored data in the filters form and request data according to it
   */
  getArtclesData(params) {
    this.articleService.getArticles(params)
      .subscribe(
        articles => {
          this.articles = articles;
        },
        error => this.toastr.error(error, 'Error!', { positionClass: 'toast-bottom-right' })
      );
  }

}
