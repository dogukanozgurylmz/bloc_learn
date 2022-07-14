import 'package:bloc_learn/login/model/login_response_model.dart';
import 'package:flutter/material.dart';

class LoginDetailView extends StatelessWidget {
  final LoginResponseModel model;
  const LoginDetailView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(model.token ?? '')),
    );
  }
}
