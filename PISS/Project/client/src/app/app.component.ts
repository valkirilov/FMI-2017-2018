import { Component, OnInit, ViewContainerRef } from '@angular/core';
import { Router } from '@angular/router';

import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ToastsManager } from 'ng2-toastr/ng2-toastr';

import { Observable } from 'rxjs/Observable';
import { Subscription }   from 'rxjs/Subscription';
import 'rxjs/add/operator/filter';
import 'rxjs/add/observable/forkJoin';

//import { RootService } from './core/root.service';
import { ArticleService } from './articles/article.service';
import { CategoryService } from './articles/category.service';

import { Article } from './models/article.model';
import { Category } from './models/category.model';

import { environment } from './../environments/environment';

@Component({
  selector: 'my-app',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  providers: [ArticleService]
})
export class AppComponent implements OnInit {

  categories: Array<Category> = [];

  config = {
    env: environment
  };

  constructor(
    //private rootService: RootService,
    private articleService: ArticleService,
    private categoryService: CategoryService,
    private router: Router,
    private modalService: NgbModal,
    private toastr: ToastsManager,
    private vcr: ViewContainerRef) {
    this.toastr.setRootViewContainerRef(vcr);
  }

  ngOnInit() {
    let getCategories = this.categoryService.getCategories();

    Observable.forkJoin([        getCategories
      ])
      .subscribe(
        response => {
          this.categories = response[0];

          // Check for query params which are already in the URL
          //this.handleQueryParamsFilters(this.route.snapshot.queryParams);
        },
        error => this.toastr.error(error, 'Error!', { positionClass: 'toast-bottom-right' })
      );
  }

  openAddTimeReportModal() {
  }


}
