part of 'auth_bloc.dart';

class AuthState {
  const AuthState._({
    this.status = AuthStatus.unauthenticated,
  });

  const AuthState.unknown() : this._();

  const AuthState.loading() : this._(status: AuthStatus.loading);

  const AuthState.authenticated() : this._(status: AuthStatus.authenticated);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  const AuthState.unverified() : this._(status: AuthStatus.unverified);

  const AuthState.profileNotSetup()
      : this._(status: AuthStatus.profileNotSetup);

  const AuthState.appFirstOnBoarded()
      : this._(status: AuthStatus.appFirstOnboarded);

  const AuthState.categoryNotSetup()
      : this._(status: AuthStatus.categoryNotSetup);

  final AuthStatus status;
}
