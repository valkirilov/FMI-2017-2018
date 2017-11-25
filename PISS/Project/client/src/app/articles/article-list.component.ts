
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

import { Article } from './../models/article.model';

import { environment } from './../../environments/environment';

@Component({
  templateUrl: './article-list.component.html',
  styleUrls: ['./article-list.component.css']
})
export class ArticleListComponent implements OnInit, OnDestroy {

  articles: Array<Article> = [];

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

    let getArticles = this.articleService.getArticles();

    Observable.forkJoin([getArticles])
              .subscribe(
                response => {
                  this.articles = response[0];

                  // Check for query params which are already in the URL
                  //this.handleQueryParamsFilters(this.route.snapshot.queryParams);
                },
                error => this.toastr.error(error, 'Error!', { positionClass: 'toast-bottom-right' })
              );

    // this.routerSubscriber = this.router.events.subscribe(
    //                                             event => {
    //                                               if (event instanceof NavigationEnd) {
    //                                                 let params = this.route.snapshot.queryParams;
    //                                                 this.handleQueryParamsFilters(params);
    //                                               }
    //                                             }
    //                                           );

    // this.timeReportsSubscription = this.timeReportsService.refreshTimeReportsSource$
    //                                                       .subscribe(response => this.getTimeReportsData());
  }

  ngOnDestroy() {
    // this.routerSubscriber.unsubscribe();
  }

  /**
   * Apply the query params to the filters form and forche new fetch of the data
   * @param {any} params [description]
   */
  // handleQueryParamsFilters(params: any) {
  //   if (params.fromDate) {
  //     this.listTimeReportsForm.patchValue({ fromDate: this.dateToNgbStruct(params.fromDate) });
  //   }

  //   if (params.toDate) {
  //     this.listTimeReportsForm.patchValue({ toDate: this.dateToNgbStruct(params.toDate) });
  //   }

  //   if (params.project) {
  //     this.listTimeReportsForm.patchValue({ project: params.project });
  //   }

  //   if (params.profile) {
  //     this.listTimeReportsForm.patchValue({ profile: params.profile });
  //   }

  //   // Get time reports data according to the filters above
  //   this.getTimeReportsData();

  //   // Open a modal with info about the time report if provided
  //   if (params.report) {
  //     const modalRef = this.modalService.open(ViewTimeReportComponent);
  //     modalRef.componentInstance.timeReportId = params.report;

  //     modalRef.result.then(
  //                      result => {
  //                        var queryParams = Object.assign({}, this.route.snapshot.queryParams);
  //                        delete queryParams.report;
  //                        this.router.navigate(['/time-reports'], { queryParams: queryParams });
  //                      },
  //                      reason =>{
  //                        var queryParams = Object.assign({}, this.route.snapshot.queryParams);
  //                        delete queryParams.report;
  //                        this.router.navigate(['/time-reports'], { queryParams: queryParams });
  //                      }
  //                    );
  //   }
  // }

}
