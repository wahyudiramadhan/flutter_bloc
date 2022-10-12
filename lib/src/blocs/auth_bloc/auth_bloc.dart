// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bc/src/repository/repo_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  AuthBloc(this._authRepo) : super(AuthLoading()) {
    on<LoginEvent>((event, emit) async {
      try {
        // emit(AuthLoading());s
        final result = await _authRepo.login(event.email, event.password);

        if (result != "user not found") {
          emit(AuthSuccessful());
        } else {
          emit(AuthError("Missing password OR  user not found"));
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
