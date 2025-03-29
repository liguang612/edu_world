import 'dart:async';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/login_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final LoginRepository _loginRepository = getIt.get();

  OnboardingBloc() : super(OnboardingState()) {
    on<OnboardingEvent>(_onOnboarded);
  }

  FutureOr<void> _onOnboarded(OnboardingEvent event, Emitter<OnboardingState> emit) {
    _loginRepository.onboard();

    emit(OnboardingDone());
  }
}
