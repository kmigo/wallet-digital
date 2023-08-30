import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:wallet_digital/app/pages/signin/devices/mobile.dart';
import 'package:wallet_digital/app/pages/signin/devices/tablet.dart';

import 'package:wallet_digital/app/pages/signin/devices/web.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';




class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) {
    // return MobileScanner(
    //     // fit: BoxFit.contain,
    //     controller: MobileScannerController(
    //       detectionSpeed: DetectionSpeed.normal,
    //       facing: CameraFacing.back,
    //       torchEnabled: true,
    //     ),
    //     onDetect: (capture) {

    //     },
    //   );
    return WillPopScope(
      onWillPop: ()async=>false,
      child: const ResponsiveScreen(mobile:  SignInMobile(), tablet:  SignInTablet(), web:  SignInWeb()));
  }

  
}
