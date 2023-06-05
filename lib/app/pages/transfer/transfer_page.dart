

import 'package:flutter/material.dart';
import 'package:wallet_digital/app/pages/transfer/devices/mobile.dart';
import 'package:wallet_digital/app/pages/transfer/devices/tablet.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

import 'devices/web.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveScreen(mobile: TransferMobile(), tablet: TransferTablet(), web: TransferWeb());
  }
}