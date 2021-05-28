import { NgModule } from "@angular/core";
import {MatToolbarModule} from "@angular/material/toolbar";
import {MatButtonModule} from '@angular/material/button';
import {MatIconModule} from '@angular/material/icon';
import {MatRadioModule} from '@angular/material/radio';

const modules = [
  MatToolbarModule,
  MatButtonModule,
  MatIconModule,
  MatRadioModule
];

@NgModule({
  imports: modules,
  exports: modules
})
export class MaterialModule {}