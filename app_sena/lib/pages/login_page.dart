import 'package:app_sena/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pantallaCarta.dart';
import 'forgot_password_page.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future logIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[800],
      body: SingleChildScrollView(
       child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children : [
             Column (
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
             IconButton(onPressed: () {Get.to(PantallaCarta(),duration: const Duration(seconds: 1),transition: Transition.leftToRightWithFade);}, icon: Icon(Icons.arrow_back_ios_new, color: Colors.white,)),

            Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        '¡Bienvenido!',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 50,
                            color: Colors.white
                        ),
                      ),
                      SizedBox(
                        height: 350,
                        width: 350,
                        child: Image(
                          image: AssetImage('images/pic1.png'),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: TextField(
                          controller: _emailController,
                          obscureText: false,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              hintText: 'Email',
                              fillColor: Colors.grey[200],
                              filled: true
                          ),
                        ),
                      ),
                      SizedBox(height: 50),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              hintText: 'Contraseña',
                              fillColor: Colors.grey[200],
                              filled: true
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                  CupertinoPageRoute(
                                      builder: (context) {
                                        return ForgotPasswordPage();
                                      }
                                  ),
                                );
                              },
                              child: const Text(
                                "Olvido la contraseña?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 70),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                                onTap:
                                widget.showRegisterPage,

                                child: const Text(
                                  '¡Registrarse Aqui!',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15
                                  ),
                                )
                            )

                          ],
                        ),
                      ),

                      const SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: GestureDetector(
                          onTap: logIn,
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                    ],
                  ),
                  ),
               ],

            ),
          ],

          ),
        ),
      ),
    );
  }
}