import { Component, OnInit } from '@angular/core';
import { Reservation } from '../entities/Reservation';
import { ReservationService } from '../services/reservation.service';
import {jsPDF} from 'jspdf';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-user-reservation',
  templateUrl: './user-reservation.component.html',
  styleUrls: ['./user-reservation.component.scss']
})
export class UserReservationComponent implements OnInit {
  reservations : Reservation[] =[];
  constructor(private readonly reservationService:ReservationService,private route:ActivatedRoute) { }

  ngOnInit(): void {
    let id = this.route.snapshot.params['id'];
    console.log(id)
   this.reservationService.getUserReservation(id).subscribe((result)=>{
    this.reservations= result;

    this.reservations.map((reservation)=>{
   
      reservation.idMovie!.date =  new Date(reservation.idMovie!.date!).toISOString().split('T')[0]
  
     })
   })
    
  }
  

}
