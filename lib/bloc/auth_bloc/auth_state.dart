part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingState extends AuthState {}

final class SuccessState extends AuthState {}

final class FailureState extends AuthState {
  final String error;
  FailureState({required this.error});
}
