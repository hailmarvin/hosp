import { NgModule } from "@angular/core";
import {
  MatCardModule,
  MatToolbarModule,
  MatSelectModule,
  MatFormFieldModule,
  MatDatepickerModule,
  MatButtonModule,
  MatSidenavModule,
  MatIconModule
} from "@angular/material";

const modules = [
  MatToolbarModule,
  MatCardModule,
  MatSelectModule,
  MatFormFieldModule,
  MatDatepickerModule,
  MatButtonModule,
  MatSidenavModule,
  MatIconModule
];

@NgModule({
  imports: modules,
  exports: modules
})
export class MaterialModule {}