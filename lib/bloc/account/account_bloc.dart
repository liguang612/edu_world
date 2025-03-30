import 'dart:async';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/model/entity/user.dart';
import 'package:edu_world/usecase/get_account_info_usecase.dart';
import 'package:edu_world/usecase/log_out_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccountInfoUsecase _getAccountInfoUsecase = getIt.get();
  final LogOutUsecase _logOutUsecase = getIt.get();

  AccountBloc() : super(const AccountState()) {
    on<GetAccountInfo>(_onGetAccountInfo);
    on<Logout>(_onLogOut);
  }

  FutureOr<void> _onGetAccountInfo(GetAccountInfo event, Emitter<AccountState> emit) async {
    final output = await _getAccountInfoUsecase.execute();

    if (output.successful == true) {
      emit(GetAccountInfoSuccess(output.user!));
    } else {
      emit(GetAccountInfoFailed());
    }
  }

  FutureOr<void> _onLogOut(Logout event, Emitter<AccountState> emit) async {
    emit(LoggingOutState());

    final output = await _logOutUsecase.execute();

    if (output.successful == true) {
      emit(LoggedOutSuccess());
    } else {
      emit(LoggedOutFailed());
    }
  }
}
