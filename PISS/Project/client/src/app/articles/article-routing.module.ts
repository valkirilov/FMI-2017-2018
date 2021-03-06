import { NgModule }             from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { ArticleListComponent }    from './article-list.component';
import { ArticleViewComponent }    from './article-view.component';

//import { AuthGuard }                from './../guards/auth-guard.service';

const articleRoutes: Routes = [
  { path: 'articles', component: ArticleListComponent },
  { path: 'article/:id', component: ArticleViewComponent },
];

@NgModule({
  imports: [
    RouterModule.forChild(articleRoutes)
  ],
  exports: [
    RouterModule
  ]
})
export class ArticleRoutingModule { }
