import 'package:bloc/bloc.dart';
import 'package:bloc_learn/login/model/login_request_model.dart';
import 'package:bloc_learn/login/model/login_response_model.dart';
import 'package:bloc_learn/login/service/i_login_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  final ILoginService loginService;

  bool isLoginFail = false;
  bool isLoading = false;
  // cityslicka eve.holt@reqres.in

  LoginCubit(this.emailController, this.passwordController, this.formKey,
      {required this.loginService})
      : super(LoginInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();
      final data = await loginService.postUserLogin(LoginRequestModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim()));
      changeLoadingView();
      if (data is LoginResponseModel) {
        emit(LoginCompleteState(data));
      }
    } else {
      isLoginFail = true;
      LoginValidateState(isLoginFail);
      emit(LoginValidateState(isLoginFail));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}
