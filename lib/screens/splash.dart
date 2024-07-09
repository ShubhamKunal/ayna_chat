import 'package:ayna_chat/router/routes.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Ayna Chat", size: 22),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CustomText(text: "You are welcome to Ayna Chat", size: 16),
              ElevatedButton(
                  onPressed: () {
                    context.go("/login");
                  },
                  child: CustomText(text: "Login", size: 20)),
              ElevatedButton(
                  onPressed: () {
                    context.go("/signup");
                  },
                  child: CustomText(text: "Signup", size: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
