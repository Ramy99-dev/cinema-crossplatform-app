import { Component, OnInit } from '@angular/core';
import { User } from '../entities/User';
import { UserService } from '../services/user.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss']
})
export class UsersComponent implements OnInit {
  users : User[] = [];
  constructor(private readonly userService:UserService) { }

  ngOnInit(): void {

    this.userService.getAllUsers().subscribe((result)=>{
      this.users=result;
      console.log(this.users);
      this.users.map((user)=>{
     
        user.date =  new Date(user.date!).toISOString().split('T')[0]
       
       })
    })
    
  }

  delete(id:string , index:number):void
  {
   
    this.userService.delete(id).subscribe(result=>{
      this.users.splice(index,1);
    })
  } 

}
