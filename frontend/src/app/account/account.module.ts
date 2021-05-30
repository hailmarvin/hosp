import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LoginComponent } from './login/login.component';
import { SignupComponent } from './signup/signup.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { MaterialModule } from '../material.module';
import { AppointmentComponent } from './appointment/appointment.component';

@NgModule({
  declarations: [LoginComponent, SignupComponent, AppointmentComponent],
  imports: [
    CommonModule,
    MaterialModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule.forChild([
        { path: 'signup', component: SignupComponent },
        { path: 'login', component: LoginComponent }
    ])
  ]
})
export class AccountModule { }
