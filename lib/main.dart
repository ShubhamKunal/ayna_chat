import 'package:ayna_chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ayna_chat/router/routes.dart' as router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router.appRouter,
    );
  }
}
// Platform  Firebase App Id
// web       1:687014930504:web:f6a32932e6c3cd399fd07d
// android   1:687014930504:android:bb8c4b0ccb1b19319fd07d
// ios       1:687014930504:ios:c0a82e0c38042bf59fd07d
// macos     1:687014930504:ios:c0a82e0c38042bf59fd07d
// windows   1:687014930504:web:b6d3071ac072d39a9fd07d

// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthenticationBloc, AuthenticationState>(
//       builder: (context, state) {
//         if (state is AuthenticationAuthenticated) {
//           return HomeScreen();
//         }
//         return LoginScreen();
//       },
//     );
//   }
// }
