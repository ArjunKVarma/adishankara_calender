import 'package:adishankara_calender/asc_materialapp.dart';
import 'package:adishankara_calender/firebase_options.dart';
import 'package:adishankara_calender/pages/signin_page.dart';
import 'package:adishankara_calender/providers/event_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialise firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // call for app function
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //Page title
  static const String title = "ASIET calender";
  const MyApp({super.key});

  @override
  // Notifier provider for
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => EventProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (kDebugMode) {
              print(snapshot);
            }
            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasData) {
              return MaterialApp(
                navigatorKey: NavigationService.navigatorKey,
                debugShowCheckedModeBanner: false,
                home: const AscMaterialApp(),
                title: title,
              );
            } else {
              return MaterialApp(
                navigatorKey: NavigationService.navigatorKey,
                debugShowCheckedModeBanner: false,
                home: const SignIn(),
                title: title,
              );
            }
          },
        ),
      );
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
