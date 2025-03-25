part of 'login_bloc.dart';

class LoginEvent extends Equatable {
const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithGoogle extends LoginEvent {}

class RegisterNewUser extends LoginEvent {
  final String id;

  const RegisterNewUser(this.id);

  @override
  List<Object?> get props => [id];
}
