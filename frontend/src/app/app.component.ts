import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'frontend';
  panelOpenState = false;

  constructor(private route: Router) {}

  account() {
    this.route.navigateByUrl('account/signin')
  }
}