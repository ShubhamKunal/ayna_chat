import 'package:ayna_chat/chat/ui/all_chats.dart';
import 'package:ayna_chat/chat/ui/new_chat.dart';
import 'package:ayna_chat/chat/ui/new_echo.dart';
import 'package:ayna_chat/sqlite/database_helper.dart';
import 'package:ayna_chat/widgets/custom_small_button.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:ayna_chat/widgets/logout_button.dart';
import 'package:ayna_chat/widgets/text_form_field.dart';
import 'package:ayna_chat/utils/app_variables.dart' as variables;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String user = FirebaseAuth.instance.currentUser!.email ?? "user";
  int currentIndex = 0;
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ChatDB chatDB = ChatDB();
  Widget firstScreen = const AllChats();

  void navigateToChat() async {
    if (variables.config == "ECHO") {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewEcho()),
      );
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewChat()),
      );
    }
  }

  @override
  void initState() {
    chatDB
        .findUserByEmail(FirebaseAuth.instance.currentUser!.email!)
        .then((val) {
      if (val.isEmpty) {
        log("Empty");
      } else {
        setState(() {
          user = val[0]['username'];
        });
        usernameController.text = val[0]['username'];

        phoneController.text = val[0]['phone'];
        log(val.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: "Home", size: 22),
        actions: const [LogoutButton()],
      ),
      body: (currentIndex == 0)
          ? firstScreen
          : Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
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
                        onPressed: () async {
                          await ChatDB().insertUser({
                            "email": FirebaseAuth.instance.currentUser!.email,
                            "username": usernameController.text,
                            "phone": phoneController.text
                          });
                          setState(() {
                            user = usernameController.text;
                            currentIndex = 0;
                          });
                        })
                  ],
                ),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToChat,
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10.0,
        child: const Icon(
          Icons.add,
          size: 30.0,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: HexColor("#A3A7B7"),
          onTap: onItemTapped,
          showUnselectedLabels: true,
          currentIndex: currentIndex,
          elevation: 10.0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                activeIcon: Icon(Icons.home_filled),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                activeIcon: Icon(Icons.person_2_rounded),
                label: "Profile"),
          ]),
    );
  }
}
