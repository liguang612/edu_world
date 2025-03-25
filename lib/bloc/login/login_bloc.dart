import 'dart:async';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/base/response_wrapper.dart';
import 'package:edu_world/domain/repository/login_repository.dart';
import 'package:edu_world/mdoel/account.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository = getIt.get();

  LoginBloc(super.initialState) {
    on<LoginWithGoogle>(_onLoginWithGoogle);
  }

  FutureOr<void> _onLoginWithGoogle(LoginWithGoogle event, Emitter<LoginState> emit) async {
    final response = await loginRepository.logInWithGoogle();

    if (response.status == ResponseStatus.success) {
      if (response.data != null) {
        emit(LoginSuccessState(response.data!));
      }
      return;
    }

    emit(const LoginFailedState("Login failed"));
    return;
  }
}
