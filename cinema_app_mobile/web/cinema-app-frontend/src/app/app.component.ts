import { Component, OnInit } from '@angular/core';
import {  ActivationEnd, Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'cinema-app-frontend';
  currentComponent : string ="";
  showsidebar? : boolean =true; 
  constructor(private router: Router) {
    router.events.subscribe((val) => {
        if (val instanceof ActivationEnd) {
          this.currentComponent =  val.snapshot.component['name'];
          console.log(this.currentComponent)
          if(this.currentComponent =="LoginComponent" )
          {
              this.showsidebar = false;
          }
          else{
            this.showsidebar = true;
          }

          console.log(this.showsidebar)
        }
    });
}
}
