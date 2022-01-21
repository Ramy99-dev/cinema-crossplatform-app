import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';

import { Category } from '../entities/Category';
import { Movie } from '../entities/Movie';
import { CategoryService } from '../services/category.service';
import { MovieService } from '../services/movie-service.service';


@Component({
  selector: 'add-movie',
  templateUrl: './add-movie.component.html',
  styleUrls: ['./add-movie.component.scss']
})
export class AddMovieComponent implements OnInit {
  image?: File;
  categories?:Category[] =[];
  @Output() sendDataToMovieParent: EventEmitter<Movie> = new EventEmitter();
  movieForm: FormGroup;
  constructor(private readonly categoryService:CategoryService,private readonly movieService: MovieService, private formBuilder: FormBuilder) {
    this.movieForm = this.formBuilder.group({
      title: new FormControl('',Validators.required),
      time: new FormControl('',Validators.required),
      director: new FormControl('',Validators.required),
      description: new FormControl('',Validators.required),
      category: new FormControl('',Validators.required),
      price: new FormControl('',Validators.required),
      img:new FormControl('',Validators.required),
      nbr:new FormControl('',Validators.required),
      date:new FormControl('',Validators.required)
    })
  }

  ngOnInit(): void {
    this.categoryService.getCategory().subscribe((result)=>{
      this.categories = [...result]
    })
  }

  addMovie(): void {
    console.log("test")
    console.log(this.movieForm.value)
    let movie: Movie = new Movie();
    movie.titre = this.movieForm.value.title;
    movie.duree = this.movieForm.value.time;
    movie.realisateur = this.movieForm.value.director;
    movie.description = this.movieForm.value.description;
    movie.categorie = this.movieForm.value.category;
    movie.prix = this.movieForm.value.price;
    movie.img=this.movieForm.value.img
    movie.nbr=this.movieForm.value.nbr
    movie.date = this.movieForm.value.date
    
    let fd = new FormData();
    if (this.image) {
      fd.append('image', this.image, this.image.name)

      this.movieService.addMovieBanner(fd).subscribe((result) => {
      })

      this.movieService.addMovie(movie).subscribe((result) => {
      })


    }
  }

  

  fileChoosen(event: any) {
    if (event.target.value) {
      this.image = <File>event.target.files[0];

    }
  }

}
