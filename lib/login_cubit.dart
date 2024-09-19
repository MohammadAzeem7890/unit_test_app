import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unit_testing_app/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  login(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      emit(LoginLoading());
      Future.delayed(const Duration(seconds: 1), () {
        if (email == "email" && password == "password") {
          emit(LoginSuccess());
        } else {
          emit(LoginFailed());
        }
      });
    }
  }
}
