import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/pages/transfer/bloc/bloc.dart';
import 'package:wallet_digital/app/pages/transfer/bloc/state.dart';
import 'package:wallet_digital/app/pages/transfer/components/header.dart';
import 'package:wallet_digital/app/pages/transfer/components/profile.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/app_routes.dart';
import 'package:jsqr/scanner.dart';

class TransferTablet extends StatefulWidget {
  const TransferTablet({super.key});

  @override
  State<TransferTablet> createState() => _TransferTabletState();
}

class _TransferTabletState extends State<TransferTablet> {
  final TextEditingController controller = TextEditingController();
  final bloc = Modular.get<BlocTransfer>();
  @override
  void initState() {
    super.initState();
    bloc.loadFromUser();
  }
  final seconds = 3;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopAppBar(
        onBack: () {
          Modular.to.navigate(AppRoutes.home);
        },
        title: const TopText(text: 'Transfêrencia'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .1),
        child: BlocConsumer<BlocTransfer, TransferState>(
         bloc: bloc,
          listener: (context, state) {
            switch(state.status){
              
              case TransferStatus.idle:
                break;
              case TransferStatus.error:
                _error(state.error ?? 'Desculpe houve algum erro inesperado');
                break;
              case TransferStatus.loading:
                break;
              case TransferStatus.success:
             
                break;
              case TransferStatus.done:
               _success();
               Future.delayed(Duration(seconds: seconds)).then((value) {
                if(mounted){
                  Modular.to.navigate(AppRoutes.home);
                }
               });
                break;
            }
          },
          builder: (context, state) {
              if([TransferStatus.idle.name,TransferStatus.loading.name].contains(state.status.name)){
          return const Center(child: TopCircularProgressIndicator());
        }
controller.text = state.toUser?.cpf ?? '';
            return SingleChildScrollView(
              child: Column(children: [
                 TransferProfile(image: state.toUser?.image ?? ''),
                TransferHeader(setAmount: bloc.changeAmount,initialValue: state.transaction.amount.toString()),
                TopText(text: state.toUser != null? 'Nome: ${state.toUser?.firstName}': '' ),
                const SizedBox(height: 10,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: size.width * .15),
                  child: Row(
                    children: [
                      Flexible(
                
                          child: TopInputField(
                        label: 'CPF',
                        suffix: InkWell(
                            onTap: () {
                              if (controller.text.isEmpty) return;
                              bloc.fetchUserByCpf(controller.text);
                            },
                            child: const Icon(Icons.search)),
                        controller: controller,
                      )),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () async {
                                var code = await _scanQRCode();
                                try {
                                  final Map<String, dynamic> map =
                                      jsonDecode(code);
                                  if (map.containsKey('cpf')) {
                                    final cpf = map['cpf'];
                                    controller.text = cpf;
                                    bloc.fetchUserByCpf(cpf);
                                    return;
                                  }
                                } catch (e) {
                                  dev.log(e.toString());
                                }
                                _qrcodeInvalid();
                              },
                              icon: const Icon(Icons.qr_code)),
                          const TopText(text: 'scan')
                        ],
                      ),
                     
                    ],
                  ),
                ),
               const  SizedBox(height: 40,),
                 TopButton(text: 'Transferir',
                    disabled: !state.validate(),
                    type: TopButtonType.contain,
                    onTap: (){
                      bloc.makeTransfer();
                    },
                    )
              ]),
            );
          },
        ),
      ),
    );
  }

  _qrcodeInvalid() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: TopColors.redColor,
        duration: const Duration(seconds: 2),
        content: TopText(
          text: 'QRCode invalido!!!',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: TopColors.thirdColor),
        )));
  }
  _error(String error){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration:  Duration(seconds: seconds),
      backgroundColor: TopColors.redColor,
      content: TopText(text: error,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: TopColors.thirdColor
      ),)));
  }
  _success(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration:  Duration(seconds: seconds),
      backgroundColor: TopColors.greenColor,
      content: TopText(text: "Transação realizada com sucesso, em alguns instantes voce será redirecionado",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: TopColors.thirdColor
      ),)));
  }

  Future<dynamic> _scanQRCode() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {

          var width = MediaQuery.of(context).size.width;
          return AlertDialog(
            insetPadding: const EdgeInsets.all(5),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Text('Scan QR Code'),
            content: SizedBox(
                // height: height - 20,
                width: width - 6,
                child: const Scanner()),
          );
        });
  }
}
