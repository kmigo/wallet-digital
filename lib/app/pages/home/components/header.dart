import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/app/blocs/authententication/bloc.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

import '../../../../core/repository/authentication_repository.dart';

class HomeHeader extends StatelessWidget {
  final bloc = Modular.get<AutheticationBloc>();
  final bool visible;
  final VoidCallback onVisible;
  HomeHeader({super.key, required this.visible,required this.onVisible});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AutheticationBloc, AutheticationState>(
      bloc: bloc,
      listener: (context, state) {
        switch(state.status.status){
          case StatusAuthentication.unknow:
            bloc.add(AuthenticationCurrentUserEvent());
            break;
          case StatusAuthentication.authentication:
          case StatusAuthentication.unauthentication:
          case StatusAuthentication.signOut:
          case StatusAuthentication.error:
            break;
        }
      },
      builder: (context, state) {

        return   ResponsiveScreen(
            mobile: _HomeHeaderMobile(onVisible: onVisible, visible: visible, balance: state.status.user?.balance ?? 0.0, name: state.status.user?.firstName ?? '',loading: state.status.status == StatusAuthentication.unknow,error: state.status.status == StatusAuthentication.error,),
            tablet: _HomeHeaderWeb(onVisible: onVisible,visible: visible, balance: state.status.user?.balance ?? 0.0,name: state.status.user?.firstName ?? '',loading: state.status.status == StatusAuthentication.unknow,error: state.status.status == StatusAuthentication.error,),
            web: _HomeHeaderWeb(onVisible: onVisible,visible: visible,balance: state.status.user?.balance ?? 0.0,name: state.status.user?.firstName ?? '',loading: state.status.status == StatusAuthentication.unknow,error: state.status.status == StatusAuthentication.error,));
      },
    );
  }
}
class _HomeHeaderWeb extends StatelessWidget {
  final bool loading;
  final String name;
  final double balance;
  final bool error;
  final bool visible;
  final VoidCallback onVisible;
  const _HomeHeaderWeb({required this.onVisible, required this.balance,required this.visible, required this.error,required this.loading,required this.name});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(

        width: size.width,
        color: TopColors.greyColor.withOpacity(.5),
        child: IntrinsicHeight(
          child: Row(
            children: [
               Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TopText(text: "Wallet",
                        style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      )
                    ],
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TopText(text: loading ? 'carregando' :'Olá, $name'),
                    SizedBox(height: size.height *.02,),
                    TopText(text:    "R\$ ${!visible? '*******' :balance.toStringAsFixed(2).replaceAll('.', ',')}",
                    style: Theme.of(context).textTheme.headlineLarge,
                    ),
                     SizedBox(height: size.height *.01,),
                     
                    ],            
                ),
              ),
               Expanded(child: Column(
                children: [
                   const Expanded(child: SizedBox()),
                  Padding(
                       padding:  const EdgeInsets.only(right:8.0,bottom: 4),
                       child:  Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: onVisible,
                          child:  Icon(!visible ? Icons.visibility_off : Icons.visibility,color: TopColors.blueGrey,)),
                       ),
                     )
                ],
              )),
            ],
          ),
        ));
  }
}

class _HomeHeaderMobile extends StatelessWidget {
  final bool loading;
  final String name;
  final double balance;
  final bool error;
  final bool visible;
  final VoidCallback onVisible;
  const _HomeHeaderMobile({required this.onVisible, required this.balance,required this.visible, required this.error,required this.loading,required this.name});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(

        width: size.width,
        color: TopColors.greyColor.withOpacity(.5),
        child: Column(
          children: [
            SizedBox(height: size.height *.05,),
            TopText(text: loading ? 'carregando' :'Olá, $name'),
            SizedBox(height: size.height *.02,),
            TopText(text:    "R\$ ${!visible? '*********' :balance.toStringAsFixed(2).replaceAll('.', ',')}",
            style: Theme.of(context).textTheme.headlineLarge,
            ),
             SizedBox(height: size.height *.01,),
              Padding(
               padding:  const EdgeInsets.only(right:8.0,bottom: 4),
               child:  Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: onVisible,
                  child:  Icon(!visible ? Icons.visibility_off : Icons.visibility,color: TopColors.blueGrey,)),
               ),
             )
            ],            
        ));
  }
}
