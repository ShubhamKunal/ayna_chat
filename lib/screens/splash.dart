import 'package:ayna_chat/widgets/custom_long_button.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: CustomText(text: "Ayna Chat", size: 22)),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              const CustomText(text: "Ayna chat connects people!", size: 16),
              const SizedBox(height: 16),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: SvgPicture.asset("assets/people_chatting.svg")),
              const SizedBox(height: 16),
              const CustomText(
                  text: "If you already have an account", size: 16),
              const SizedBox(height: 16),
              CustomLongButton(
                  text: "Login",
                  onPressed: () {
                    context.go("/login");
                  },
                  bright: false),
              const SizedBox(height: 16),
              const CustomText(text: "If you are new here", size: 16),
              const SizedBox(height: 16),
              CustomLongButton(
                  text: "Sign up",
                  onPressed: () {
                    context.go("/signup");
                  },
                  bright: true),
            ],
          ),
        ),
      ),
    );
  }
}
