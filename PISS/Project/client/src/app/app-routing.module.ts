import { NgModule }              from '@angular/core';
import { RouterModule, Routes }  from '@angular/router';

const appRoutes: Routes = [
  { path: '', redirectTo: '/articles', pathMatch: 'full' },
  { path: '**', redirectTo: '/not-found' },
];

@NgModule({
  imports: [
    RouterModule.forRoot(
      appRoutes,
      { enableTracing: false } // <-- debugging purposes only
    )
  ],
  exports: [
    RouterModule
  ]
})
export class AppRoutingModule {}
