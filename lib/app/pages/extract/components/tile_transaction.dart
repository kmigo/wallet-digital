import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/pages/extract/bloc/bloc.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/extensions.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

class ExtractTileTransaction extends StatelessWidget {
  final TransactionEntity transaction;
  const ExtractTileTransaction({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        mobile: _TileTransactionMobile(transaction),
        tablet: _TileTransactionMobile(transaction),
        web: _TileTransactionMobile(transaction));
  }
}

class _TileTransactionMobile extends StatelessWidget {
  final TransactionEntity transaction;
  final bloc = Modular.get<BlocExtract>();
   _TileTransactionMobile(this.transaction);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Row(
        children: [
          _barVertical(size),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_tileTypeTransaction(context)],
            ),
          )
        ],
      ),
    );
  }

  _tileTypeTransaction(BuildContext context) {
    if (transaction.transactionType == TransactionEnum.deposit) {
      return _tileTypeTransactionDeposit(context);
    }else{
      return _tileTypeTransactionTransfer(context);
    }
  }

  _tileTypeTransactionTransfer(BuildContext context) {
    return Row(

      children: [
         Icon(Icons.account_balance,
        color: transaction.plywood  ? TopColors.greenColor:  transaction.expirationDate.dateTime.isExpired ? TopColors.redColor: TopColors.greyColor,
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopText(text: TransactionEnum.name(transaction.transactionType)),
            TopText(text: transaction.createdAt.dateTime.timeHourMinute,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: TopColors.greyColor
            ),)
          ],
        ),
        const Spacer(),
        Row(
          children: [
            
            TopText(
                text:
                    '${transaction.toCpf == bloc.userEntity?.cpf ? '+' : '-'} R\$ ${transaction.amount.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: transaction.toCpf == bloc.userEntity?.cpf  ? TopColors.greenColor : TopColors.redColor
                    ),
                    ),
          ],
        ),
      ],
    );
  }

  _tileTypeTransactionDeposit(BuildContext context) {
    return Row(

      children: [
         Icon(Icons.account_balance,
        color: transaction.plywood  ? TopColors.greenColor:  transaction.expirationDate.dateTime.isExpired ? TopColors.redColor: TopColors.greyColor,
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopText(text: TransactionEnum.name(transaction.transactionType)),
            if (transaction.plywood == false) ...[
              TopText(
                text: transaction.expirationDate.dateTime.textDeposit(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: transaction.expirationDate.dateTime.isExpired
                        ? TopColors.redColor
                        : TopColors.greyColor),
              )
            ]else ...[
              Row(
                children: [
                  TopText(text: "COMPENSADO",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: TopColors.greenColor,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  const Icon(Icons.monetization_on,
                  color: TopColors.greenColor,
                  size: 15,
                  )
                ],
              )
            ]
          ],
        ),
        const Spacer(),
        Row(
          children: [
            
            TopText(
                text:
                    '${transaction.plywood ? '+' : ''} R\$ ${transaction.amount.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: transaction.plywood ? TopColors.greenColor : TopColors.greyColor
                    ),
                    ),
          ],
        ),
      ],
    );
  }

  _barVertical(Size size) {
    return SizedBox(
      width: size.width * .08,
      child: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: Container(
                    height: 10,
                    width: 10,
                    color: TopColors.greenColor,
                  )),
              Container(
                width: 2,
                height: 30,
                color: TopColors.greyColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
