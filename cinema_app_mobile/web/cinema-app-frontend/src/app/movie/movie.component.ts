import { Component, OnInit, Output, ViewChild } from '@angular/core';
import { DialogService } from '@ngneat/dialog';
import { EditMovieComponent } from '../edit-movie/edit-movie.component';

import { Movie } from '../entities/Movie';
import { MovieService } from '../services/movie-service.service';

@Component({
  selector: 'app-movie',
  templateUrl: './movie.component.html',
  styleUrls: ['./movie.component.scss']
})
export class MovieComponent implements OnInit {
  movies:Movie[] =[] ;

  constructor(private readonly movieService:MovieService , private dialog: DialogService) { }

  ngOnInit(): void {
    this.movieService.getMovie().subscribe((result:any)=>{
     this.movies= [...result]
      this.movies.map((movie)=>{
     
       movie.date =  new Date(movie.date!).toISOString().split('T')[0]
       movie.description = movie.description!.slice(1,16) +"...";
      })
    })
  }

  delete(id:string , index:number):void
  {
   
    this.movieService.delete(id).subscribe(()=>{
      this.movies.splice(index,1);
    })
  }

  openEdit(id:string)
  {
    const dialogRef = this.dialog.open(EditMovieComponent,{data:{id}});
    dialogRef.afterClosed$.subscribe(result => {
      this.ngOnInit()
    });
    dialogRef.backdropClick$.subscribe(() => {
      this.ngOnInit()
    });
    
  }

 

}
