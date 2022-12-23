import 'package:app_sena/pantallaCarrito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import'../pages/home_page.dart';
import'../pages/login_page.dart';
import '../auth/auth_page.dart';
import 'package:app_sena/pantallaCarta.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PantallaCarrito();
          } else {
            return const  AuthPage();
          }
        },
      ),
    );
  }
}
