

// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_function_declarations_over_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/pages/extract/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/extract/components/tile_transaction.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';
import 'package:wallet_digital/core/models/transaction_by_date.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/extensions.dart';

import 'package:wallet_digital/utils/responsive_screen.dart';

class ExtractBody extends StatelessWidget {
  final List<TransactionEntity> transactions;
  const ExtractBody({super.key,required this.transactions});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveScreen(mobile: _BodyMobile(transactions), tablet: _BodyMobile(transactions), web: _BodyMobile(transactions));
  }
}

class _BodyMobile extends StatelessWidget {
  final List<TransactionEntity> transactions;
  final bloc = Modular.get<BlocExtract>();
    _BodyMobile(this.transactions);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final transactionsByMonth = <String,List<TransactionsByDate>> {};
    for (var element in transactions) { 

      final month = element.createdAt.dateTime.monthToStringYearNumber;
      final date = element.createdAt.dateTime.toString().split(' ')[0];
      if(!transactionsByMonth.containsKey(month)){
        transactionsByMonth[month] = [];
      }
      var entity = TransactionsByDate(date: date, transactions:  [element]);
      final index = transactionsByMonth[month]!.indexOf(entity);
      if(index < 0){
        transactionsByMonth[month]!.add(entity);
      }else{
        transactionsByMonth[month]![index].transactions.add(element);
      }

    }
    
    final transactionsOrders = [...transactionsByMonth.keys.toList()];

    Comparator<String> comparator = (a,b) => _orderMonth(a).compareTo(_orderMonth(b));
    transactionsOrders.sort(comparator);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: transactionsOrders.reversed.toList().map<Widget>((monthName) {
        final listTransactionsByDate = transactionsByMonth[monthName]!;
        Comparator<TransactionsByDate> comparator = (a,b) => a.date.compareTo(b.date);
        listTransactionsByDate.sort(comparator);
          return Column(
            children: [
              TopText(text: monthName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: TopColors.greenColor,
                fontWeight: FontWeight.bold
              ),),
              Column(
                children: listTransactionsByDate.reversed.toList().map<Widget>((transactionsByDate) {
                  final dateTransaction = transactionsByDate.date;
      
                    Comparator<TransactionEntity> comparatorTransaction = (a,b) =>b.createdAt.compareTo(a.createdAt);
                    transactionsByDate.transactions.sort(comparatorTransaction);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
      
                          SizedBox(
                            width: size.height * .08,
                            child: TopCard(
                              borderRadius: BorderRadius.circular(360),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: TopText(text:dateTransaction.dateTime.weekdayString,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: TopColors.thirdColor
                                    ),),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: TopText(text: dateTransaction.dateTime.dayString,
                                    style: Theme.of(context).textTheme.titleLarge
                                    ),
                                  )
                                ],
                                          ),
                              )),
                          ),
                          ...transactionsByDate.transactions.map<Widget>((e) {
                          return Column(
                            children: [
                              ExtractTileTransaction(transaction: e),
                              const Divider(),
                            ],
                          );
                        }).toList()
                        ],
                      );
                }).toList(),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
  String _orderMonth(String text){
    final map = {
      'JANEIRO':'1',
      'FEVEREIRO':'2',
      'MARÇO':'3',
      'ABRIL':'4',
      'MAIO':'5',
      'JUNHO':'6',
      'JULHO':'7',
      'AGOSTO':'8',
      'SETEMBRO':'9',
      'OUTUBRO':'10',
      'NOVEMBRO':'11',
      'DEZEMBRO':'12'
    };
    final month = text.split('-')[0];
    return "${map[month]}-${month[1]}";
  }
}