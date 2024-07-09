import 'package:ayna_chat/auth/authentication_repository.dart';
import 'package:ayna_chat/auth/bloc/auth_bloc.dart';
import 'package:ayna_chat/router/routes.dart';
import 'package:ayna_chat/widgets/custom_long_button.dart';
import 'package:ayna_chat/widgets/custom_small_button.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:ayna_chat/widgets/text_form_field.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../utils/functions.dart' as functions;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authbloc = AuthBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authbloc,
      listener: (context, state) {
        if (state is AuthSuccessState) {
          functions.showSnackbarWithColor(context, "Logged in", Colors.teal);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const CustomText(text: "Login", size: 22),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextFormField(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true),
                  const SizedBox(height: 8),
                  (state is AuthenticatingState)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomLongButton(
                          text: "Submit",
                          bright: false,
                          onPressed: () {
                            log("email:${emailController.text} pass:${passwordController.text}");
                            authbloc.add(AuthenticateEvent(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text));
                          }),
                  const SizedBox(height: 8),
                  TextButton(
                      onPressed: () {
                        context.go("/signup");
                      },
                      child: const CustomText(
                          text: "Create Account Instead", size: 18))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
