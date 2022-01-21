import { Component, Input, OnInit } from '@angular/core';
import { ChartType } from 'chart.js';
import { MovieService } from '../services/movie-service.service';

import { UserService } from '../services/user.service';

@Component({
  selector: 'chart',
  templateUrl: './chart.component.html',
  styleUrls: ['./chart.component.scss']
})
export class ChartComponent implements OnInit {
 
  @Input() pct?: string;
  public data:number[] = [];
  public pieChartLabels:string[] = [];
  public pieChartData:any = [
    {
      label: 'My First Dataset',
      data: [],
      backgroundColor: []
    }
  ]
 
  public pieChartType:ChartType = 'pie';
  constructor(private movieService:MovieService , private userService:UserService) { }
  ngOnInit() {
    if(this.pct == 'movie')
    {
     
      this.movieService.statsMovieByCategories().subscribe((result)=>{
        console.log(result)
   
          for (let res in result) {  
            this.data.push(result[res].nbr)
            this.pieChartData[0].backgroundColor.push(this.getRandomRgb())
            this.pieChartLabels.push(result[res]._id )          
          } 
          this.pieChartData[0].data =[... this.data];
        
      })
    }
    else if(this.pct =="user")
    {
     
      this.userService.statsUserByGender().subscribe((result)=>{
        console.log(result)
          for (let res in result) {  
            this.data.push(result[res].nbr)
            this.pieChartData[0].backgroundColor.push(this.getRandomRgb())
            this.pieChartLabels.push(result[res]._id)
          }     
          this.pieChartData[0].data =[... this.data];
          console.log(this.pieChartData)
        
      })
    }
  }

   getRandomRgb() {
    var num = Math.round(0xffffff * Math.random());
    var r = num >> 16;
    var g = num >> 8 & 255;
    var b = num & 255;
    return 'rgb(' + r + ', ' + g + ', ' + b + ')';
  }

}
