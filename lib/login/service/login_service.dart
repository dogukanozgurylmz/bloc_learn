import 'dart:io';

import 'package:bloc_learn/login/model/login_response_model.dart';
import 'package:bloc_learn/login/model/login_request_model.dart';
import 'package:bloc_learn/login/service/i_login_service.dart';
import 'package:dio/dio.dart';

class LoginService extends ILoginService {
  LoginService(Dio dio) : super(dio);

  @override
  Future<LoginResponseModel?> postUserLogin(LoginRequestModel model) async {
    final response = await dio.post(loginPath, data: model);
    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
