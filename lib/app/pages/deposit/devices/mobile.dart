

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/pages/deposit/bloc/state.dart';
import 'package:wallet_digital/app/pages/deposit/components/button.dart';
import 'package:wallet_digital/app/pages/deposit/components/description.dart';
import 'package:wallet_digital/app/pages/deposit/components/expiration_date.dart';
import 'package:wallet_digital/app/pages/deposit/components/header.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/app_routes.dart';

import '../bloc/bloc.dart';


class DepositMobile extends StatefulWidget {
  const DepositMobile({super.key});

  @override
  State<DepositMobile> createState() => _DepositMobileState();
}

class _DepositMobileState extends State<DepositMobile> {
  final bloc = Modular.get<BlocDeposit>();
  final seconds = 4;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopAppBar(
        onBack: (){
          Modular.to.navigate(AppRoutes.home);
        },
        title:  Text('Depositar',style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SizedBox(
        width: size.width,
        child: BlocConsumer<BlocDeposit, DepositState>(
          bloc: bloc,
          listener: (context, state) {
            switch(state.status){
              case DepositStatus.loading:

                break;
              case DepositStatus.success:
              _success();
                Future.delayed(Duration(seconds: seconds)).then((value) {
                  if(mounted){
                    Modular.to.navigate(AppRoutes.home);
                  }
                });
                break;
              case DepositStatus.idle:

                break;
              case DepositStatus.error:
                _error();
                break;
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                    children:  [
                        DepositHeader(setAmount: bloc.setAmount,),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                              DepositExpirationDate(onChangeDate: bloc.selectDate,
                          transactionModel: state.transaction,),
                          DepositDescription(transactionModel: state.transaction, onChange: bloc.setDescription),
                           DepositButton(transactionModel: state.transaction, onChange: bloc.createTransaction, disable: !state.canExecuteTransaction() || state.status == DepositStatus.loading || state.status == DepositStatus.success,loading: state.status == DepositStatus.loading,)
                          ],
                        ),
                      )
                    ],
                  ),
            );
          },
        ),
      ),
    );
  }

_success(){
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    backgroundColor: TopColors.greenColor,
    duration:  Duration(seconds: seconds),
    content: TopText(text: 'Boleto criado com successo, em alguns instantes voce será redirecionado',
  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: TopColors.thirdColor)),
  ));
}

_error(){
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    backgroundColor: TopColors.redColor,
    duration:  Duration(seconds: seconds),
    content: TopText(text: 'Desculpe pelo transtorno estamos enfrentando alguns problemas no moemento, tente novamente mais tarde.',
  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: TopColors.thirdColor)),
  ));
}
}