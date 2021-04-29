import { NgModule } from "@angular/core";
import {
  MatCardModule,
  MatToolbarModule,
  MatSelectModule,
  MatFormFieldModule,
  MatDatepickerModule,
  MatButtonModule,
  MatSidenavModule,
  MatIconModule,
  MatCheckboxModule,
  MatRadioModule
} from "@angular/material";

const modules = [
  MatToolbarModule,
  MatCardModule,
  MatSelectModule,
  MatFormFieldModule,
  MatDatepickerModule,
  MatButtonModule,
  MatSidenavModule,
  MatIconModule,
  MatCheckboxModule,
  MatRadioModule
];

@NgModule({
  imports: modules,
  exports: modules
})
export class MaterialModule {}