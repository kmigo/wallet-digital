

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/pages/extract/bloc/bloc.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

class ExtractHeader extends StatelessWidget {

  const ExtractHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveScreen(
      web: _HeaderMobile(),
      tablet: _HeaderMobile(),
      mobile: _HeaderMobile(),
    );
  }
}

class _HeaderMobile extends StatelessWidget {
  final bloc = Modular.get<BlocExtract>();
   _HeaderMobile();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopText(text: "Extrato",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
          ),),
          Row(
            children: [
const Spacer(),IconButton(onPressed: (){
  bloc.getAllTransactions();
}, icon: const Icon(Icons.refresh))
            ],
          )
        ],
      ),
    );
  }
}