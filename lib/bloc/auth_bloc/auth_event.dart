part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthUserCreate extends AuthEvent {
  const AuthUserCreate(
      {required this.password,
      required this.email,
      required this.confirmPassword,
      required this.phoneNumber});
  final String password, email, phoneNumber, confirmPassword;
  @override
  List<Object> get props => [password, email, phoneNumber, confirmPassword];
}

final class AuthUserLogin extends AuthEvent {
  const AuthUserLogin({
    required this.password,
    required this.email,
  });
  final String password, email;
  @override
  List<Object> get props => [password, email];
}
