import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-signin',
  templateUrl: './signin.component.html',
  styleUrls: ['./signin.component.scss']
})
export class SigninComponent implements OnInit {

  constructor() { }

  signupForm = new FormGroup({
    firstName: new FormControl(''),
    middleName: new FormControl(''),
    lastName: new FormControl(''),
    email: new FormControl(''),
    dob: new FormControl(''),
    phone: new FormControl(''),
    gender: new FormControl(''),
    password: new FormControl(''),
    confirmPassword: new FormControl(''),
  })

  ngOnInit() {
  }

}
