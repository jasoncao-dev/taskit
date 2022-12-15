import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskit/theme.dart';
import 'firebase_options.dart';
import 'package:taskit/widgets/homePage.dart';

void main() async {
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
    return MaterialApp(
      title: 'taskit',
      theme: ThemeData(primaryColor: actionBgClr, focusColor: actionBgClr),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
