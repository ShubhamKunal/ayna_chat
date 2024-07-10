// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ayna_chat/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ayna_chat/sqlite/database_helper.dart';
import 'package:ayna_chat/widgets/custom_long_button.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:ayna_chat/widgets/logout_button.dart';
import 'package:ayna_chat/widgets/text_form_field.dart';
import 'package:go_router/go_router.dart';

class NewChat extends StatelessWidget {
  const NewChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController receipentController = TextEditingController();
    TextEditingController messageController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const CustomText(text: "New Message", size: 22),
          actions: const [LogoutButton()],
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                    controller: receipentController,
                    hintText: "receipent",
                    obscureText: false),
                const SizedBox(height: 8),
                CustomTextFormField(
                    controller: messageController,
                    hintText: "message",
                    obscureText: false),
                const SizedBox(height: 8),
                CustomLongButton(
                    text: "send",
                    onPressed: () async {
                      await ChatDB().insertChat({
                        "sender":
                            FirebaseAuth.instance.currentUser!.email ?? "user",
                        "receiver": receipentController.text,
                        "text": messageController.text
                      });
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    },
                    bright: false),
              ],
            ),
          ),
        ));
  }
}
