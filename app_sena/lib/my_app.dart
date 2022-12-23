import 'package:app_sena/pantallainicio.dart';

import 'package:app_sena/pantallainicio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_sena/pages/login_page.dart';
import 'auth/main_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: PantallaInicio(),
    );
  }
}
