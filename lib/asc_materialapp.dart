import 'package:adishankara_calender/calender_widget.dart';
import 'package:adishankara_calender/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';

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
        child: ListView(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.2),
          children: [
            // A GfListTile with a title, a subtitle, and an icon

            // A GfListTile with an avatar, a title, a subtitle, and a color
            const GFListTile(
              shadow: BoxShadow(
                color: Color.fromARGB(30, 255, 255, 255),
                offset: Offset.zero,
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
              margin: EdgeInsets.all(5),
              radius: 0,
              title: Text('Daily feed'),
              subTitle: Text('under development'),
              color: Color.fromARGB(33, 255, 255, 255),
            ),
            // A GfListTile with a title, a subtitle, an icon, and a shape
            const GFListTile(
              shadow: BoxShadow(
                color: Color.fromARGB(30, 255, 255, 255),
                offset: Offset.zero,
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
              margin: EdgeInsets.all(5),
              radius: 0,
              title: Text('Profile'),
              subTitle: Text('under development'),
              icon: Icon(Icons.arrow_forward_ios),
              color: Color.fromARGB(33, 255, 255, 255),
            ),
            // A GfListTile with a title, a subtitle, an icon, and an onTap callback
            GFListTile(
              shadow: BoxShadow(
                color: Color.fromARGB(30, 255, 255, 255),
                offset: Offset.zero,
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
              margin: EdgeInsets.all(5),
              radius: 0,
              title: Text('Settings'),
              subTitle: Text('under development'),
              icon: Icon(Icons.arrow_forward_ios),
              color: Color.fromARGB(33, 255, 255, 255),
            ),
            GFListTile(
              shadow: BoxShadow(
                color: Color.fromARGB(30, 255, 255, 255),
                offset: Offset.zero,
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
              title: Text('Signed in as'),
              subTitle: Text(user!),
              onLongPress: () {
                _auth.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ));
              },
              margin: EdgeInsets.all(5),
              radius: 0,
              icon: Icon(Icons.logout),
              color: Color.fromARGB(33, 255, 255, 255),
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
