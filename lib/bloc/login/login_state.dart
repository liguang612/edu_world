part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  final User account;

  const LoginSuccessState(this.account);
  @override
  List<Object?> get props => [account];
}

class LoginFailedState extends LoginState {
  final String msg;

  const LoginFailedState(this.msg);
  @override
  List<Object?> get props => [msg];
}

class RegisterNewUserState extends LoginState {
  final String id;

  const RegisterNewUserState(this.id);
  @override
  List<Object?> get props => [id];
}
