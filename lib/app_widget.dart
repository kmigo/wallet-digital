



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'app/blocs/authententication/bloc.dart';
import 'core/repository/authentication_repository.dart';
import 'utils/app_routes.dart';
import 'utils/context_global.dart';


class AppWidget extends StatefulWidget {
  const AppWidget({super.key});


  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final bloc = Modular.get<AutheticationBloc>();

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(AppRoutes.splash);
    Modular.setNavigatorKey(CustomNavigatorKey.key);
    return MaterialApp.router(
      title: "Wallet Digital",
      theme: ThemeData(primarySwatch: Colors.blue),
      builder: (context, child) {
        return BlocListener<AutheticationBloc,AutheticationState>(
          bloc: bloc,
          listener:(context,state){
          switch(state.status.status){
            case StatusAuthentication.unknow:
            case StatusAuthentication.authentication:
            break;
            case StatusAuthentication.unauthentication:

            bloc.add(AuthenticationSignOutEvent());
              break;
            case StatusAuthentication.signOut:
              Modular.to.pushNamedAndRemoveUntil(AppRoutes.signin, ModalRoute.withName(AppRoutes.splash));
              break;
            case StatusAuthentication.error:
              bloc.add(AuthenticationSignOutEvent());
              break;
            case StatusAuthentication.signup:
 Modular.to.pushNamedAndRemoveUntil(AppRoutes.home, ModalRoute.withName(AppRoutes.splash));
              break;
            case StatusAuthentication.signin:
              Modular.to.pushNamedAndRemoveUntil(AppRoutes.home, ModalRoute.withName(AppRoutes.splash));
              break;
          }
        } ,child: ScrollConfiguration(
          behavior: TopScroolBehavior(),
          child: child!));
      },
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      
      debugShowCheckedModeBanner: false,
    );
  }

}