import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoadingState());
        try {
          final supabase = Supabase.instance;
          await supabase.client.auth
              .signInWithPassword(email: event.email, password: event.password);
          emit(SuccessState());
        } catch (e) {
          emit(FailureState(error: "$e"));
        }
      }

      if (event is RegisterEvent) {
        try {
          emit(LoadingState());
          final supabase = Supabase.instance;
          await supabase.client.auth
              .signUp(email: event.email, password: event.password);
          emit(SuccessState());
        } catch (e) {
          emit(FailureState(error: "$e"));
        }
      }
    });
  }
}
