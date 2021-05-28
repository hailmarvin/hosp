import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.scss']
})
export class SignupComponent implements OnInit {

  constructor() { }

  signupForm = new FormGroup({
    firstname: new FormControl(''),
    middlename: new FormControl(''),
    lastname: new FormControl(''),
    email: new FormControl(''),
    phone: new FormControl(''),
    dob: new FormControl(''),
    gender: new FormControl(''),
    password: new FormControl('')
  })

  ngOnInit() {
  }

}
