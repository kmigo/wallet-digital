
import 'package:flutter/material.dart';
import 'package:wallet_digital/app/pages/extract/devices/mobile.dart';
import 'package:wallet_digital/app/pages/extract/devices/tablet.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

class ExtractPage extends StatelessWidget {
  const ExtractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveScreen(
      mobile: ExtractMobile(),
      tablet: ExtractTablet(),
      web: ExtractTablet(),
    );
  }
}