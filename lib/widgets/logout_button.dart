import 'package:ayna_chat/auth/authentication_repository.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Row(
        children: [
          CustomText(text: "Logout", size: 16),
          SizedBox(width: 4),
          Icon(Icons.logout),
          SizedBox(width: 4),
        ],
      ),
      onTap: () {
        AuthenticationRepository().logOut(context);
      },
    );
  }
}
