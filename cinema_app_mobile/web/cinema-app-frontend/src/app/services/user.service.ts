import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { User } from '../entities/User';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private _http:HttpClient) { }

  statsUserByGender():Observable<any>
 {
  return this._http.get("http://localhost:3000/users/pct");
 }

 getUsersNumber():Observable<any>
 {
   return this._http.get("http://localhost:3000/users/number")
 }
 getAllUsers():Observable<User[]>
 {
   return <Observable<User[]>> this._http.get("http://localhost:3000/users/all");
 }

 delete(id:string):Observable<any>
 {
   return this._http.delete(`http://localhost:3000/users/${id}`)
 }

}
