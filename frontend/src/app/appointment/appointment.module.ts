import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { MaterialModule } from '../material.module';
import { AppointmentEditComponent } from './appointment-edit/appointment-edit.component';
import { AppointmentComponent } from './appointment/appointment.component';

@NgModule({
  declarations: [AppointmentEditComponent, AppointmentComponent],
  imports: [
    CommonModule,
    MaterialModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule.forChild([])
  ]
})
export class AppointmentModule { }