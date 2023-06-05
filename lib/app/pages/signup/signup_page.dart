
import 'package:flutter/material.dart';
import 'package:wallet_digital/app/pages/signup/devices/mobile.dart';
import 'package:wallet_digital/app/pages/signup/devices/tablet.dart';
import 'package:wallet_digital/app/pages/signup/devices/web.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
      child: const ResponsiveScreen(mobile: SignUpMobile(), tablet: SignUpTablet(), web: SignUpWeb()));
  }
}