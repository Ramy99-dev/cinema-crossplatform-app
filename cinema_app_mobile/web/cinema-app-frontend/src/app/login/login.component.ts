import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { AdminService } from '../admin.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
   public name="login"
   loginForm : FormGroup;
  constructor(private formBuilder:FormBuilder , private readonly adminService : AdminService , private router:Router) {
    this.loginForm = this.formBuilder.group({
      username:new FormControl(''),
      password:new FormControl('')
    })
  }

  ngOnInit(): void {

    if(this.adminService.loggedIn())
    {
      this.router.navigate  (['/dashboard'])
    }
  }
  
  login()
  {
    this.adminService.login(this.loginForm.value).subscribe((result)=>{
      localStorage.setItem("token",result.token)
       
      this.router.navigate(['/dashboard']);
    },(err)=>{
      console.log(err)
    })
  }
}
