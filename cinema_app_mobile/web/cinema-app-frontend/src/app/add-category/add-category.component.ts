import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';

import { Category } from '../entities/Category';
import { CategoryService } from '../services/category.service';


@Component({
  selector: 'add-category',
  templateUrl: './add-category.component.html',
  styleUrls: ['./add-category.component.scss']
})
export class AddCategoryComponent implements OnInit {

  @Output() sendDataToCategoryParent: EventEmitter<Category> = new EventEmitter();
  categoryForm: FormGroup;
  constructor(private readonly categoryService: CategoryService, private formBuilder: FormBuilder) {
    this.categoryForm = this.formBuilder.group({
      name: new FormControl('',Validators.required),
      description: new FormControl('',Validators.required),

    })
  }

  ngOnInit(): void {
  }

  addCategory(): void {
    let category: Category = new Category();
    category.nom = this.categoryForm.value.name;
    category.description = this.categoryForm.value.description;

    this.categoryService.addCategory(category).subscribe((result) => {
      this.sendData(result);
    })
  }

  sendData(newCategory: Category) {
    this.sendDataToCategoryParent.emit(newCategory)
  }

}
