import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Auth/auth.dart';
import 'Auth/provider/auth_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => AuthServicesProvider()),
      ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPages(),
    );
  }
}
