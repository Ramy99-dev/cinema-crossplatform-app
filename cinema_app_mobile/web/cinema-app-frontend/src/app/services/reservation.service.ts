import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Reservation } from '../entities/Reservation';

@Injectable({
  providedIn: 'root'
})
export class ReservationService {

  constructor(private _http:HttpClient) { }

  getAllReservation():Observable<Reservation[]>{
    return  <Observable<Reservation[]>> this._http.get("http://localhost:3000/reservation/all");
  }

  deleteReservation():Observable<any>{
    return this._http.delete("http://localhost:3000/reservation/all")
  }

  getUserReservation(username:string):Observable<Reservation[]>{
    return  <Observable<Reservation[]>> this._http.get(`http://localhost:3000/reservation/userReservationByUsername/${username}`);
  }
}
