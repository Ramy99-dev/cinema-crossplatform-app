import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Category } from '../entities/Category';

@Injectable({
  providedIn: 'root'
})
export class CategoryService {

  constructor(private _http:HttpClient) { }

  addCategory(category:Category):Observable<Category>
  {
    return this._http.post("http://localhost:3000/categorie/",category);
  }
  editCategory(id:string,category:Category):Observable<Category>
  {
    return this._http.put(`http://localhost:3000/categorie/${id}`,category);
  }

  getCategory():Observable<any>
  {
    return this._http.get("http://localhost:3000/categorie/all");
  }
  getSingleCategory(id:string):Observable<Category>
  {
    return this._http.get(`http://localhost:3000/categorie/${id}`);
  }

  delete(id:string):Observable<Category>
  {
    return this._http.delete(`http://localhost:3000/categorie/${id}`);
  }

  getCategoryNumber():Observable<any>
 {
   return this._http.get("http://localhost:3000/categorie/number")
 }

}
