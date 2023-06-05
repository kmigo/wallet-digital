import 'package:flutter/material.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

class HomeBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChange;
  const HomeBottomBar({super.key,required  this.onChange,required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveScreen(mobile:  _BottomMobile(currentIndex: currentIndex,onChange: onChange,), 
    tablet:  _BottomMobile(currentIndex: currentIndex,onChange: onChange,), web: const SizedBox());
  }
}

class _BottomMobile extends StatelessWidget {
   final int currentIndex;
  final ValueChanged<int> onChange;

  const _BottomMobile({ required this.currentIndex, required this.onChange});


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: TopColors.greenColor,
      currentIndex: currentIndex,onTap: onChange,
      items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home),label: "Minha conta"),
      BottomNavigationBarItem(icon: Icon(Icons.list),label: "Extrato"),
    ]);
  }
}