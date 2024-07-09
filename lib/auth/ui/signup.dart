import 'package:ayna_chat/auth/authentication_repository.dart';
import 'package:ayna_chat/auth/bloc/auth_bloc.dart';
import 'package:ayna_chat/widgets/custom_long_button.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:ayna_chat/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';
import 'package:go_router/go_router.dart';
import '../../utils/functions.dart' as functions;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final authbloc = AuthBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authbloc,
      listener: (context, state) {
        if (state is AuthSuccessState) {
          functions.showSnackbarWithColor(context, "Signed in", Colors.teal);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const CustomText(text: "Sign up", size: 22),
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
                      obscureText: false),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: false),
                  const SizedBox(height: 8),
                  (state is AuthenticatingState)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomLongButton(
                          text: "Sign up",
                          bright: false,
                          onPressed: () {
                            log("Email:${emailController.text} pass:${passwordController.text} c-pass:${confirmPasswordController.text}");
                            if (confirmPasswordController.text ==
                                passwordController.text) {
                              authbloc.add(SigningEvent(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordController.text));
                            } else {
                              functions.showSnackbarWithColor(context,
                                  "passwords do not match", Colors.teal);
                            }
                          }),
                  const SizedBox(height: 8),
                  TextButton(
                      onPressed: () {
                        context.go("/login");
                      },
                      child: const CustomText(text: "Login Instead", size: 18))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
