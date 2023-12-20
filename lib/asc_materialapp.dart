import 'package:adishankara_calender/calender_widget.dart';
import 'package:adishankara_calender/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AscMaterialApp extends StatelessWidget {
  const AscMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuBackgroundColor: Colors.blue,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width / 1.7,
      moveMenuScreen: true,
      mainScreen: const MainScreen(),
      menuScreen: DrawerElement(),
    );
  }
}

class DrawerElement extends StatelessWidget {
  DrawerElement({super.key});
  final String? user = _auth.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GFListTile(
              color: Colors.white70,
              shadow: const BoxShadow(
                color: Color.fromARGB(167, 255, 255, 255),
                offset: Offset.zero,
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
              title: const Text(
                "Logged in as ",
                style: TextStyle(
                    color: Color.fromARGB(153, 27, 26, 26), fontSize: 20),
              ),
              subTitle: Text("$user"),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Log Out"),
              ),
            ),
          ],
        ),
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
