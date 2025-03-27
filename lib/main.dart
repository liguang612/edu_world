import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/firebase_options.dart';
import 'package:edu_world/view/login/login.dart';
import 'package:edu_world/view/register/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.purple01),
        useMaterial3: true,
      ),
      home: Register(),
    );
  }
}
