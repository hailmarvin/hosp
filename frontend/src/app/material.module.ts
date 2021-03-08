import { NgModule } from "@angular/core";
import {
  MatCardModule,
  MatToolbarModule,
  MatSelectModule,
  MatFormFieldModule
} from "@angular/material";

const modules = [
  MatToolbarModule,
  MatCardModule,
  MatSelectModule,
  MatFormFieldModule
];

@NgModule({
  imports: modules,
  exports: modules
})
export class MaterialModule {}