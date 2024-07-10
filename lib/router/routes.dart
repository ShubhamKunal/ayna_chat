import 'package:ayna_chat/chat/ui/new_chat.dart';
import 'package:ayna_chat/screens/home.dart';
import 'package:ayna_chat/auth/ui/login.dart';
import 'package:ayna_chat/auth/ui/signup.dart';
import 'package:ayna_chat/screens/personal_data.dart';
import 'package:ayna_chat/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

var routes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const Splash(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/signup',
    builder: (context, state) => const SignupPage(),
  ),
  GoRoute(
    path: '/personal',
    builder: (context, state) => const FillPersonalData(),
  ),
  GoRoute(
    path: '/newchat',
    builder: (context, state) => const NewChat(),
  ),
];
final appRouter = GoRouter(
  initialLocation: (FirebaseAuth.instance.currentUser != null) ? "/home" : "/",
  routes: routes,
);
