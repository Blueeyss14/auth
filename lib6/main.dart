import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_regist_test/auth/provider/auth.dart';
import 'package:login_regist_test/auth/provider/auth_services.dart';
import 'package:login_regist_test/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthServices(),)
  ], child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Auth(),
    );
  }
}
