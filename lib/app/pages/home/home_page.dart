

import 'package:flutter/material.dart';

import 'package:wallet_digital/app/pages/home/devices/mobile.dart';
import 'package:wallet_digital/app/pages/home/devices/tablet.dart';
import 'package:wallet_digital/app/pages/home/devices/web.dart';

import 'package:wallet_digital/utils/responsive_screen.dart';

class HomePage extends StatelessWidget {
   const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ResponsiveScreen(mobile: HomeMobile(), tablet:  HomeTablet(), web:  HomeWeb());
  }
}