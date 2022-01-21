import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { faChartPie ,faFilm , faVideo ,faSignOutAlt , faUser , faCalendarAlt} from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'side-bar',
  templateUrl: './side-bar.component.html',
  styleUrls: ['./side-bar.component.scss']
})
export class SideBarComponent implements OnInit {
  faChartPie = faChartPie;
  faFilm = faFilm;
  faVideo = faVideo;
  faSignOutAlt=faSignOutAlt;
  faUser =  faUser;
  faCalendarAlt = faCalendarAlt;
  constructor(private router:Router) { }

  ngOnInit(): void {
  }

  logout()
  {
    localStorage.clear();
    this.router.navigate(['/Mdd1TiDl0eLaZTKaJNxKUQ']);
  }

}
