part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => [];
}

class GetAccountInfoSuccess extends AccountState {
  final User user;

  const GetAccountInfoSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class GetAccountInfoFailed extends AccountState {}
