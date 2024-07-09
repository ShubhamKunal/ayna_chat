import 'package:ayna_chat/auth/authentication_repository.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Home Page", size: 22),
        actions: [
          IconButton(
              onPressed: () {
                AuthenticationRepository().logOut(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CustomText(text: "Home Page", size: 16),
          ],
        ),
      ),
    );
  }
}
