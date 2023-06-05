

import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  final Widget web;
  final Widget tablet;
  final Widget mobile;
  const ResponsiveScreen({super.key,required this.mobile, required this.tablet, required this.web});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
  builder: (context, constraints) {
   
    if (constraints.maxWidth > 800) {
      return web;
    } else if (constraints.maxWidth > 500 && constraints.maxWidth <= 800) {
      return tablet;
    } else {
      return mobile;
    }
  },
);

  }
}