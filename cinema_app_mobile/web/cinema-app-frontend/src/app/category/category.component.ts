import { Component, OnInit } from '@angular/core';
import { DialogService } from '@ngneat/dialog';

import { EditCategoryComponent } from '../edit-category/edit-category.component';
import { Category } from '../entities/Category';
import { CategoryService } from '../services/category.service';

@Component({
  selector: 'app-category',
  templateUrl: './category.component.html',
  styleUrls: ['./category.component.scss']
})
export class CategoryComponent implements OnInit {
  categories:Category[] =[] ;
  constructor(private readonly categoryService:CategoryService , private dialog: DialogService) { }

  ngOnInit(): void {

    this.categoryService.getCategory().subscribe((result:any)=>{
      this.categories = [...result];

      this.categories.map((category)=>{
     
        
        category.description = category.description!.slice(1,20) +"...";
       })
    })
  }

  receiveData(event:Category)
  {
    this.categories.push(event)
  }
  delete(id:string , index:number)
  {

    this.categoryService.delete(id).subscribe((result:any)=>{
      this.categories.splice(index,1);
    })
  }

  openEdit(id:string)
  {
    const dialogRef = this.dialog.open(EditCategoryComponent,{data:{id}});
    dialogRef.afterClosed$.subscribe(result => {
      this.ngOnInit()
    });
    dialogRef.backdropClick$.subscribe(() => {
      this.ngOnInit()
    });
    
  }

}
