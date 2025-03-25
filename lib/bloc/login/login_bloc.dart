import 'dart:async';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/model/entity/user.dart';
import 'package:edu_world/usecase/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase = getIt.get();

  LoginBloc() : super(const LoginState()) {
    on<LoginWithGoogle>(_onLoginWithGoogle);
    on<RegisterNewUser>(_onRegisterNewUser);
  }

  FutureOr<void> _onLoginWithGoogle(LoginWithGoogle event, Emitter<LoginState> emit) async {
    final output = await loginUsecase.execute();

    if (output.successful == true) {
      if (output.user != null) {
        emit(LoginSuccessState(output.user!));
      } else {
        add(RegisterNewUser(output.id ?? ''));
      }
    } else {
      emit(const LoginFailedState("Login failed"));
    }

    return;
  }

  FutureOr<void> _onRegisterNewUser(RegisterNewUser event, Emitter<LoginState> emit) {
    emit(RegisterNewUserState(event.id));
  }
}
