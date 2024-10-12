part of 'auth_bloc.dart';

@immutable
class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  late final String token;
  AuthSuccess({required this.token});
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure({required this.error});
}

class AuthNotAuthenticated extends AuthState {}
