import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Movie } from '../entities/Movie';

@Injectable({
  providedIn: 'root'
})
export class MovieService {

  constructor(private _http:HttpClient) { }
  
  addMovieBanner(fd:FormData):Observable<Movie>
  {
    return this._http.post("http://localhost:3000/movies/upload",fd);
  }
  addMovie(movie:Movie):Observable<Movie>
  {
    return this._http.post("http://localhost:3000/movies/",movie);
  }
  updateMovie(id:string , movie:Movie):Observable<Movie>
  {
    return this._http.put(`http://localhost:3000/movies/update/${id}`,movie);
  }
  getMovie():Observable<Movie[]>
  {
    return <Observable<Movie[]>> this._http.get("http://localhost:3000/movies/all");
  }
  getSingleMovie(id:string):Observable<Movie>
  {
    return this._http.get(`http://localhost:3000/movies/${id}`);
  }
  delete(id:string):Observable<Movie>
  {
    return this._http.delete(`http://localhost:3000/movies/${id}`);
  }

 statsMovieByCategories():Observable<any>
 {
  return this._http.get("http://localhost:3000/movies/pct");
 }

 getMoviesNumber():Observable<any>
 {
   return this._http.get("http://localhost:3000/movies/number")
 }


}
