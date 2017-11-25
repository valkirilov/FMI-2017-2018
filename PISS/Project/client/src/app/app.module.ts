import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule, ReactiveFormsModule }    from '@angular/forms';
import { HttpModule, JsonpModule } from '@angular/http';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { ToastModule } from 'ng2-toastr/ng2-toastr';

import { AppComponent }  from './app.component';

import { AppRoutingModule } from './app-routing.module';
//import { CoreModule }       from './core/core.module';
//import { SharedModule }       from './shared/shared.module';
//import { AuthModule }     from './auth/auth.module';
import { ArticleModule }     from './articles/article.module';

@NgModule({
  imports: [
    BrowserModule,
    BrowserAnimationsModule,

    FormsModule,
    ReactiveFormsModule,

    HttpModule,
    JsonpModule,
    NgbModule.forRoot(),
    ToastModule.forRoot(),

    //CoreModule,
    //SharedModule,
    //AuthModule,
    ArticleModule,
    AppRoutingModule
  ],
  declarations: [
    AppComponent,
    //AddTimeReportComponent,
  ],
  entryComponents: [
  ],
  bootstrap: [
    AppComponent
  ]
})
export class AppModule { }
