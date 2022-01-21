import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { DialogRef } from '@ngneat/dialog';

import { Category } from '../entities/Category';
import { CategoryService } from '../services/category.service';

@Component({
  selector: 'app-edit-category',
  templateUrl: './edit-category.component.html',
  styleUrls: ['./edit-category.component.scss']
})
export class EditCategoryComponent implements OnInit {

  category:Category = new Category();
  @Output() sendDataToCategoryParent: EventEmitter<Category> = new EventEmitter();
  categoryForm: FormGroup;
  constructor(private  ref:DialogRef,private readonly categoryService: CategoryService, private formBuilder: FormBuilder) {
    this.categoryForm = this.formBuilder.group({
      id: new FormControl('',Validators.required),
      name: new FormControl('',Validators.required),
      description: new FormControl('',Validators.required),

    })
  }

  ngOnInit(): void {

    let id = this.ref.data.id;
    this.categoryService.getSingleCategory(id).subscribe((result)=>{
      console.log(result)
      this.category._id = result._id;
      this.category.nom = result.nom;
      this.category.description = result.description;
    })
  }

  editCategory(): void {
    let category: Category = new Category();
    category._id = this.categoryForm.value.id;
    category.nom = this.categoryForm.value.name;
    category.description = this.categoryForm.value.description;

    this.categoryService.editCategory(category._id!,category).subscribe((result) => {

    })
  }

}
