import { NgModule }       from '@angular/core';
import { CommonModule, SlicePipe }   from '@angular/common';
import { FormsModule, ReactiveFormsModule }    from '@angular/forms';

import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { MomentModule } from 'angular2-moment';

//import { SharedModule }       from './../shared/shared.module';
import { ArticleListComponent }    from './article-list.component';

import { ArticleService }     from './article.service';

import { ArticleRoutingModule } from './article-routing.module';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    NgbModule,
    MomentModule,
    //SharedModule,
    ArticleRoutingModule,
  ],
  declarations: [
    ArticleListComponent,
  ],
  providers: [
    ArticleService,
  ]
})
export class ArticleModule {}
