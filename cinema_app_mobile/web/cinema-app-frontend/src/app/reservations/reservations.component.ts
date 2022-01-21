import { Component, OnInit, ViewChild,ElementRef } from '@angular/core';
import { Router } from '@angular/router';
import {jsPDF} from 'jspdf';


import { Reservation } from '../entities/Reservation';
import { ReservationService } from '../services/reservation.service';

@Component({
  selector: 'app-reservations',
  templateUrl: './reservations.component.html',
  styleUrls: ['./reservations.component.scss']
})
export class ReservationsComponent implements OnInit {
  reservations : Reservation[] =[];
  @ViewChild('pdfTable', {static: false}) pdfTable?: ElementRef;
  constructor(private readonly reservationService : ReservationService , private readonly router:Router) { }

  ngOnInit(): void {
    this.reservationService.getAllReservation().subscribe((result:Reservation[])=>{
      this.reservations= result;

      this.reservations.map((reservation)=>{
     
        reservation.idMovie!.date =  new Date(reservation.idMovie!.date!).toISOString().split('T')[0]
    
       })
    })
  }

  savePdf() {
    const doc = new jsPDF('p', 'px', 'letter');

    doc.setFontSize(22);


    const pdfTable = this.pdfTable!.nativeElement;

    doc.html(pdfTable.innerHTML,  {
      callback: function (doc) {
        doc.save('tableToPdf.pdf');
      }});

    

  }

  getUserDetails(id:string)
  {
    //console.log(username)
    this.router.navigate(['/user-reservations', id]);
  }

}
