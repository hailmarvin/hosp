import { Component, HostListener } from '@angular/core';
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

  @HostListener('window:scroll', ['$event'])

  onWindowScroll(e) {
    let element = document.querySelector('.header');
    if (window.pageYOffset > 700) {
      element.classList.add('header-changed');
    } else {
      element.classList.remove('header-changed');
    }
  }

  account() {
    this.route.navigateByUrl('account/signin')
  }
}