
import 'package:flutter/material.dart';
import 'package:wallet_digital/app/pages/deposit/devices/mobile.dart';
import 'package:wallet_digital/app/pages/deposit/devices/web.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

import 'devices/tablet.dart';

class DepositPage extends StatelessWidget {
  const DepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveScreen(mobile: DepositMobile(), tablet: DepositTablet(), web: DepositWeb());
  }
}