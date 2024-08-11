part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthUserSuccess extends AuthState {}

final class AuthUserSuccessSignInGoogle extends AuthState {}

final class AuthUserFailed extends AuthState {
  const AuthUserFailed(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}

final class AuthUserLoading extends AuthState {}

final class AuthUserLoadingGoogle extends AuthState {}
