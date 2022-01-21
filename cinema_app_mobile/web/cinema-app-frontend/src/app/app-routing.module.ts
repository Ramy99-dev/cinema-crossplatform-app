import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AddMovieComponent } from './add-movie/add-movie.component';
import { AuthGuard } from './auth.guard';
import { CategoryComponent } from './category/category.component';
import { DahsboardComponent } from './dahsboard/dahsboard.component';
import { LoginComponent } from './login/login.component';
import { MovieComponent } from './movie/movie.component';
import { ReservationsComponent } from './reservations/reservations.component';
import { UserReservationComponent } from './user-reservation/user-reservation.component';
import { UsersComponent } from './users/users.component';

const routes: Routes = [
  {
    path:'movie' , component:MovieComponent,canActivate :[AuthGuard]
  },
  {
    path:'' , redirectTo:'/DahsboardComponent', pathMatch: 'full'
  },
  {
    path:'category' , component:CategoryComponent,canActivate :[AuthGuard]
  },
  {
    path:'dashboard' , component:DahsboardComponent,canActivate :[AuthGuard]
  },
  {
    path:'users' , component:UsersComponent 
  },
  {
    path:'reservations' , component:ReservationsComponent 
  },
  {
    path:'user-reservations/:id' , component:UserReservationComponent 
  },
  {
    path:'Mdd1TiDl0eLaZTKaJNxKUQ' , component:LoginComponent 
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
