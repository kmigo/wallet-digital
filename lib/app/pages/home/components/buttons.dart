

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/app_routes.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

class HomeButtons extends StatelessWidget {
  const HomeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveScreen(mobile: _ButtonsMobile(), tablet: _ButtonsMobile(), web: _ButtonsMobile());
  }
}

class _ButtonsMobile extends StatelessWidget {
  const _ButtonsMobile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TopButton(text: "Depositar", type: TopButtonType.contain,onTap: (){
            Modular.to.pushNamed(AppRoutes.deposit);
          },),
          const SizedBox(width: 10,),
          TopButton(text: "Enviar", type: TopButtonType.outline,onTap: (){
            Modular.to.navigate(AppRoutes.transfer);
          },),
        ],
      ),
    );
  }
}