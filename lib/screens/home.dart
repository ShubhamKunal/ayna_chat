import 'package:ayna_chat/auth/authentication_repository.dart';
import 'package:ayna_chat/screens/personal_data.dart';
import 'package:ayna_chat/widgets/custom_small_button.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String user = FirebaseAuth.instance.currentUser!.email ?? "user";
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: "Home", size: 22),
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
              CustomText(text: "Hello $user", size: 16),
              const SizedBox(height: 8),
              CustomSmallButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FillPersonalData()));
                  },
                  text: "Fill Personal Data")
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: HexColor("#A3A7B7"),
          onTap: _onItemTapped,
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
