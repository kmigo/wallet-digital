// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:wallet_digital/core/models/transaction.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

import '../../../../ds/ds.dart';

class DepositButton extends StatelessWidget {
  final TransactionModel transactionModel;
  final VoidCallback onChange;
  final bool disable;
  final bool loading;
  const DepositButton({super.key,required this.transactionModel,required this.loading,required this.disable ,required this.onChange});

  @override
  Widget build(BuildContext context) {
    return   ResponsiveScreen(
        mobile: _Mobile(transactionModel, onChange, disable, loading),
         tablet: _Mobile(transactionModel, onChange, disable,loading), web: 
         _Mobile(transactionModel, onChange, disable,loading));
  }
}

class _Mobile extends StatelessWidget {
  final TransactionModel transactionModel;
   final VoidCallback onChange;
   final bool disable;
     final bool loading;
    const _Mobile(this.transactionModel,this.onChange, this.disable,this.loading);

  @override
  Widget build(BuildContext context) {
   
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: size.height * .05,),
           TopButton(text: 'Gerar',disabled: disable,onTap: onChange,loading: loading,)
        ],
      ),
    );
  }
}
