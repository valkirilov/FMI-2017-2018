import { Component, OnInit, ViewContainerRef } from '@angular/core';
import { Router } from '@angular/router';

import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ToastsManager } from 'ng2-toastr/ng2-toastr';

//import { RootService } from './core/root.service';
import { ArticleService } from './articles/article.service';

import { environment } from './../environments/environment';

@Component({
  selector: 'my-app',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  providers: [ArticleService]
})
export class AppComponent implements OnInit {

  config = {
    env: environment
  };

  constructor(
    //private rootService: RootService,
    private articleService: ArticleService,
    private router: Router,
    private modalService: NgbModal,
    private toastr: ToastsManager,
    private vcr: ViewContainerRef) {
    this.toastr.setRootViewContainerRef(vcr);
  }

  ngOnInit() {

  }

  openAddTimeReportModal() {
  }


}
