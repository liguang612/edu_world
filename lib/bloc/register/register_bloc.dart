import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';
part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterEvent>(_onRegister);
  }

  FutureOr<void> _onRegister(RegisterEvent event, Emitter<RegisterState> emit) async {}
}
