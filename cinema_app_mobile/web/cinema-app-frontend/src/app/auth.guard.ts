import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { AdminService } from './admin.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate  {
  constructor(private readonly adminService:AdminService , private router:Router){}
  canActivate():boolean{
    console.log(this.adminService.loggedIn)
     if(this.adminService.loggedIn())
     {
       return true;
     }else{
      this.router.navigate(['/Mdd1TiDl0eLaZTKaJNxKUQ']);
      return false;
     }
  }
  
}
