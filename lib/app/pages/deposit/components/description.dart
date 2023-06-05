// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:wallet_digital/core/models/transaction.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

import '../../../../ds/ds.dart';

class DepositDescription extends StatelessWidget {
  final TransactionModel transactionModel;
  final Function(String) onChange;
  const DepositDescription({super.key,required this.transactionModel ,required this.onChange});

  @override
  Widget build(BuildContext context) {
    return   ResponsiveScreen(
        mobile: _Mobile(transactionModel, onChange),
         tablet: _Mobile(transactionModel, onChange), web: 
         _Mobile(transactionModel, onChange));
  }
}

class _Mobile extends StatelessWidget {
  final TransactionModel transactionModel;
   final Function(String) onChange;
    const _Mobile(this.transactionModel,this.onChange);

  @override
  Widget build(BuildContext context) {
   
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            const SizedBox(height: 10,),
           const TopText(text: "Mensagem (Opcional)"),
          const SizedBox(height: 10,),
            TopInputField(
            maxLines: 4,
            onChanged: (text) => onChange(text),
            hintText: "Adicione uma mensagem",
          )
        ],
      ),
    );
  }
}
