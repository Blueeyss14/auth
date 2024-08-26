import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_regist/firebase_options.dart';
import 'package:login_regist/providers/auth/auth_gate.dart';
import 'package:login_regist/providers/auth/auth_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthServices())
        ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
