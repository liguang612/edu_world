part of 'splash_bloc.dart';

class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class GetNextRouteSuccess extends SplashState {
  final String nextRoute;
  final dynamic arguments;

  const GetNextRouteSuccess(this.nextRoute, {this.arguments});
  @override
  List<Object?> get props => [nextRoute, arguments];
}
