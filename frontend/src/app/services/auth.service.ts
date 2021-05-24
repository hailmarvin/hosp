import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable, Subscription, of } from 'rxjs';
import { map, tap, delay, finalize } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { User } from '../interface/User.interface';

interface LoginResult {
  name: string;
  surname: string;
  dob: string;
  phone: number;
  reg: number;
  accessToken: string;
  refreshToken: string;
}

@Injectable({
  providedIn: 'root'
})

export class AuthService {

  private readonly apiUrl = `${environment.apiUrl}api/`
  private timer: Subscription
  private _user = new BehaviorSubject<User>(null)
  user$: Observable<User> = this._user.asObservable()

  constructor(private router: Router, private http: HttpClient) {
    window.addEventListener('storage', this.storageEventListener.bind(this))
  }
  private storageEventListener(event: StorageEvent) {
    if (event.storageArea === localStorage) {
      if (event.key === 'logout-event') {
        this._user.next(null);
      }
      if (event.key === 'login-event') {
        location.reload();
      }
    }
  }

  ngOnDestroy(): void {
    window.removeEventListener('storage', this.storageEventListener.bind(this))
  }

  login(username: String, password: String) {
    return this.http
    .post<LoginResult>(`${this.apiUrl}/login`, { username, password })
    .pipe(
      map((x) => {
        this._user.next(
          { name: x.name, surname: x.surname, dob: x.dob, phone: x.phone, reg: x.reg }
        );
        this.setLocalStorage(x);
        localStorage.setItem('login-event', 'login' + Math.random());
        this.startTokenTimer();
        return x;
      })
    );
  }

  logout() {
    this.http
    .post<unknown>(`${this.apiUrl}/logout`, {})
    .pipe(
      finalize(() => {
        this.clearLocalStorage();
        this._user.next(null);
        this.stopTokenTimer();
        this.router.navigate(['login']);
      })
    )
    .subscribe();
  }

  refreshToken() {
    const refreshToken = localStorage.getItem('refresh_token');
    if (!refreshToken) {
      this.clearLocalStorage();
      return of(null);
    }

    return this.http
      .post<LoginResult>(`${this.apiUrl}/refresh-token`, { refreshToken })
      .pipe(
        map((x) => {
          this._user.next(
            { name: x.name, surname: x.surname, dob: x.dob, phone: x.phone, reg: x.reg }
          );
          this.setLocalStorage(x);
          this.startTokenTimer();
          return x;
        })
      );
  }

  setLocalStorage(x: LoginResult) {
    localStorage.setItem('access_token', x.accessToken);
    localStorage.setItem('refresh_token', x.refreshToken);
    localStorage.setItem('login-event', 'login' + Math.random());
  }

  clearLocalStorage() {
    localStorage.removeItem('access_token');
    localStorage.removeItem('refresh_token');
    localStorage.setItem('logout-event', 'logout' + Math.random());
  }

  private getTokenRemainingTime() {
    const accessToken = localStorage.getItem('access_token');
    if (!accessToken) {
      return 0;
    }
    const jwtToken = JSON.parse(atob(accessToken.split('.')[1]));
    const expires = new Date(jwtToken.exp * 1000);
    return expires.getTime() - Date.now();
  }

  private startTokenTimer() {
    const timeout = this.getTokenRemainingTime();
    this.timer = of(true)
      .pipe(
        delay(timeout),
        tap(() => this.refreshToken().subscribe())
      )
      .subscribe();
  }

  private stopTokenTimer() {
    this.timer?.unsubscribe();
  }
}