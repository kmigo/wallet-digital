

import 'package:flutter/material.dart';
import 'package:wallet_digital/app/pages/profile/devices/mobile.dart';
import 'package:wallet_digital/app/pages/profile/devices/tablet.dart';
import 'package:wallet_digital/app/pages/profile/devices/web.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const  ResponsiveScreen(mobile: ProfileMobile(), tablet: ProfileTablet(), web: ProfileWeb());
  }
}