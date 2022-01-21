import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { DialogRef } from '@ngneat/dialog';


import { Movie } from '../entities/Movie';
import { CategoryService } from '../services/category.service';
import { MovieService } from '../services/movie-service.service';


@Component({
  selector: 'app-edit-movie',
  templateUrl: './edit-movie.component.html',
  styleUrls: ['./edit-movie.component.scss']
})
export class EditMovieComponent implements OnInit {
  categ :Array<string> = [];
  movie:Movie = new Movie();
  image?: File;
  @Output() sendDataToMovieParent: EventEmitter<Movie> = new EventEmitter();
  movieForm: FormGroup;
  constructor(public ref: DialogRef,private readonly movieService: MovieService, private formBuilder: FormBuilder , private readonly categService:CategoryService) {
    this.movieForm = this.formBuilder.group({
      id:new FormControl("",Validators.required),
      title: new FormControl("",Validators.required),
      time: new FormControl("",Validators.required),
      director: new FormControl("",Validators.required),
      description: new FormControl("",Validators.required),
      category: new FormControl('',Validators.required),
      price: new FormControl("",Validators.required),
      img:new FormControl('',Validators.required),
      date:new FormControl('',Validators.required),
      nbr:new FormControl('',Validators.required)
    })
  }

  ngOnInit(): void {


   let id =  this.ref.data.id;

   this.categService.getCategory().subscribe((result)=>{
     result.map((e:any)=>{
       this.categ.push(e.nom);
     })
     console.log(this.categ)
   })

   this.movieService.getSingleMovie(id).subscribe((result)=>{
 
    console.log(result._id)
    console.log(result.titre)
     this.movie._id= result._id;
     this.movie.titre = result.titre;
     this.movie.duree = result.duree;
     this.movie.description = result.description;
     this.movie.realisateur=result.realisateur;
     this.movie.prix=result.prix;
     this.movie.img = result.img;
     this.movie.nbr = result.nbr;
     this.movie.date = result.date;
     this.movie.categorie=result.categorie;

   })


  }

  addMovie(): void {
    console.log(this.movieForm.value)
    let movie: Movie = new Movie();
    movie.titre = this.movieForm.value.title;
    movie.duree = this.movieForm.value.time;
    movie.realisateur = this.movieForm.value.director;
    movie.description = this.movieForm.value.description;
    movie.categorie = this.movieForm.value.category;
    movie.nbr = this.movieForm.value.nbr;
    movie.date = this.movieForm.value.date;
    this.movieForm ? movie.img = this.movieForm.value.img : movie.img = this.movie.img;
  
    movie.prix = this.movieForm.value.price;
    this.movieService.updateMovie(this.movie._id!,movie).subscribe((result) => {
      console.log(result)
    })
    let fd = new FormData();
    if (this.image) {
      fd.append('image', this.image, this.image.name)

      this.movieService.addMovieBanner(fd).subscribe((result) => {
      })

     


    }
  }

  

  fileChoosen(event: any) {
    if (event.target.value) {
      this.image = <File>event.target.files[0];

    }
  }

}
