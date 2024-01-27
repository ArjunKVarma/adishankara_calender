import 'package:adishankara_calender/asc_materialapp.dart';
import 'package:adishankara_calender/firebase_options.dart';
import 'package:adishankara_calender/pages/signin_page.dart';
import 'package:adishankara_calender/providers/event_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

        // Use stream builder to render app
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // loading screen
            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            // check for existing snapshot to render signin or app page
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
            // end of snapshot block
          },
        ),
      );
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
