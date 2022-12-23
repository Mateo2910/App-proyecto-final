import 'package:app_sena/pantallaCarta.dart';

import 'app_sena/pantallaCarta.dart';
import 'package:flutter/material.dart';

import 'desktop.dart';

class ResponsiveLayout extends StatelessWidget {


  const ResponsiveLayout({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return PantallaCarta();
        } else {
          return Desktop();
        }
      },
    );
  }
}