import 'dart:async';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/usecase/get_next_route_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetNextRouteUsecase _getNextRouteUsecase = getIt.get();

  SplashBloc() : super(const SplashState()) {
    on<SplashEvent>(_onGetNextRoute);
  }

  FutureOr<void> _onGetNextRoute(SplashEvent event, Emitter<SplashState> emit) async {
    final output = await _getNextRouteUsecase.execute();

    if (output.successful == true) {
      emit(GetNextRouteSuccess(output.nextRoute));
    }
  }
}
