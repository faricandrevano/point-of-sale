import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthUserCreate>((event, emit) async {
      emit(AuthUserLoading());
      try {
        if (event.confirmPassword != event.password) {
          emit(const AuthUserFailed('password confirmation does not match!'));
        } else if (event.email.isEmpty ||
            event.password.isEmpty ||
            event.phoneNumber.isEmpty ||
            event.confirmPassword.isEmpty) {
          emit(const AuthUserFailed("Value Can't Be Empty"));
        } else {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(AuthUserSuccess());
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthUserFailed(e.message.toString()));
      }
    });
    on<AuthUserLogin>((event, emit) async {
      emit(AuthUserLoading());
      try {
        if (event.email.isEmpty || event.password.isEmpty) {
          emit(const AuthUserFailed("Value Can't Be Empty"));
        } else {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(AuthUserSuccess());
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthUserFailed(e.message.toString()));
      }
    });
    on<AuthUserLogout>((event, emit) async {
      emit(AuthUserLoading());
      try {
        await FirebaseAuth.instance.signOut();
        emit(AuthUserSuccess());
      } on FirebaseAuthException catch (e) {
        emit(AuthUserFailed(e.message.toString()));
      }
    });
  }
}
