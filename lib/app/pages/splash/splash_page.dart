import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/repository/authentication_repository.dart';
import '../../../utils/app_routes.dart';
import '../../blocs/authententication/bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final bloc = Modular.get<AutheticationBloc>();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
     bloc.add(AuthenticationCurrentUserEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AutheticationBloc, AutheticationState>(
        bloc: bloc,
        listener: (context, state) {

          switch (state.status.status) {
            case StatusAuthentication.authentication:
              Navigator.of(context).pushNamed(AppRoutes.home);
              break;
            case StatusAuthentication.unauthentication:
              Navigator.of(context).pushNamed(AppRoutes.signin);
              break;
            case StatusAuthentication.signOut:
            case StatusAuthentication.unknow:
            case StatusAuthentication.error:
              break;
          }
        },
        builder: (context, state) {
          return  Center(
            child: Image.asset('assets/wallet.gif'),
          );
        },
      ),
    );
  }
}
