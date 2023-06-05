import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/blocs/state_general.dart';
import 'package:wallet_digital/app/pages/extract/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/extract/components/body.dart';
import 'package:wallet_digital/app/pages/extract/components/header.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';
import 'package:wallet_digital/ds/ds.dart';

class ExtractMobile extends StatefulWidget {
  const ExtractMobile({super.key});

  @override
  State<ExtractMobile> createState() => _ExtractMobileState();
}

class _ExtractMobileState extends State<ExtractMobile> {
  final bloc = Modular.get<BlocExtract>();
  @override
  void initState() {
    super.initState();
  bloc.getAllTransactions();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BlocExtract, BaseState>(
        bloc: bloc,
        builder: (context, state) {
          if([StateIdle,StateLoading].contains(state.runtimeType)){
            return const Center(child: TopCircularProgressIndicator());
          }
          if(state is StateError ){
            return  ErrorTryAgain(
              onTap: bloc.getAllTransactions,
            );
          }
          final transactions = (state as StateSuccess<List<TransactionEntity>>).data!;
          if(transactions.isEmpty){
            return const TopEmpty();
          }
          return Column(
            children: [
              const ExtractHeader(),
              Expanded(child: ExtractBody(transactions: transactions))
              ],
          );
        },
      ),
    );
  }
}
