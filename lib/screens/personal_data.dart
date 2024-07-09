import 'package:ayna_chat/auth/authentication_repository.dart';
import 'package:ayna_chat/sqlite/database_helper.dart';
import 'package:ayna_chat/widgets/custom_small_button.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:ayna_chat/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:go_router/go_router.dart';

class FillPersonalData extends StatefulWidget {
  const FillPersonalData({super.key});

  @override
  State<FillPersonalData> createState() => _FillPersonalDataState();
}

class _FillPersonalDataState extends State<FillPersonalData> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ChatDB chatDB = ChatDB();
  @override
  void initState() {
    log("abc");
    chatDB.findUser().then((val) {
      if (val.isEmpty) {
        log("Empty");
      }
      usernameController.text = val[0]['username'];
      phoneController.text = val[0]['phone'];
      log(val.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: "Personal Data", size: 22),
        actions: [
          const CustomText(text: "Logout", size: 16),
          IconButton(
              onPressed: () {
                AuthenticationRepository().logOut(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(text: "Please fill your data", size: 16),
              CustomTextFormField(
                  controller: usernameController,
                  hintText: "username",
                  obscureText: false),
              const SizedBox(height: 8),
              CustomTextFormField(
                  controller: phoneController,
                  hintText: "phone",
                  obscureText: false),
              const SizedBox(height: 8),
              CustomSmallButton(
                  text: "Submit",
                  onPressed: () {
                    ChatDB().insertUser({
                      "username": usernameController.text,
                      "phone": phoneController.text
                    });
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
