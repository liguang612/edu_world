import 'dart:async';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/model/entity/user.dart';
import 'package:edu_world/usecase/get_account_info_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccountInfoUsecase _getAccountInfoUsecase = getIt.get();

  AccountBloc() : super(const AccountState()) {
    on<GetAccountInfo>(_onGetAccountInfo);
  }

  FutureOr<void> _onGetAccountInfo(GetAccountInfo event, Emitter<AccountState> emit) async {
    final output = await _getAccountInfoUsecase.execute();

    if (output.successful == true) {
      emit(GetAccountInfoSuccess(output.user!));
    } else {
      emit(GetAccountInfoFailed());
    }
  }
}
