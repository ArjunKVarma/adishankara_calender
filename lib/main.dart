import 'package:adishankara_calender/firebase_options.dart';
import 'package:adishankara_calender/pages/signin_page.dart';
import 'package:adishankara_calender/providers/event_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = "ASIET calender";
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => EventProvider(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SignIn(), //AscMaterialApp(),
          title: title,
        ),
      );
}
