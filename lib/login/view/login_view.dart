import 'package:bloc_learn/login/service/login_service.dart';
import 'package:bloc_learn/login/view/login_detail_view.dart';
import 'package:bloc_learn/login/view_model/cubit/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  String baseUrl = 'https://reqres.in/api';

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(
        emailController,
        passwordController,
        formKey,
        loginService: LoginService(Dio(BaseOptions(baseUrl: baseUrl))),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginCompleteState) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginDetailView(model: state.model),
            ));
          }
        },
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Form(
        key: formKey,
        autovalidateMode: state is LoginValidateState
            ? (state.isValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled)
            : AutovalidateMode.disabled,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              validator: (value) =>
                  (value ?? '').length > 5 ? null : '5 ten küçük',
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'E-mail'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) =>
                  (value ?? '').length > 6 ? null : '6 ten küçük',
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            buildElevatedButtonLogin(context)
          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButtonLogin(BuildContext context) {
    return ElevatedButton(
      onPressed: context.watch<LoginCubit>().isLoading
          ? null
          : () {
              context.read<LoginCubit>().postUserModel();
            },
      child: const Text('Giriş'),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: Visibility(
        visible: context.watch<LoginCubit>().isLoading,
        child: const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
