

import 'package:flutter/material.dart';
import 'package:wallet_digital/app/pages/notifications/devices/mobile.dart';
import 'package:wallet_digital/app/pages/notifications/devices/tablet.dart';
import 'package:wallet_digital/app/pages/notifications/devices/web.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveScreen(mobile: NotificationMobile(), tablet:  NotificationTablet(), web:  NotificationWeb());
  }
}