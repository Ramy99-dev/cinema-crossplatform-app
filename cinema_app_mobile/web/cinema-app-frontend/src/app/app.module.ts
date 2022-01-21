import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { AddMovieComponent } from './add-movie/add-movie.component';
import { MovieComponent } from './movie/movie.component';
import { FormsModule , ReactiveFormsModule  } from '@angular/forms';

import { DialogModule } from '@ngneat/dialog';
import { EditMovieComponent } from './edit-movie/edit-movie.component';
import { CategoryComponent } from './category/category.component';
import { AddCategoryComponent } from './add-category/add-category.component';
import { EditCategoryComponent } from './edit-category/edit-category.component';
import { DahsboardComponent } from './dahsboard/dahsboard.component';
import { ChartComponent } from './chart/chart.component';
import { ChartsModule } from 'ng2-charts';
import { UserService } from './services/user.service';
import { SideBarComponent } from './side-bar/side-bar.component';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { LoginComponent } from './login/login.component';
import { AuthGuard } from './auth.guard';
import { AuthInterceptor } from './auth.interceptor';
import { UsersComponent } from './users/users.component';
import { MovieService } from './services/movie-service.service';
import { CategoryService } from './services/category.service';
import { ReservationsComponent } from './reservations/reservations.component';
import { UserReservationComponent } from './user-reservation/user-reservation.component';


@NgModule({
  declarations: [
    AppComponent,
    AddMovieComponent,
    MovieComponent,
    EditMovieComponent,
    CategoryComponent,
    AddCategoryComponent,
    EditCategoryComponent,
    DahsboardComponent,
    ChartComponent,
    SideBarComponent,
    LoginComponent,
    UsersComponent,
    ReservationsComponent,
    UserReservationComponent,
 
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    ReactiveFormsModule ,
    FontAwesomeModule,
    ChartsModule,
    DialogModule.forRoot({
      sizes: {
        sm: {
          width: 300, // 300px
          minHeight: 250 // 250px
        },
        md: {
          width: '30vw',
          height: '90vh'
        },
        lg: {
          width: '90vw',
          height: '90vh'
        },
        fullScreen: {
          width: '100vw',
          height: '100vh'
        },
        stretch: {
          minHeight: 500,
          maxHeight: '85%'
        }
      }
    }),
    FontAwesomeModule
  ],
  providers: [MovieService,CategoryService , UserService , AuthGuard , {
    provide:HTTP_INTERCEPTORS,
    useClass:AuthInterceptor,
    multi:true
   }],
  bootstrap: [AppComponent]
})
export class AppModule { }
