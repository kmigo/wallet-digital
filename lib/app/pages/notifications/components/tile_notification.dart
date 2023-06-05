

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/pages/notifications/bloc/bloc.dart';
import 'package:wallet_digital/core/domain/entities/notification.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/extensions.dart';

import 'package:wallet_digital/utils/responsive_screen.dart';

class TileNotification extends StatelessWidget {
  final NotificationEntity notificationEntity;
  const TileNotification({super.key,required this.notificationEntity});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveScreen(mobile: _MobileNotification(notificationEntity), tablet: _MobileNotification(notificationEntity), web: _MobileNotification(notificationEntity));
  }
}

class _MobileNotification extends StatelessWidget {

 final NotificationEntity notificationEntity;
   const _MobileNotification(this.notificationEntity);

  @override
  Widget build(BuildContext context) {
    return _typeTransaction(notificationEntity,context);
  }

  _typeTransaction(NotificationEntity notificationEntity, BuildContext context){
    if(notificationEntity.transactionType == TransactionEnum.deposit){
      return _compensate(notificationEntity, context);
    }else{
      return _transfer(notificationEntity, context);
    }
  }

  _transfer(NotificationEntity notificationEntity, BuildContext context){
   return TopCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
              children: [
                const Icon(Icons.notifications),
              TopText(text: TransactionEnum.name(notificationEntity.transactionType))
              ],
            ),

              TopText(text: 'Criado em ${notificationEntity.createdAt.dateTime.dateFormata} ás ${notificationEntity.createdAt.dateTime.timeHourMinute}',
              style: Theme.of(context).textTheme.bodySmall,),
              TopText(text: "Valor: R\$ ${notificationEntity.amount.toStringAsFixed(2).replaceAll('.', ',')}"),
              TopText(text: "De ${notificationEntity.from} para ${notificationEntity.to}")
              ],
            ),
            const Spacer(),


               const Icon(Icons.account_balance,size: 50,

               )


          ],
        ),
      ),
    );
  }
  }

  _compensate(NotificationEntity notificationEntity, BuildContext context){
    return TopCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
              children: [
                const Icon(Icons.notifications),
              TopText(text: "BOLETO DE ${TransactionEnum.name(notificationEntity.transactionType)}")
              ],
            ),
            

              TopText(text: 'Criado em ${notificationEntity.createdAt.dateTime.dateFormata} ás ${notificationEntity.createdAt.dateTime.timeHourMinute}',
              style: Theme.of(context).textTheme.bodySmall,),
              TopText(text: "Valor: R\$ ${notificationEntity.amount.toStringAsFixed(2).replaceAll('.', ',')}"),

              
              if(notificationEntity.plywood)...[
                TopText(text: 'COMPENSADO',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(

                  fontWeight: FontWeight.bold
                ),
                )
              ]
              ],
            ),
            const Spacer(),
            if(!notificationEntity.plywood)...[
              TopButton(text: 'compensar',onTap: (){
                 final bloc=Modular.get<BlocNotification>();
                 bloc.updateNotification(notificationEntity);
              },
              type: TopButtonType.contain,
              )
            ]else...[
               const Icon(Icons.account_balance,size: 50,

               )
            ]

          ],
        ),
      ),
    );
  }
