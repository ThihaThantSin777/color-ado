import 'package:color_ado/pages/users/index_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDgWvCe-Q7osyC-SjqExHumJnF4JIUU_IQ',
    appId: '1:39907433298:android:0672ab5051574ebe79b88b',
    messagingSenderId: '39907433298',
    projectId: 'color-ado-334c0',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Color Ado',
      home: IndexPage(),
    );
  }
}
