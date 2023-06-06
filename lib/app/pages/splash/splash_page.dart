import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

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

         
        },
        builder: (context, state) {
          return  Center(
            child: Image.asset('assets/wallet.gif',
            errorBuilder: (_,e,ee){
              return const SizedBox();
            },
            ),
          );
        },
      ),
    );
  }
}
