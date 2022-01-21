import { Component, OnInit } from '@angular/core';
import { ChartType } from 'chart.js';
import { CategoryService } from '../services/category.service';
import { MovieService } from '../services/movie-service.service';

import { UserService } from '../services/user.service';

@Component({
  selector: 'app-dahsboard',
  templateUrl: './dahsboard.component.html',
  styleUrls: ['./dahsboard.component.scss']
})
export class DahsboardComponent implements OnInit {
  number : any =  {};
  constructor(private movieService:MovieService , private userService:UserService ,private categoryService:CategoryService ){}

  ngOnInit(): void {
   this.movieService.getMoviesNumber().subscribe((result)=>{
     this.number.movies = result.number;

   })
   this.userService.getUsersNumber().subscribe((result)=>{
     this.number.users=  result.number;
   })
   this.categoryService.getCategoryNumber().subscribe((result)=>{
    this.number.categories=  result.number;
  })

  }

  
}
