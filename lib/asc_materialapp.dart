import 'package:adishankara_calender/calender_widget.dart';
import 'package:adishankara_calender/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AscMaterialApp extends StatelessWidget {
  const AscMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuBackgroundColor: Colors.blue,
      angle: -5.0,
      slideWidth: MediaQuery.of(context).size.width / 1.7,
      moveMenuScreen: true,
      mainScreen: const MainScreen(),
      menuScreen: const DrawerElement(),
    );
  }
}

class DrawerElement extends StatelessWidget {
  const DrawerElement({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          const ListTile(
            title: Text("Hello"),
          ),
          FloatingActionButton(
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              _auth.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class ToggleWidget extends StatelessWidget {
  const ToggleWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () => ZoomDrawer.of(context)!.toggle(),
    );
  }
}
