// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:wallet_digital/core/models/transaction.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

import '../../../../ds/ds.dart';
import '/utils/extensions.dart';
class DepositExpirationDate extends StatelessWidget {
  final TransactionModel transactionModel;
  final Function(DateTime) onChangeDate;
  const DepositExpirationDate({super.key,required this.transactionModel ,required this.onChangeDate});

  @override
  Widget build(BuildContext context) {
    return   ResponsiveScreen(
        mobile: _Mobile(transactionModel, onChangeDate),
         tablet: _Mobile(transactionModel, onChangeDate), web: 
         _Mobile(transactionModel, onChangeDate));
  }
}

class _Mobile extends StatelessWidget {
  final TransactionModel transactionModel;
   final Function(DateTime) onChangeDate;
    const _Mobile(this.transactionModel,this.onChangeDate);

  @override
  Widget build(BuildContext context) {
   
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopText(
            text: "Vencimento",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * .02,),
          Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: TopColors.primaryColor
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: ()async{
                  final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 60)));
                  if(date !=null){
                    onChangeDate(date);
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        TopText(text: transactionModel.date.dateTime.weekdayString.toUpperCase(),
                        style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TopText(text: transactionModel.date.dateTime.toString().split(' ')[0],
                        style: Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    ),const Spacer(),
                    const Icon(Icons.edit,color: TopColors.greenColor,)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
