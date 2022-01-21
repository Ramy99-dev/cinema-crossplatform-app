import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AdminService {
 
  constructor(private _http:HttpClient) { }

  login(admin:any):Observable<any>
  {
    return this._http.post("http://localhost:3000/admin/login",admin);
  }
  loggedIn()
  {
    return !!localStorage.getItem('token')
  }
}
