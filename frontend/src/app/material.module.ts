import { NgModule } from "@angular/core";
import {
  MatCardModule,
  MatToolbarModule,
  MatSelectModule,
  MatFormFieldModule,
  MatDatepickerModule,
  MatButtonModule
} from "@angular/material";

const modules = [
  MatToolbarModule,
  MatCardModule,
  MatSelectModule,
  MatFormFieldModule,
  MatDatepickerModule,
  MatButtonModule
];

@NgModule({
  imports: modules,
  exports: modules
})
export class MaterialModule {}