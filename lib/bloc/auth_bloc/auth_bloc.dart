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
        } else {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(AuthUserSuccess());
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthUserFailed(e.message.toString()));
      }
    });
  }
}
