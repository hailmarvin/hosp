import { NgModule } from "@angular/core";
import {
    MatCardModule,
  MatToolbarModule
} from "@angular/material";

const modules = [
  MatToolbarModule,
  MatCardModule
];

@NgModule({
  imports: modules,
  exports: modules
})
export class MaterialModule {}