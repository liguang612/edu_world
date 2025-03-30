part of 'account_bloc.dart';

class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class GetAccountInfo extends AccountEvent {}

class Logout extends AccountEvent {}
