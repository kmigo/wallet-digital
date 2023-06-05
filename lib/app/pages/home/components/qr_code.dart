import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

import '../../../blocs/authententication/bloc.dart';

class HomeQRCode extends StatelessWidget {
  final bloc = Modular.get<AutheticationBloc>();
  HomeQRCode({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<AutheticationBloc, AutheticationState>(
      bloc: bloc,
      builder: (context, state) {
        final cpf = state.status.user?.cpf;
    if (cpf == null) return const SizedBox();
        return ResponsiveScreen(
            mobile: _QRCodeMobile(cpf: cpf),
            tablet: _QRCodeMobile(cpf: cpf),
            web: _QRCodeMobile(
              cpf: cpf,
            ));
      },
    );
  }
}

class _QRCodeMobile extends StatelessWidget {
  final String cpf;
  const _QRCodeMobile({required this.cpf});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrettyQr(
            size: 200,
            data:cpf,
            errorCorrectLevel: QrErrorCorrectLevel.M,
            roundEdges: true,
          ),
          const SizedBox(height: 10,),
           TopText(text: "Receba via QRCode",style: Theme.of(context).textTheme.titleMedium,),

        ],
      ),
    );
  }
}
